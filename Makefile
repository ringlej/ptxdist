#
# $Id$
#
# Copyright (C) 2002-2004 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2002 by Jochen Striepe <ptxdist@tolot.escape.de>
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# For further information about the PTXdist project see the README file.
#

PROJECT			:= PTXdist
VERSION			:= 0
PATCHLEVEL		:= 7
SUBLEVEL		:= 7
EXTRAVERSION		:=-rc5

FULLVERSION		:= $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

export PROJECT VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION FULLVERSION

ifdef PTXDISTDIR
TOPDIR			:= $(PTXDISTDIR)
else
TOPDIR			:= $(shell pwd)
endif

#
# We build on a workspace, for example one for native, one for cross
#

ifndef PTXDISTWORKSPACE
PTXDISTWORKSPACE	:= $(TOPDIR)
endif

HOME			:= $(shell echo $$HOME)
PATCHDIR		:= $(TOPDIR)/patches
MISCDIR			:= $(TOPDIR)/misc
RULESDIR		:= $(TOPDIR)/rules

BUILDDIR		:= $(PTXDISTWORKSPACE)/build-target
CROSS_BUILDDIR		:= $(PTXDISTWORKSPACE)/build-cross
HOST_BUILDDIR		:= $(PTXDISTWORKSPACE)/build-host
STATEDIR		:= $(PTXDISTWORKSPACE)/state
IMAGEDIR		:= $(PTXDISTWORKSPACE)/images
ROOTDIR			:= $(PTXDISTWORKSPACE)/root

include $(TOPDIR)/rules/Definitions.make

ifeq (exists, $(shell test -e $(HOME)/.ptxdistrc && echo exists))
include $(HOME)/.ptxdistrc
else
include $(TOPDIR)/config/setup/ptxdistrc.default
endif

SRCDIR			:= $(call remove_quotes,$(PTXCONF_SETUP_SRCDIR))

# ----------------------------------------------------------------------------
# Setup a list of project directories
# ----------------------------------------------------------------------------

PROJECTDIRS		:= 
ifeq (exists, $(shell test -e $(PTXCONF_SETUP_PROJECTDIR1) && echo exists))
PROJECTDIRS		+= $(PTXCONF_SETUP_PROJECTDIR1)/
endif
ifeq (exists, $(shell test -e $(PTXCONF_SETUP_PROJECTDIR2) && echo exists))
PROJECTDIRS		+= $(PTXCONF_SETUP_PROJECTDIR2)/
endif
PROJECTDIRS		+= $(wildcard $(PTXDISTWORKSPACE)/project-*)


PROJECTCONFFILE		=  $(shell find $(PROJECTDIRS) -name $(PTXCONF_PROJECT).ptxconfig)
PROJECTDIR		=  $(strip $(shell test -z "$(PROJECTCONFFILE)" || dirname $(PROJECTCONFFILE)))
PROJECTRULES		=  $(wildcard $(PROJECTDIR)/rules/*.make)
PROJECTRULESDIR		=  $(PROJECTDIR)/rules
PROJECTPATCHDIR		=  $(PROJECTDIR)/patches

MENU			=  $(shell 						\
				if [ -e $(PROJECTDIR)/Kconfig ]; then		\
					echo $(PROJECTDIR)/Kconfig; 		\
				else 						\
					echo $(TOPDIR)/config/Kconfig; 		\
				fi						\
			   )

PACKAGES           =
CROSS_PACKAGES     =
HOST_PACKAGES      =
VIRTUAL            =

export TAR TOPDIR BUILDDIR ROOTDIR SRCDIR PTXSRCDIR STATEDIR HOST_PACKAGES CROSS_PACKAGES PACKAGES

all: help

-include $(PTXDISTWORKSPACE)/.config 

# FIXME: this should be removed some day...
PTXCONF_TARGET_CONFIG_FILE ?= none
ifeq ("", $(PTXCONF_TARGET_CONFIG_FILE))
PTXCONF_TARGET_CONFIG_FILE = none
endif
-include config/arch/$(call remove_quotes,$(PTXCONF_TARGET_CONFIG_FILE))
# /FIXME

include $(TOPDIR)/rules/Rules.make
include $(TOPDIR)/rules/Version.make

TMP_PROJECTRULES_IN = $(filter-out 					\
		$(TOPDIR)/rules/Virtual.make 		\
		$(TOPDIR)/rules/Rules.make 		\
		$(TOPDIR)/rules/Version.make 		\
		$(TOPDIR)/rules/Definitions.make,	\
		$(wildcard $(TOPDIR)/rules/*.make)	\
	) $(PROJECTRULES)

TMP_PROJECTRULES_FINAL = $(shell $(TOPDIR)/scripts/select_projectrules "$(TOPDIR)/rules" "$(PROJECTDIR)/rules" "$(TMP_PROJECTRULES_IN)")

include $(TMP_PROJECTRULES_FINAL)

include $(TOPDIR)/rules/Virtual.make

# install targets 
PACKAGES_TARGETINSTALL 	:= $(addsuffix _targetinstall,$(PACKAGES)) $(addsuffix _targetinstall,$(VIRTUAL))
PACKAGES_GET		:= $(addsuffix _get,$(PACKAGES))
PACKAGES_EXTRACT	:= $(addsuffix _extract,$(PACKAGES))
PACKAGES_PREPARE	:= $(addsuffix _prepare,$(PACKAGES))
PACKAGES_COMPILE	:= $(addsuffix _compile,$(PACKAGES))
HOST_PACKAGES_INSTALL	:= $(addsuffix _install,$(HOST_PACKAGES))
HOST_PACKAGES_GET	:= $(addsuffix _get,$(HOST_PACKAGES))
HOST_PACKAGES_EXTRACT	:= $(addsuffix _extract,$(HOST_PACKAGES))
HOST_PACKAGES_PREPARE	:= $(addsuffix _prepare,$(HOST_PACKAGES))
HOST_PACKAGES_COMPILE	:= $(addsuffix _compile,$(HOST_PACKAGES))
CROSS_PACKAGES_INSTALL	:= $(addsuffix _install,$(CROSS_PACKAGES))
CROSS_PACKAGES_GET	:= $(addsuffix _get,$(CROSS_PACKAGES))
CROSS_PACKAGES_EXTRACT	:= $(addsuffix _extract,$(CROSS_PACKAGES))
CROSS_PACKAGES_PREPARE	:= $(addsuffix _prepare,$(CROSS_PACKAGES))
CROSS_PACKAGES_COMPILE	:= $(addsuffix _compile,$(CROSS_PACKAGES))

# FIXME: this has to be reworked when the final usage was fixed
help:
	@echo
	@echo "PTXdist - Build System for Embedded Linux Systems"
	@echo
	@echo "Syntax:"
	@echo
	@echo "  make menuconfig              Configure the Root Filesystem"
	@echo "  make setup                   Setup PTXdist Preferences"
	@echo
	@echo "  make get                     Download (most) of the needed packets"
	@echo "  make extract                 Extract all needed archives"
	@echo "  make prepare                 Prepare the configured system for compilation"
	@echo "  make compile                 Compile the packages"
	@echo "  make install                 Install to rootdirectory"
	@echo "  make images                  Build root filesystem images"
	@echo "  make clean                   Remove everything but local/"
	@echo "  make rootclean               Remove root directory contents"
	@echo "  make distclean               Clean everything"
	@echo "  make svn-up                  Run "svn update" in topdir and project dir"
	@echo "  make svn-stat                Run "svn stat" in topdir and project dir"
	@echo
	@echo "  make world                   Make-everything-and-be-happy"
	@echo
	@echo "Some 'helpful' targets:"
	@echo
	@echo "  make configs                 show predefined configs"
	@echo
	@echo "Targets for testing:"
	@echo
	@echo "  make cuckoo-test             search for cuckoo-eggs in root system"
	@echo "  make compile-test            compile all supported targets, with report"
	@echo "  make config-test             run oldconfig on all ptxconfig files"
	@echo "  make ipkg-test               check if ipkg packets are consistent with ROOTDIR"
	@echo "  make toolchains              build all supported toolchains"
	@echo
	@echo "Targets for internal Quality Assurance:"
	@echo 
	@echo " make qa			      run qa checks from scripts/qa"
	@echo 


# FIXME: this is not fully working yet, do to dependencies being defined
# in make files and Kconfig files in a non-consistent way. 

get:     check_tools getclean $(PACKAGES_GET)
extract: check_tools $(PACKAGES_EXTRACT)
prepare: check_tools $(PACKAGES_PREPARE)
compile: check_tools $(PACKAGES_COMPILE)
install: check_tools $(PACKAGES_TARGETINSTALL)

dep_output_clean:
#	if [ -e $(DEP_OUTPUT) ]; then rm -f $(DEP_OUTPUT); fi
	touch $(DEP_OUTPUT)

dep_tree:
	@echo "Launching cuckoo-test"
	@scripts/cuckoo-test $(PTXCONF_ARCH) $(ROOTDIR) $(PTXCONF_COMPILER_PREFIX)
ifdef PTXCONF_IMAGE_IPKG
	@echo "Launching ipkg-test"
	@IMAGES=$(IMAGEDIR) ROOT=$(ROOTDIR) IPKG=$(PTXCONF_PREFIX)/bin/ipkg-cl  scripts/ipkg-test
endif
	@if dot -V 2> /dev/null; then \
		echo "creating dependency graph..."; \
		sort $(DEP_OUTPUT) | uniq | scripts/makedeptree | $(DOT) -Tps > $(DEP_TREE_PS); \
		if [ -x "`which poster`" ]; then \
			echo "creating A4 version..."; \
			poster -v -c0\% -mA4 -o$(DEP_TREE_A4_PS) $(DEP_TREE_PS); \
		fi;\
	else \
		echo "Install 'dot' from graphviz packet if you want to have a nice dependency tree"; \
	fi

dep_world: $(HOST_PACKAGES_INSTALL) \
	   $(CROSS_PACKAGES_INSTALL) \
	   $(PACKAGES_TARGETINSTALL)
	@echo $@ : $^ | sed  -e 's/\([^ ]*\)_\([^_]*\)/\1.\2/g' >> $(DEP_OUTPUT)

world: check_tools dep_output_clean dep_world $(BOOTDISK_TARGETINSTALL) dep_tree 

host-tools: check_tools dep_output_clean $(HOST_PACKAGES_INSTALL)  dep_tree
host-get:     check_tools getclean $(HOST_PACKAGES_GET) 
host-extract: check_tools $(HOST_PACKAGES_EXTRACT)
host-prepare: check_tools $(HOST_PACKAGES_PREPARE)
host-compile: check_tools $(HOST_PACKAGES_COMPILE)
host-install: check_tools $(HOST_PACKAGES_INSTALL)

cross-tools: check_tools dep_output_clean $(CROSS_PACKAGES_INSTALL)  dep_tree
cross-get:     check_tools getclean $(CROSS_PACKAGES_GET) 
cross-extract: check_tools $(CROSS_PACKAGES_EXTRACT)
cross-prepare: check_tools $(CROSS_PACKAGES_PREPARE)
cross-compile: check_tools $(CROSS_PACKAGES_COMPILE)
cross-install: check_tools $(CROSS_PACKAGES_INSTALL)

# Robert-is-faster-typing-than-thinking shortcut
owrld: world

# Images ----------------------------------------------------------------------

DOPERMISSIONS = '{	\
	if ($$1 == "f")	\
		printf("chmod %s .%s; chown %s.%s .%s;\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'

images: $(STATEDIR)/images

ipkg-push: images
	scripts/ipkg-push -i $(IMAGEDIR) -d $(PTXCONF_SETUP_IPKG_REPOSITORY)
	rm -f $(PTXCONF_SETUP_IPKG_REPOSITORY)/Packages
	PYTHONPATH=$(PTXCONF_PREFIX)/lib/python2.3/site-packages 		\
		$(PTXCONF_PREFIX)/bin/ipkg-make-index 				\
			-p $(PTXCONF_SETUP_IPKG_REPOSITORY)/Packages 		\
			$(PTXCONF_SETUP_IPKG_REPOSITORY)

ipkg-push-force: images
	scripts/ipkg-push -i $(IMAGEDIR) -d $(PTXCONF_SETUP_IPKG_REPOSITORY) -f 
	rm -f $(PTXCONF_SETUP_IPKG_REPOSITORY)/Packages
	PYTHONPATH=$(PTXCONF_PREFIX)/lib/python2.3/site-packages 		\
		$(PTXCONF_PREFIX)/bin/ipkg-make-index 				\
			-p $(PTXCONF_SETUP_IPKG_REPOSITORY)/Packages 		\
			$(PTXCONF_SETUP_IPKG_REPOSITORY)

$(STATEDIR)/images: world
ifdef PTXCONF_IMAGE_TGZ
	cd $(ROOTDIR); \
	($(AWK) -F: $(DOPERMISSIONS) $(TOPDIR)/permissions && \
	echo "tar -zcvf $(IMAGEDIR)/root.tgz . ") | $(FAKEROOT) --
endif
ifdef PTXCONF_IMAGE_JFFS2
ifdef PTXCONF_IMAGE_IPKG
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH $(TOPDIR)/scripts/make_image_root.sh	\
		-i $(IMAGEDIR)							\
		-p $(TOPDIR)/permissions					\
		-e $(PTXCONF_IMAGE_JFFS2_BLOCKSIZE)				\
		-j $(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS)				\
		-o $(IMAGEDIR)/root.jffs2
else
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH $(TOPDIR)/scripts/make_image_root.sh	\
		-r $(ROOTDIR)							\
		-p $(TOPDIR)/permissions					\
		-e $(PTXCONF_IMAGE_JFFS2_BLOCKSIZE)				\
		-j $(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS)				\
		-o $(IMAGEDIR)/root.jffs2
endif
endif
ifdef PTXCONF_IMAGE_HD
	$(TOPDIR)/scripts/genhdimg \
	-m $(GRUB_DIR)/stage1/stage1 \
	-n $(GRUB_DIR)/stage2/stage2 \
	-r $(ROOTDIR) \
	-i images \
	-f $(PTXCONF_IMAGE_HD_CONF)
endif
ifdef PTXCONF_IMAGE_EXT2
	cd $(ROOTDIR); \
	($(AWK) -F: $(DOPERMISSIONS) $(TOPDIR)/permissions && \
	( \
		echo -n "$(PTXCONF_HOST_PREFIX)/bin/genext2fs "; \
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) "; \
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) "; \
		echo -n "-d $(ROOTDIR) "; \
		echo "$(IMAGEDIR)/root.ext2" ) \
	) | $(FAKEROOT) --
endif
ifdef PTXCONF_IMAGE_EXT2_GZIP
	rm -f $(IMAGEDIR)/root.ext2.gz
	gzip -v9 $(IMAGEDIR)/root.ext2
endif
ifdef PTXCONF_IMAGE_UIMAGE
	$(PTXCONF_PREFIX)/bin/u-boot-mkimage \
		-A $(PTXCONF_ARCH) \
		-O Linux \
		-T ramdisk \
		-C gzip \
		-n $(PTXCONF_IMAGE_UIMAGE_NAME) \
		-d  $(IMAGEDIR)/root.ext2.gz \
		$(IMAGEDIR)/uRamdisk
endif
	touch $@

# Configuration system -------------------------------------------------------

ptx_lxdialog:
	@echo -e "#include \"ncurses.h\"\nint main(void){}" | gcc -E - > /dev/null; 	\
	if [ "$$?" = "1" ]; then							\
		echo;									\
		echo "Error: you don't seem to have ncurses.h; this probably means"; 	\
		echo "       that you'll have to install some ncurses-devel packet";	\
		echo "       from your distribution.";					\
		echo;									\
		exit 1;									\
	fi
	cd $(TOPDIR)/scripts/lxdialog && ln -s -f ../ptx-modifications/Makefile.lxdialog.ptx Makefile

$(TOPDIR)/scripts/lxdialog/lxdialog: ptx_lxdialog
	make -C $(TOPDIR)/scripts/lxdialog lxdialog

$(TOPDIR)/scripts/kconfig/libkconfig.so:
	make -C $(TOPDIR)/scripts/kconfig libkconfig.so

$(TOPDIR)/scripts/kconfig/conf: $(TOPDIR)/scripts/kconfig/libkconfig.so
	make -C $(TOPDIR)/scripts/kconfig conf

$(TOPDIR)/scripts/kconfig/mconf: $(TOPDIR)/scripts/kconfig/libkconfig.so
	make -C $(TOPDIR)/scripts/kconfig mconf

$(TOPDIR)/scripts/kconfig/qconf: $(TOPDIR)/scripts/kconfig/libkconfig.so
	make -C $(TOPDIR)/scripts/kconfig qconf

$(TOPDIR)/scripts/kconfig/gconf: $(TOPDIR)/scripts/kconfig/libkconfig.so
	make -C $(TOPDIR)/scripts/kconfig gconf

before_config:
	[ -e "$(PTXDISTWORKSPACE)/config" ]  || ln -sf $(TOPDIR)/config  $(PTXDISTWORKSPACE)/config
	[ -e "$(PTXDISTWORKSPACE)/rules" ]   || ln -sf $(TOPDIR)/rules   $(PTXDISTWORKSPACE)/rules
	[ -e "$(PTXDISTWORKSPACE)/scripts" ] || ln -sf $(TOPDIR)/scripts $(PTXDISTWORKSPACE)/scripts

menuconfig: before_config $(TOPDIR)/scripts/lxdialog/lxdialog $(TOPDIR)/scripts/kconfig/mconf
	$(call findout_config)
	cd $(PTXDISTWORKSPACE) && $(TOPDIR)/scripts/kconfig/mconf $(MENU)

xconfig: before_config $(TOPDIR)/scripts/kconfig/qconf
	$(call findout_config)
	cd $(PTXDISTWORKSPACE) && $(TOPDIR)/scripts/kconfig/qconf $(MENU)

gconfig: before_config $(TOPDIR)/scripts/kconfig/gconf
	$(call findout_config)
	LD_LIBRARY_PATH=$(TOPDIR)/scripts/kconfig cd $(PTXDISTWORKSPACE) && $(TOPDIR)/scripts/kconfig/gconf $(MENU)

oldconfig: before_config $(TOPDIR)/scripts/kconfig/conf
	$(call findout_config)
	cd $(PTXDISTWORKSPACE) && $(TOPDIR)/scripts/kconfig/conf -o $(MENU)

setup: $(TOPDIR)/scripts/lxdialog/lxdialog $(TOPDIR)/scripts/kconfig/mconf
	@rm -f $(TOPDIR)/config/setup/.config
	@ln -sf $(TOPDIR)/scripts $(TOPDIR)/config/setup/scripts
	@if [ -f $(HOME)/.ptxdistrc ]; then cp $(HOME)/.ptxdistrc $(TOPDIR)/config/setup/.config; fi
	@(cd $(TOPDIR)/config/setup && $(TOPDIR)/scripts/kconfig/mconf Kconfig)
	@echo "cleaning up after setup..."
	@for i in .tmpconfig.h .config.old .config.cmd; do			\
		rm -f $(TOPDIR)/config/setup/$$i; 				\
	done
	@if [ -f $(TOPDIR)/config/setup/.config ]; then 			\
		echo "copying new .ptxdistrc to $(HOME)...";			\
		cp $(TOPDIR)/config/setup/.config $(HOME)/.ptxdistrc; 		\
		echo "done.";							\
	fi

# Config Targets -------------------------------------------------------------

%_config:
	@echo; \
	echo "[Searching for Config File:]"; 						\
	CFG="`find $(PROJECTDIRS) -name $(subst _config,.ptxconfig,$@) 2> /dev/null`";	\
	if [ `echo $$CFG | wc -w` -gt 1 ]; then						\
		echo "ERROR: more than one config file found:"; 		\
		echo $$CFG; echo; 						\
		exit 1;								\
	fi;									\
	if [ -n "$$CFG" ]; then 						\
		echo "config file: \"$$CFG\""; 					\
		cp $$CFG $(PTXDISTWORKSPACE)/.config; 				\
		echo "workspace:   \"$(PTXDISTWORKSPACE)\"";			\
	else 									\
		echo "could not find config file \"$@\""; 			\
		exit 1;								\
	fi; 									\
	echo

# Test -----------------------------------------------------------------------

config-test: 
	@for i in `find $(PROJECTDIRS) -name "*.ptxconfig"`; do 	\
		OUT=`basename $$i`;					\
		$(call targetinfo,$$OUT);				\
		cp $$i .config;						\
		make oldconfig;						\
		cp .config $$i;						\
	done

default_crosstool=/opt/crosstool-0.28-rc37

compile-test:
	cd $(TOPDIR); 							\
	rm -f COMPILE-TEST;						\
	echo "Automatic Compilation Test" >> COMPILE-TEST;		\
	echo "--------------------------" >> COMPILE-TEST;		\
	echo >> COMPILE-TEST;						\
	echo start: `date` >> COMPILE-TEST;				\
	echo >> COMPILE-TEST;						\
	scripts/compile-test $(default_crosstool)/i586-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin abbcc-viac3        COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/i586-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin i586-generic-glibc COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/i586-unknown-linux-gnu/gcc-2.95.3-glibc-2.2.5/bin frako             COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/i586-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin visbox             COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/i586-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin rayonic-i586       COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-2.95.3-glibc-2.2.5/bin innokom-2.4-2.95 COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin innokom-2.4-3.3.3 COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin mx1fs2            COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin pii_nge           COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin ssv_pnp2110_eva1  COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/powerpc-604-linux-gnu/gcc-3.4.1-glibc-2.3.3/bin eb8245              COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/powerpc-405-linux-gnu/gcc-3.2.3-glibc-2.2.5/bin cameron-efco        COMPILE-TEST;\
	echo >> COMPILE-TEST;						\
	echo stop: `date` >> COMPILE-TEST;				\
	echo >> COMPILE-TEST;

cuckoo-test: world
	@scripts/cuckoo-test $(PTXCONF_ARCH) $(ROOTDIR) $(PTXCONF_COMPILER_PREFIX)

ipkg-test: world
	@IMAGES=$(IMAGEDIR) ROOT=$(ROOTDIR) IPKG=$(PTXCONF_PREFIX)/bin/ipkg-cl  scripts/ipkg-test

# ----------------------------------------------------------------------------

toolchains:
	cd $(TOPDIR); 							\
	rm -f TOOLCHAINS;						\
	echo "Automatic Toolchain Compilation" >> TOOLCHAINS;		\
	echo "--------------------------" >> TOOLCHAINS;		\
	echo >> TOOLCHAINS;						\
	echo start: `date` >> TOOLCHAINS;				\
	echo >> TOOLCHAINS;						\
	scripts/compile-test /usr/bin toolchain_arm-softfloat-linux-gnu-2.95.3_glibc_2.2.5     TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_arm-softfloat-linux-gnu-3.3.3_glibc_2.3.2      TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_arm-softfloat-linux-uclibc-3.3.3_uClibc-0.9.27 TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_i586-unknown-linux-gnu-2.95.3_glibc-2.2.5      TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_i586-unknown-linux-gnu-3.4.2_glibc-2.3.3       TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_i586-unknown-linux-uclibc-3.3.3_uClibc-0.9.27  TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_m68k-unknown-linux-uclibc-3.3.3_uClibc-0.9.27  TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_powerpc-405-linux-gnu-3.2.3_glibc-2.2.5        TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_powerpc-604-linux-gnu-3.4.1_glibc-2.3.3        TOOLCHAINS;\
	echo >> TOOLCHAINS;						\
	echo stop: `date` >> TOOLCHAINS;				\
	echo >> TOOLCHAINS;

# ----------------------------------------------------------------------------

qa:
	@cd $(TOPDIR);							\
	rm -f QA.log;							\
	echo "Automatic Internal QA Check" >> QA.log;			\
	echo start: `date` >> QA.log;                    		\
	scripts/qa/master >> QA.log 2>&1;				\
	echo stop: `date` >> QA.log;                                    \
	echo >> QA.log;
	@cat QA.log;

maintainer-clean: distclean
	@echo -n "cleaning logs.................... "
	@rm -f logs/*
	@echo "done."

distclean: clean
	@echo -n "cleaning .config, .kernelconfig.. "
	@cd $(PTXDISTWORKSPACE) && rm -f .config* .kernelconfig .tmp* .rtaiconfig 
	@cd $(TOPDIR) && rm -f config/setup/scripts config/setup/.config scripts/scripts
	@echo "done."
	@echo -n "cleaning logs.................... "
	@rm -fr $(TOPDIR)/logs/root-orig.txt $(TOPDIR)/logs/root-ipkg.txt $(TOPDIR)/logs/root.diff
	@echo "done."
	@echo

clean: rootclean imagesclean
	@echo
	@echo -n "cleaning state dir............... "
	@for i in $(wildcard $(STATEDIR)/*); do rm -rf $$i; done
	@echo "done."
	@echo -n "cleaning build dir............... "
	@for i in $(wildcard $(BUILDDIR)/*); do 			\
		echo -n $$i; 						\
		rm -rf $$i; 						\
		echo; echo -n "                                  ";	\
	done
	@echo "done."
	@for i in $(wildcard $(HOST_BUILDDIR)/*); do 			\
		echo -n $$i; 						\
		rm -rf $$i; 						\
		echo; echo -n "                                  ";	\
	done
	@echo "done."
	@for i in $(wildcard $(CROSS_BUILDDIR)/*); do 			\
		echo -n $$i; 						\
		rm -rf $$i; 						\
		echo; echo -n "                                  ";	\
	done
	@echo "done."
	@echo -n "cleaning scripts dir............. "
	@make -s -C $(TOPDIR)/scripts/kconfig clean
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.lxdialog.ptx -C $(TOPDIR)/scripts/lxdialog clean
	@rm -f scripts/lxdialog/Makefile
	@echo "done."
	@echo -n "cleaning dependency tree ........ "
	@rm -f $(DEP_OUTPUT) $(DEP_TREE_PS) $(DEP_TREE_A4_PS)
	@echo "done."
	@echo -n "cleaning logfile................. "
	@rm -f logfile* 
	@echo "done."
	@echo -n "cleaning local dir............... "
	@rm -fr local
	@echo "done."
	@if [ -d $(TOPDIR)/Documentation/manual ]; then		\
		echo -n "cleaning manual.................. ";	\
		make -C $(TOPDIR)/Documentation/manual clean > /dev/null;	\
		echo "done.";					\
	fi;
	@echo

rootclean: imagesclean
	@echo
	@echo -n "cleaning root dir................ "
	@rm -fr $(ROOTDIR)
	@mkdir $(ROOTDIR)
	@echo "done."
	@echo -n "cleaning state/*.targetinstall... "
	@rm -f $(STATEDIR)/*.targetinstall
	@echo "done."	
	@echo -n "cleaning permissions...           "
	@rm -f $(TOPDIR)/permissions
	@echo "done."
	@echo

getclean:
	@echo
	@echo -n "cleaning state/*.get............. "
	@rm -f $(STATEDIR)/*.get
	@echo "done."
	@echo

imagesclean:
	@echo -n "cleaning images dir.............. "
	@rm -fr $(IMAGEDIR)
	@mkdir $(IMAGEDIR)
	@rm -f $(STATEDIR)/images
	@echo "done."

svn-up:
	@$(call targetinfo, Updating in Toplevel)
	@cd $(TOPDIR) && svn update
	@if [ -d "$(PROJECTDIR)" ]; then				\
		$(call targetinfo, Updating in PROJECTDIR);		\
		cd $(PROJECTDIR);					\
		[ -d .svn ] && svn update; 				\
	fi;
	@echo "done."

svn-stat:
	@$(call targetinfo, svn stat in Toplevel)
	@cd $(TOPDIR) && svn stat
	@if [ -d "$(PROJECTDIR)" ]; then				\
		$(call targetinfo, svn stat in PROJECTDIR);		\
		cd $(PROJECTDIR);					\
		[ -d .svn ] && svn stat; 				\
	fi;
	@echo "done."

archive:  
	@echo
	@echo -n "packaging additional sources ...... "
	scripts/collect_sources.sh $(TOPDIR) $(shell basename $(TOPDIR))

archive-toolchain: virtual-xchain_install
	$(TAR) -C $(PTXCONF_PREFIX)/.. -jcvf $(TOPDIR)/$(PTXCONF_GNU_TARGET).tar.bz2 \
		$(shell basename $(PTXCONF_PREFIX))

.PHONY: projects
projects:
	@for dir in $(call remove_quotes,$(PROJECTDIRS)); do 						\
		(cd $$dir); 										\
		if [ "$$?" != "0" ]; then								\
			echo;										\
			echo "Error: PTXCONF_SETUP_PROJECTDIR macros point to something which";		\
			echo "       is no directory. Check your .ptxdistrc file. ";			\
			echo;										\
			echo "Directory: $$dir";							\
			echo;										\
			exit 1;										\
		fi											\
	done
	@echo
	@echo "---------------------- Available PTXdist Projects: ----------------------------"
	@echo
	@for i in `find $(PROJECTDIRS) -name "*.ptxconfig"`; do 					\
		basename `echo $$i | perl -p -e "s/.ptxconfig/_config/g"`; 				\
	done | sort 
	@echo
	@echo "-------------------------------------------------------------------------------"
	@echo

configs:
	@echo
	@echo "Please use 'make projects' instead of 'make configs'. Thanks."
	@echo

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

print-%:
	@echo "$* is \"$($*)\""

%_recompile:
	@rm -f $(STATEDIR)/$*.compile
	@make -C $(TOPDIR) $*_compile

.PHONY: dep_output_clean dep_tree dep_world
# vim600:set foldmethod=marker:

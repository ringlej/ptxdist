#
# $Id$
#
# Copyright (C) 2002-2004 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2002 by Jochen Striepe <ptxdist@tolot.escape.de>
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# For further information about the PTXdist project see the README file.
#

PROJECT		:= PTXdist
VERSION		:= 0
PATCHLEVEL	:= 7
SUBLEVEL	:= 1
EXTRAVERSION	:=-cvs

FULLVERSION	:= $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

export PROJECT VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION FULLVERSION

TOPDIR			:= $(shell pwd)
BASENAME		:= $(shell basename $(TOPDIR))
BUILDDIR		:= $(TOPDIR)/build
XCHAIN_BUILDDIR		:= $(BUILDDIR)/xchain
HOSTTOOLS_BUILDDIR	:= $(BUILDDIR)/hosttools
PATCHES_BUILDDIR	:= $(BUILDDIR)/patches
SRCDIR			:= $(TOPDIR)/src
PATCHDIR		:= $(TOPDIR)/patches
STATEDIR		:= $(TOPDIR)/state
BOOTDISKDIR		:= $(TOPDIR)/bootdisk
IMAGEDIR		:= $(TOPDIR)/images
MISCDIR			:= $(TOPDIR)/misc
PROJECTDIRS		:= $(TOPDIR)/projects $(TOPDIR)/../ptxdist-projects/$(BASENAME)
PROJECTCONFFILE		=  $(shell find $(PROJECTDIRS) -name $(PTXCONF_PROJECT).ptxconfig)
PROJECTDIR		=  $(shell test -z "$(PROJECTCONFFILE)" || dirname $(PROJECTCONFFILE))

# Pengutronix Patch Repository
PTXPATCH_URL		:= http://www.pengutronix.de/software/ptxdist/patches

PACKAGES	=
XCHAIN		=
VIRTUAL		=
HOSTTOOLS	=
VENDORTWEAKS	=

export TAR TOPDIR BUILDDIR ROOTDIR SRCDIR PTXSRCDIR STATEDIR PACKAGES HOSTTOOLS VENDORTWEAKS

all: help

-include .config 

include rules/Definitions.make

ROOTDIR=$(call remove_quotes,$(PTXCONF_ROOT))
ifeq ("", $(PTXCONF_ROOT))
ROOTDIR=$(TOPDIR)/root
endif
ifndef PTXCONF_ROOT
ROOTDIR=$(TOPDIR)/root
endif

PTXCONF_TARGET_CONFIG_FILE ?= none
ifeq ("", $(PTXCONF_TARGET_CONFIG_FILE))
PTXCONF_TARGET_CONFIG_FILE = none
endif
-include config/arch/$(call remove_quotes,$(PTXCONF_TARGET_CONFIG_FILE))

include rules/Rules.make
include rules/Version.make

include $(filter-out rules/Virtual.make rules/Rules.make rules/Version.make rules/Definitions.make,$(wildcard rules/*.make))
include rules/Virtual.make

# if specified, include vendor tweak makefile (run at the end of build)
# rewrite variable to make the magic in 'world' target work

PTXCONF_VENDORTWEAKS ?= none
ifeq ("", $(PTXCONF_VENDORTWEAKS))
PTXCONF_VENDORTWEAKS =  none
endif
-include $(call remove_quotes,$(PTXCONF_VENDORTWEAKS))

# install targets 
PACKAGES_TARGETINSTALL 		:= $(addsuffix _targetinstall,$(PACKAGES)) $(addsuffix _targetinstall,$(VIRTUAL))
PACKAGES_GET			:= $(addsuffix _get,$(PACKAGES)) $(addsuffix _get,$(XCHAIN))
PACKAGES_EXTRACT		:= $(addsuffix _extract,$(PACKAGES))
PACKAGES_PREPARE		:= $(addsuffix _prepare,$(PACKAGES))
PACKAGES_COMPILE		:= $(addsuffix _compile,$(PACKAGES))
HOSTTOOLS_INSTALL		:= $(addsuffix _install,$(HOSTTOOLS))

VENDORTWEAKS_TARGETINSTALL	:= $(addsuffix _targetinstall,$(VENDORTWEAKS))

BOOTDISK_TARGETINSTALL = 
ifeq (y, $(PTXCONF_BOOTDISK))
BOOTDISK_TARGETINSTALL += $(STATEDIR)/bootdisk.targetinstall
endif

help:
	@echo
	@echo "PTXdist - Build System for Embedded Linux Systems"
	@echo
	@echo "Syntax:"
	@echo
	@echo "  make menuconfig              Configure the whole system"
	@echo
	@echo "  make get                     Download (most) of the needed packets"
	@echo "  make extract                 Extract all needed archives"
	@echo "  make prepare                 Prepare the configured system for compilation"
	@echo "  make compile                 Compile the packages"
	@echo "  make install                 Install to rootdirectory"
	@echo "  make clean                   Remove everything but local/"
	@echo "  make rootclean               Remove root directory contents"
	@echo "  make distclean               Clean everything"
	@echo
	@echo "  make world                   Make-everything-and-be-happy"
	@echo
	@echo "Some 'helpful' targets:"
	@echo
	@echo "  make virtual-xchain_install  build the toolchain only"
	@echo "  make archive-toolchain       dito, but do also create a tarball"
	@echo "  make configs                 show predefined configs"
	@echo
	@echo "Targets for testing:"
	@echo
	@echo "  make cuckoo-test             search for cuckoo-eggs in root system"
	@echo "  make compile-test            compile all supported targets, with report"
	@echo "  make config-test             run oldconfig on all ptxconfig files"
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
	@if dot -V 2> /dev/null; then \
		sort $(DEP_OUTPUT) | uniq | scripts/makedeptree | $(DOT) -Tps > $(DEP_TREE_PS); \
	else \
		echo "Install 'dot' from graphviz packet if you want to have a nice dependency tree"; \
	fi

skip_vendortweaks:
	@echo "Vendor-Tweaks file $(PTXCONF_VENDORTWEAKS) does not exist, skipping."

dep_world: $(HOSTTOOLS_INSTALL) $(PACKAGES_TARGETINSTALL) $(VENDORTWEAKS_TARGETINSTALL)
	@echo $@ : $^ | sed -e "s/_/./g" >> $(DEP_OUTPUT)

world: check_tools dep_output_clean dep_world $(BOOTDISK_TARGETINSTALL) dep_tree 

# Images ----------------------------------------------------------------------

DOPERMISSIONS = '{	\
	if ($$1 == "f")	\
		printf("chmod %s .%s; chown %s.%s .%s;\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'

images: $(STATEDIR)/images

$(STATEDIR)/images:
ifdef PTXCONF_IMAGE_TGZ
	cd $(ROOTDIR); \
	($(AWK) -F: $(DOPERMISSIONS) $(TOPDIR)/permissions && \
	echo "tar -zcvf $(TOPDIR)/images/root.tgz . ") | $(FAKEROOT) --
endif
ifdef PTXCONF_IMAGE_JFFS2
	cd $(ROOTDIR); \
	($(AWK) -F: $(DOPERMISSIONS) $(TOPDIR)/permissions && \
	( \
		echo -n "$(PTXCONF_PREFIX)/bin/mkfs.jffs2 -d $(ROOTDIR) "; \
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo -n "$(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS) "; \
		echo "-o $(TOPDIR)/images/root.jffs2" ) \
	) | $(FAKEROOT) --
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
		echo -n "$(PTXCONF_PREFIX)/bin/genext2fs "; \
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) "; \
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) "; \
		echo -n "-d $(ROOTDIR) "; \
		echo "$(TOPDIR)/images/root.ext2" ) \
	) | $(FAKEROOT) --
endif
ifdef PTXCONF_IMAGE_EXT2_GZIP
	rm -f $(TOPDIR)/images/root.ext2.gz
	gzip -v9 $(TOPDIR)/images/root.ext2
endif
ifdef PTXCONF_IMAGE_UIMAGE
	$(PTXCONF_PREFIX)/bin/u-boot-mkimage \
		-A $(PTXCONF_ARCH) \
		-O Linux \
		-T ramdisk \
		-C gzip \
		-n $(PTXCONF_IMAGE_UIMAGE_NAME) \
		-d  $(TOPDIR)/images/root.ext2.gz \
		$(TOPDIR)/images/uRamdisk
endif
	touch $@

# Configuration system -------------------------------------------------------

ptx_lxdialog:
	cd scripts/lxdialog && ln -s -f ../ptx-modifications/Makefile.lxdialog.ptx Makefile

scripts/lxdialog/lxdialog: ptx_lxdialog
	make -C scripts/lxdialog lxdialog

scripts/kconfig/libkconfig.so:
	make -C scripts/kconfig libkconfig.so

scripts/kconfig/conf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig conf

scripts/kconfig/mconf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig mconf

scripts/kconfig/qconf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig qconf

scripts/kconfig/gconf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig gconf

menuconfig: scripts/lxdialog/lxdialog scripts/kconfig/mconf
	scripts/kconfig/mconf config/Kconfig

xconfig: scripts/kconfig/qconf
	scripts/kconfig/qconf config/Kconfig

gconfig: scripts/kconfig/gconf
	LD_LIBRARY_PATH=./scripts/kconfig ./scripts/kconfig/gconf config/Kconfig

oldconfig: scripts/kconfig/conf
	scripts/kconfig/conf -o config/Kconfig

# Config Targets -------------------------------------------------------------

%_config:
	@echo; \
	echo "[Searching for Config File:]"; 					\
	CFG="`find $(PROJECTDIRS) -name $(subst _config,.ptxconfig,$@)`";	\
	if [ `echo $$CFG | wc -w` -gt 1 ]; then					\
		echo "ERROR: more than one config file found:"; 		\
		echo $$CFG; echo; 						\
		exit 1;								\
	fi;									\
	if [ -n "$$CFG" ]; then 						\
		echo "using config file \"$$CFG\""; 				\
		cp $$CFG $(TOPDIR)/.config; 					\
	else 									\
		echo "could not find config file \"$@\""; 			\
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
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.2-glibc-2.3.2/bin innokom-2.4-3.3.2 COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin mx1fs2            COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin pii_nge           COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/bin ssv_pnp2110_eva1  COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/powerpc-604-linux-gnu/gcc-3.4.1-glibc-2.3.3/bin eb8245              COMPILE-TEST;\
	scripts/compile-test $(default_crosstool)/powerpc-405-linux-gnu/gcc-3.2.3-glibc-2.2.5/bin cameron-efco        COMPILE-TEST;\
	echo >> COMPILE-TEST;						\
	echo stop: `date` >> COMPILE-TEST;				\
	echo >> COMPILE-TEST;

#	# FIXME: doesn't work right now...
#	scripts/compile-test $(default_crosstool)/arm-softfloat-linux-gnu/gcc-3.3.2-glibc-2.3.2/bin innokom-2.6-3.3.2;		\

cuckoo-test: world
	@scripts/cuckoo-test $(PTXCONF_ARCH) root $(PTXCONF_COMPILER_PREFIX)

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
	scripts/compile-test /usr/bin toolchain-powerpc-405                                    TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_powerpc-405-linux-gnu-3.2.3_glibc-2.2.5        TOOLCHAINS;\
	scripts/compile-test /usr/bin toolchain_powerpc-604-linux-gnu-3.4.1_glibc-2.3.3        TOOLCHAINS;\
	echo >> TOOLCHAINS;						\
	echo stop: `date` >> TOOLCHAINS;				\
	echo >> TOOLCHAINS;

# ----------------------------------------------------------------------------

distclean: clean
	@echo -n "cleaning .config, .kernelconfig.. "
	@rm -f .config* .kernelconfig .tmp* .rtaiconfig
	@echo "done."
	@echo -n "cleaning patches dir............. "
	@rm -rf $(TOPDIR)/patches/*
	@echo "done."	
	@echo -n "cleaning feature patches dir..... "
	@rm -fr $(TOPDIR)/feature-patches/*
	@echo "done."
	@echo

clean: rootclean imagesclean
	@echo
	@echo -n "cleaning build dir............... "
	@for i in $$(ls -I CVS $(BUILDDIR)); do 			\
		echo -n $$i; 						\
		rm -rf $(BUILDDIR)/"$$i"; 				\
		echo; echo -n "                                  ";	\
	done
	@echo "done."
	@echo -n "cleaning feature-patch dir....... "
	@for i in $$(ls -I CVS $(TOPDIR)/feature-patches/); do rm -rf $(TOPDIR)/feature-patches/"$$i"; done
	@echo "done."
	@echo -n "cleaning state dir............... "
	@for i in $$(ls -I CVS $(STATEDIR)); do rm -rf $(STATEDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning scripts dir............. "
	@make -s -C scripts/kconfig clean
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.lxdialog.ptx -C scripts/lxdialog clean
	@rm -f scripts/lxdialog/Makefile
	@echo "done."
	@echo -n "cleaning bootdisk image.......... "
	@rm -f $(TOPDIR)/bootdisk/boot.*
	@echo "done."
	@echo -n "cleaning dependency tree ........ "
	@rm -f $(DEP_OUTPUT) $(DEP_TREE_PS)
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

rootclean:
	@echo
	@echo -n "cleaning root dir................ "
	@if [ -d $(ROOTDIR) ]; then \
		for i in $$(ls -I CVS $(ROOTDIR)); do 			\
			echo -n $$i; 					\
			rm -rf $(ROOTDIR)/"$$i"; 			\
			echo; 						\
			echo -n "                                  ";	\
		done; 							\
	fi
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
	@for i in $$(ls -I CVS $(TOPDIR)/images); do echo -n $$i' '; rm -fr $(TOPDIR)/images/"$$i"; done
	@rm -f $(STATEDIR)/images
	@echo "done."

archive:  
	@echo
	@echo -n "packaging additional sources ...... "
	scripts/collect_sources.sh $(TOPDIR) $(BASENAME)

archive-toolchain: virtual-xchain_install
	$(TAR) -C $(PTXCONF_PREFIX)/.. -jcvf $(TOPDIR)/$(PTXCONF_GNU_TARGET).tar.bz2 \
		$(shell basename $(PTXCONF_PREFIX))

configs:
	@echo
	@echo "------------------ Available PTXdist vanilla configurations: ------------------"
	@echo
	@for i in `find projects -name "*.ptxconfig"`; do 				\
		basename `echo $$i | perl -p -e "s/.ptxconfig/_config/g"`; 		\
	done | sort 
	@echo
	@if [ -d "$(TOPDIR)/../ptxdist-projects/$(BASENAME)" ]; then					\
		echo "------------------- Available PTXdist local configurations: -------------------"; \
		echo; 											\
		for i in `find $(TOPDIR)/../ptxdist-projects/$(BASENAME) -name "*.ptxconfig"`; do	\
			basename `echo $$i | perl -p -e "s/.ptxconfig/_config/g"`; 	\
		done | sort;								\
		echo; 									\
	fi; 
	@echo "-------------------------------------------------------------------------------"
	@echo

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

print-%:
	@echo "$* is \"$($*)\""

%_recompile:
	@rm -f $(STATEDIR)/$*.compile
	@make -C $(TOPDIR) $*_compile

.PHONY: dep_output_clean dep_tree dep_world skip_vendortweaks
# vim600:set foldmethod=marker:

# -*-makefile-*-
#
# $Id: Makefile 4495 2006-02-02 16:01:56Z rsc $
#
# Copyright (C) 2002-2006 by The PTXdist Team - See CREDITS for Details
#

#
# TODO:
#
# - We only support out-of-tree since 0.10; so the location of the
#   makefile is always known. And OUTOFTREE is always true.
#
# - Should we allow only src/ in the work dir for sources?
#
# - Find out what to do with PREFIX / PTXCONF_PREFIX; Sysroot?
#   take care of toolchain requirements
#

# make sure bash is used to execute commands from makefiles

SHELL=bash
export SHELL

# This makefile is called with PTXDIST_TOPDIR set to the PTXdist
# toplevel installation directory. So we first source the static
# definitions to inherit everything the ptxdist shellscript know:

include ${PTXDIST_TOPDIR}/scripts/ptxdist_version.sh

# The .ptxdistrc contains the per-user settings

ifneq ($(wildcard $(HOME)/.ptxdistrc.$(FULLVERSION)),)
include $(HOME)/.ptxdistrc.$(FULLVERSION)
else
include $(PTXDIST_TOPDIR)/config/setup/ptxdistrc.default
endif

# ----------------------------------------------------------------------------
# Some directory locations
# ----------------------------------------------------------------------------

HOME			:= $(shell echo $$HOME)
PTXDIST_WORKSPACE	:= $(shell pwd)

include $(PTXDIST_TOPDIR)/scripts/ptxdist_vars.sh

include $(RULESDIR)/other/Definitions.make

ifeq ($(call remove_quotes,$(PTXCONF_SETUP_SRCDIR)),)
SRCDIR			:= $(PTXDIST_WORKSPACE)/src
else
#			  don't use := here!!!
SRCDIR			= $(call remove_quotes,$(PTXCONF_SETUP_SRCDIR))
endif

#export HOME PTXDIST_WORKSPACE PTXDIST_TOPDIR
#export PATCHDIR RULESDIR BUILDDIR CROSS_BUILDDIR
#export HOST_BUILDDIR STATEDIR IMAGEDIR ROOTDIR SRCDIR

-include $(PTXDIST_WORKSPACE)/platformconfig
-include $(PTXDIST_WORKSPACE)/ptxconfig

# ----------------------------------------------------------------------------
# Packets for host, cross and target
# ----------------------------------------------------------------------------

# clean these variables (they may be set from earlier runs during recursion)

PACKAGES		:=
PACKAGES-y		:=
CROSS_PACKAGES		:=
CROSS_PACKAGES-y	:=
HOST_PACKAGES		:=
HOST_PACKAGES-y		:=
VIRTUAL			:=


# ----------------------------------------------------------------------------
# PTXCONF_PREFIX can be overwritten from the make var PREFIX
# FIXME: rsc: this needs to be migrated to DESTDIR, because it's not PREFIX!
# ----------------------------------------------------------------------------

ifdef PREFIX
PTXCONF_PREFIX	:= $(PREFIX)
PREFIX		:=
endif

# ----------------------------------------------------------------------------
# Include all rule files
# ----------------------------------------------------------------------------

all:
	@echo "ptxdist: error: please use ptxdist instead of calling make directly."
	@exit 1

include $(RULESDIR)/other/Namespace.make
include $(wildcard $(PRERULESDIR)/*.make)

ifneq ($(wildcard $(PROJECTPRERULESDIR)/*.make),)
include $(wildcard $(PROJECTPRERULESDIR)/*.make)
endif

include $(PACKAGE_DEP_PRE)
include $(RULESFILES_ALL_MAKE)
include $(PACKAGE_DEP_POST)

ifneq ($(wildcard $(POSTRULESDIR)/*.make),)
include $(wildcard $(POSTRULESDIR)/*.make)
endif

PACKAGES		:= $(PACKAGES-y)
CROSS_PACKAGES		:= $(CROSS_PACKAGES-y)
HOST_PACKAGES		:= $(HOST_PACKAGES-y)
VIRTUAL			:= $(VIRTUAL-y)

ALL_PACKAGES		:= \
	$(PACKAGES-y) $(PACKAGES-) \
	$(CROSS_PACKAGES) $(CROSS_PACKAGES-) \
	$(HOST_PACKAGES) $(HOST_PACKAGES-)

SELECTED_PACKAGES	:= \
	$(PACKAGES-y) $(CROSS_PACKAGES-y) \
	$(HOST_PACKAGES-y)  $(VIRTUAL-y)

# ----------------------------------------------------------------------------
# Install targets
# ----------------------------------------------------------------------------

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

# FIXME: should probably go somewhere else (separate images.make?)
ifdef PTXCONF_MKNBI_NBI
MKNBI_EXT = nbi
else
MKNBI_EXT = elf
endif

MKNBI_KERNEL = $(KERNEL_TARGET_PATH)

MKNBI_ROOTFS = $(IMAGEDIR)/root.ext2
ifdef PTXCONF_IMAGE_EXT2_GZIP
MKNBI_ROOTFS = $(IMAGEDIR)/root.ext2.gz
endif

# ----------------------------------------------------------------------------
# Targets
# ----------------------------------------------------------------------------

# FIXME: add check_tools getclean here
get: $(PACKAGES_GET) $(HOST_PACKAGES_GET) $(CROSS_PACKAGES_GET)

dep_output_clean:
#	if [ -e $(DEP_OUTPUT) ]; then rm -f $(DEP_OUTPUT); fi
	touch $(DEP_OUTPUT)

dep_tree: $(STATEDIR)/dep_tree

$(STATEDIR)/dep_tree:
	@if dot -V 2> /dev/null; then \
		echo "creating dependency graph..."; \
		sort $(DEP_OUTPUT) | uniq | $(PTXDIST_TOPDIR)/scripts/makedeptree | $(DOT) -Tps > $(DEP_TREE_PS); \
		if [ -x "`which poster`" ]; then \
			echo "creating A4 version..."; \
			poster -v -c0\% -mA4 -o$(DEP_TREE_A4_PS) $(DEP_TREE_PS); \
		fi;\
	else \
		echo "Install 'dot' from graphviz packet if you want to have a nice dependency tree"; \
	fi
	@$(call touch, $@)

dep_world: $(HOST_PACKAGES_INSTALL) \
	   $(CROSS_PACKAGES_INSTALL) \
	   $(PACKAGES_TARGETINSTALL)
	@echo $@ : $^ | sed  -e 's/\([^ ]*\)_\([^_]*\)/\1.\2/g' >> $(DEP_OUTPUT)

world: dep_output_clean dep_world $(BOOTDISK_TARGETINSTALL) dep_tree

host-tools:    dep_output_clean $(HOST_PACKAGES_INSTALL) dep_tree
host-get:      getclean $(HOST_PACKAGES_GET)
host-extract:  $(HOST_PACKAGES_EXTRACT)
host-prepare:  $(HOST_PACKAGES_PREPARE)
host-compile:  $(HOST_PACKAGES_COMPILE)
host-install:  $(HOST_PACKAGES_INSTALL)

cross-tools:   dep_output_clean $(CROSS_PACKAGES_INSTALL) dep_tree
cross-get:     getclean $(CROSS_PACKAGES_GET)
cross-extract: $(CROSS_PACKAGES_EXTRACT)
cross-prepare: $(CROSS_PACKAGES_PREPARE)
cross-compile: $(CROSS_PACKAGES_COMPILE)
cross-install: $(CROSS_PACKAGES_INSTALL)

#
# Things which have to be done before _any_ suffix rule is executed
# (especially PTXDIST_PATH handling)
#

$(PACKAGES_PREPARE): before_prepare
before_prepare:
	@for path in `echo $(PTXDIST_PATH) | awk -F: '{for (i=1; i<=NF; i++) {print $$i}}'`; do \
		if [ ! -d $$path ]; then							\
			echo "warning: PTXDIST_PATH component \"$$path\" is no directory";	\
		fi;										\
	done;

# ----------------------------------------------------------------------------
# Images
# ----------------------------------------------------------------------------

DOPERMISSIONS = '{	\
	if ($$1 == "f")	\
		printf("chmod %s .%s; chown %s.%s .%s;\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mkdir -p .`dirname %s`; mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $$2, $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'


images: $(STATEDIR)/images

ipkg-push: $(STATEDIR)/ipkg-push

$(STATEDIR)/ipkg-push: $(STATEDIR)/host-ipkg-utils.install
	@$(call targetinfo, $@)
	( \
	export PATH=$(PTXCONF_PREFIX)/bin:$(PTXCONF_PREFIX)/usr/bin:$$PATH; \
	$(PTXDIST_TOPDIR)/scripts/ipkg-push \
		--ipkgdir  $(call remove_quotes,$(IMAGEDIR)) \
		--repodir  $(call remove_quotes,$(PTXCONF_SETUP_IPKG_REPOSITORY)) \
		--revision $(call remove_quotes,$(FULLVERSION)) \
		--project  $(call remove_quotes,$(PTXCONF_PROJECT)) \
		--dist     $(call remove_quotes,$(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION)); \
	echo; \
	)
	$(call touch, $@)

images_deps =  world
ifdef PTXCONF_IMAGE_IPKG_IMAGE_FROM_REPOSITORY
images_deps += $(STATEDIR)/ipkg-push
endif

ifdef PTXCONF_IMAGE_HD_PART1
	GENHDIMARGS = -p $(PTXCONF_IMAGE_HD_PART1_START):$(PTXCONF_IMAGE_HD_PART1_END):$(PTXCONF_IMAGE_HD_PART1_TYPE):$(IMAGEDIR)/root.ext2
endif
ifdef PTXCONF_IMAGE_HD_PART2
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART2_START):$(PTXCONF_IMAGE_HD_PART2_END):$(PTXCONF_IMAGE_HD_PART2_TYPE):
endif
ifdef PTXCONF_IMAGE_HD_PART3
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART3_START):$(PTXCONF_IMAGE_HD_PART3_END):$(PTXCONF_IMAGE_HD_PART3_TYPE):
endif
ifdef PTXCONF_IMAGE_HD_PART4
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART4_START):$(PTXCONF_IMAGE_HD_PART4_END):$(PTXCONF_IMAGE_HD_PART4_TYPE):
endif
ifdef PTXCONF_GRUB
	GENHDIMARGS += -m $(GRUB_DIR)/stage1/stage1
	GENHDIMARGS += -n $(GRUB_DIR)/stage2/stage2
endif

#
# generate the list of source permission files
#
PERMISSION_FILES := $(wildcard $(STATEDIR)/*.perms)

#
# List of all ipkgs that should be rootfs's base
# TODO: generate a list of current valid ipkg packages
# instead of using all in the images/ directory!
#
IPKG_FILES := $(wildcard $(PKGDIR)/*.ipk)

#
# create one file with all permissions from all permission source files
#
$(IMAGEDIR)/permissions: $(PERMISSION_FILES)
	@cat $^ > $@

#
# to extract the ipkgs we need a dummy config file
#
$(IMAGEDIR)/ipkg.conf:
	@echo -e "dest root /\narch $(PTXCONF_ARCH_STRING) 10\narch all 1\narch noarch 1\n" > $@

#
# Working directory to create any kind of image
#
WORKDIR := $(IMAGEDIR)/work_dir

#
# Create architecture type for mkimge
# Most architectures are working with label $(PTXCONF_ARCH_STRING)
# but the i386 family needs "x86" instead!
#
ifeq ($(PTXCONF_ARCH_STRING),"i386")
MKIMAGE_ARCH := x86
else
MKIMAGE_ARCH := $(PTXCONF_ARCH_STRING)
endif

#
# Define what images should be build
#
SEL_ROOTFS-y				:=
SEL_ROOTFS-$(PTXCONF_IMAGE_TGZ)		+= $(IMAGEDIR)/root.tgz
SEL_ROOTFS-$(PTXCONF_IMAGE_JFFS2)	+= $(IMAGEDIR)/root.jffs2
SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2)	+= $(IMAGEDIR)/root.ext2
SEL_ROOTFS-$(PTXCONF_IMAGE_HD)		+= $(IMAGEDIR)/hd.img
SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2_GZIP)	+= $(IMAGEDIR)/root.ext2.gz
SEL_ROOTFS-$(PTXCONF_IMAGE_UIMAGE)	+= $(IMAGEDIR)/uRamdisk
SEL_ROOTFS-$(PTXCONF_IMAGE_CPIO)	+= $(IMAGEDIR)/initrd.gz

#
# extract all current ipkgs into the working directory
#
$(STATEDIR)/image_working_dir: $(IPKG_FILES) $(IMAGEDIR)/permissions $(IMAGEDIR)/ipkg.conf
	@rm -rf $(WORKDIR)
	@mkdir $(WORKDIR)
	@echo -n "Extracting ipkg packages into working directory..."
	@DESTDIR=$(WORKDIR) $(FAKEROOT) -- $(PTXCONF_HOST_PREFIX)/bin/ipkg-cl -f $(IMAGEDIR)/ipkg.conf -o $(WORKDIR) install $(IPKG_FILES) 2>&1 >/dev/null
	@$(call touch, $@)

#
# create the root.tgz image
#
$(IMAGEDIR)/root.tgz: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.tgz from working dir..."
	@cd $(WORKDIR);							\
	($(AWK) -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(	echo -n "tar -zcf ";					\
		echo -n "$@ ." )			\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the JFFS2 image
#
$(IMAGEDIR)/root.jffs2: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.jffs2 from working dir..."
	@cd $(WORKDIR);							\
	($(AWK) -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_HOST_PREFIX)/sbin/mkfs.jffs2 ";	\
		echo -n "-d $(WORKDIR) ";				\
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo -n "$(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS) ";		\
		echo -n "-o $@" )			\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the ext2 image
#
$(IMAGEDIR)/root.ext2: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.ext2 from working dir..."
	@cd $(WORKDIR);							\
	($(AWK) -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_HOST_PREFIX)/bin/genext2fs ";	\
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) ";		\
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) ";		\
		echo -n "-d $(WORKDIR) ";				\
		echo "$@" )				\
	) | $(FAKEROOT) --
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/hd.img: $(IMAGEDIR)/root.ext2
	@echo -n "Creating hdimg from root.ext2";			\
	PATH=$(PTXCONF_HOST_PREFIX)/bin:$$PATH $(PTXDIST_TOPDIR)/scripts/genhdimg	\
	-o $@ $(GENHDIMARGS)
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/root.ext2.gz: $(IMAGEDIR)/root.ext2
	@echo -n "Creating root.ext2.gz from root.ext2...";
	@rm -f $@
	@cat $< | gzip -v9 > $@
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/uRamdisk: $(IMAGEDIR)/root.ext2.gz
	@echo -n "Creating U-Boot ramdisk from root.ext2.gz...";
	@$(PTXCONF_HOST_PREFIX)/bin/mkimage \
		-A $(MKIMAGE_ARCH) \
		-O Linux \
		-T ramdisk \
		-C gzip \
		-n $(PTXCONF_IMAGE_UIMAGE_NAME) \
		-d $< \
		$@
	@echo "done."

#
# create traditional initrd.gz, to be used
# as initramfs (-> "-H newc")
#
$(IMAGEDIR)/initrd.gz: $(STATEDIR)/image_working_dir
	@echo -n "Creating initrd.gz from working dir..."
	@cd $(WORKDIR);							\
	($(AWK) -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo "find . | ";					\
		echo "cpio --quiet -H newc -o | ";				\
		echo "gzip -9 -n > $@" )		\
	) | $(FAKEROOT) --
	@echo "done."

#
# TODO: Find a way to always find the correct zipped kernel image on every
# architecture.
#
#$(IMAGEDIR)/muimage: $(IMAGEDIR)/initrd.gz $(KERNEL_DIR)/???????
#	@echo -n "Creating multi content uimage..."
#	@$(PTXCONF_HOST_PREFIX)/bin/mkimage -A $(PTXCONF_ARCH_STRING)	\
#		-O Linux -T multi -C gzip -a 0 -e 0			\
#		-n 'Multi-File Image'					\
#		-d $(KERNEL_DIR)/vmlinux.bin.gz:$(IMAGEDIR)/initrd.img	\
#       	$(IMAGEDIR)/muimage
#	@echo "done."

#
# create all requested images and clean up when done
#
$(STATEDIR)/images:  $(SEL_ROOTFS-y) $(images_deps)
	@echo "Clean up temp working directory"
	@rm -rf $(WORKDIR) $(STATEDIR)/image_working_dir
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Simulation
# ----------------------------------------------------------------------------

uml_cmdline=
ifdef PTXCONF_KERNEL_HOST_ROOT_HOSTFS
uml_cmdline += root=/dev/root rootflags=$(ROOTDIR) rootfstype=hostfs
endif
ifdef PTXCONF_KERNEL_HOST_CONSOLE_STDSERIAL
uml_cmdline += ssl0=fd:0,fd:1
endif
#uml_cmdline += eth0=slirp
uml_cmdline += $(PTXCONF_KERNEL_HOST_CMDLINE)

run: world
	@$(call targetinfo, "Run Simulation")
ifdef NATIVE
	@echo "starting Linux..."
	@echo
	@$(ROOTDIR)/boot/linux $(call remove_quotes,$(uml_cmdline))
else
	@echo
	@echo "cannot run simulation if not in NATIVE=1 mode"
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Test
# ----------------------------------------------------------------------------

ipkg-test: world
	@$(call targetinfo,ipkg-test)
	@IMAGES=$(IMAGEDIR) ROOT=$(ROOTDIR) \
	IPKG=$(call remove_quotes,$(PTXCONF_PREFIX))/bin/ipkg-cl \
		$(PTXDIST_TOPDIR)/scripts/ipkg-test

# ----------------------------------------------------------------------------

qa-static:
	@cd $(PTXDIST_WORKSPACE);					\
	rm -f QA.log;							\
	echo "QA: Static Analysis Report" >> QA-static.log;		\
	echo start: `date` >> QA-static.log;                   		\
	echo >> QA-static.log;						\
	scripts/qa-static/master >> QA-static.log 2>&1;			\
	echo >> QA-static.log;						\
	echo stop: `date` >> QA-static.log;				\
	echo >> QA-static.log;
	@cat QA-static.log;

# ----------------------------------------------------------------------------

# qa-autobuild:
# 	@cd $(PTXDIST_WORKSPACE);							\
# 	rm -f QA-autobuild.log;								\
# 	echo | tee -a QA-autobuild.log;							\
# 	echo "QA: Autobuild Report" | tee -a QA-autobuild.log;				\
# 	echo "start: `date`" | tee -a QA-autobuild.log;                			\
# 	echo | tee -a QA-autobuild.log;							\
# 											\
# 	for i in `find $(PROJECTDIRS) -name "*.ptxconfig"`; do 				\
# 		autobuild=`echo $$i | perl -p -e "s/.ptxconfig/.autobuild/g"`; 		\
# 		if [ -x "$$autobuild" ]; then						\
# 			PTXDIST_TOPDIR=$(PTXDIST_TOPDIR)				\
# 			PTXDIST_WORKSPACE=$(PTXDIST_WORKSPACE)				\
# 			$$autobuild | tee -a QA-autobuild.log;				\
# 		else									\
# 			echo "skipping `basename $$autobuild`|tee -a QA-autobuild.log";	\
# 		fi;									\
# 	done;										\
# 	echo | tee -a QA-autobuild.log;							\
# 	echo stop: `date` | tee -a QA-autobuild.log;					\
# 	echo | tee -a QA-autobuild.log

# ----------------------------------------------------------------------------
# SVN Targets
# ----------------------------------------------------------------------------

# svn-up:
# 	@$(call targetinfo, Updating in Toplevel)
# 	@cd $(PTXDIST_TOPDIR) && svn update
# 	@if [ -d "$(PROJECTDIR)" ]; then				\
# 		$(call targetinfo, Updating in PROJECTDIR);		\
# 		cd $(PROJECTDIR);					\
# 		[ -d .svn ] && svn update; 				\
# 	fi;
# 	@echo "done."
#
# svn-stat:
# 	@$(call targetinfo, svn stat in Toplevel)
# 	@cd $(PTXDIST_TOPDIR) && svn stat
# 	@if [ -d "$(PROJECTDIR)" ]; then				\
# 		$(call targetinfo, svn stat in PROJECTDIR);		\
# 		cd $(PROJECTDIR);					\
# 		[ -d .svn ] && svn stat; 				\
# 	fi;
# 	@echo "done."

# ----------------------------------------------------------------------------
# Misc other targets
# ----------------------------------------------------------------------------

print-%:
	@echo "$* is \"$($*)\""

plugins:
	@echo "Installed Plugins:"
	@echo $(wildcard $(PTXDIST_TOPDIR)/plugins/*)

plugin-%: dump
	@echo "trying plugin $(*)"
	@if [ -x "$(PTXDIST_WORKSPACE)/plugins/$(*)/main" ]; then 	\
		echo "local plugin found.";				\
		$(PTXDIST_WORKSPACE)/plugins/$(*)/main;			\
	elif [ -x "$(PTXDIST_TOPDIR)/plugins/$(*)/main" ]; then  	\
		echo "generic plugin found.";                   	\
		$(PTXDIST_TOPDIR)/plugins/$(*)/main;            	\
	else								\
		echo "sorry, plugin not found";				\
	fi

# ----------------------------------------------------------------------------
# environment export to plugins and shell scripts
# ----------------------------------------------------------------------------
# If you run 'ptxdist make dump', you will get two files:
# $(STATEDIR)/environment.symbols <- A list of all internal Variable
#                                    Symbols in the main PTXdist Makefile
# $(STATEDIR)/environment.bash    <- A selection of Variables in bash
#				     syntax. Please adjust M2B_DUMP_VARIABLES
#				     and M2B_DUMP_SUFFIXES to your needs.
#				     See rules/other/Definitions.make
# ----------------------------------------------------------------------------
#
# dump all internal make symbols
#
$(M2B).symbols:
	@echo "$(.VARIABLES)" 		\
	| sed s/\ /\\n/g 		\
	| egrep -v "[^A-Z0-9_-]|^_$$" 	\
	| sort -u > $@

dump-symbols:	$(M2B).symbols ;
#
# dump selected symbols with value
#
packages := $(PACKAGES-) $(PACKAGES-y)
prefixes := $(shell echo $(packages) | tr "a-z-" "A-Z_")
symbols := $(foreach prefix,$(prefixes),$(foreach suffix,$(M2B_DUMP_SUFFIXES),$(prefix)$(suffix)))
allsymbols := $(prefixes) $(shell echo $(symbols) | tr "a-z-" "A-Z_") $(M2B_DUMP_VARIABLES)
sources := $(addsuffix _SOURCE,$(shell echo $(SELECTED_PACKAGES) | tr "a-z-" "A-Z_"))

dump-%: $(M2B).symbols
	@echo 'M2B_$(call remove_quotes,$(*))="$(call remove_quotes,$($(*)))"' >> $(M2B).bash.tmp
	@echo '$(call remove_quotes,$(*)) $(call remove_quotes,$($(*)))' >> $(M2B).tmp

dump: $(addprefix dump-,$(allsymbols))
	@mv $(M2B).bash.tmp $(M2B).bash
	@mv $(M2B).tmp $(M2B)

#
# ----------------------------------------------------------------------------

.PHONY: dep_output_clean dep_tree dep_world before_config

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

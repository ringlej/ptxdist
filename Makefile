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

# Pengutronix Patch Repository
PTXPATCH_URL		:= http://www.pengutronix.de/software/ptxdist/patches

PACKAGES	=
XCHAIN		=
VIRTUAL		=
HOSTTOOLS	=

export TAR TOPDIR BUILDDIR ROOTDIR SRCDIR PTXSRCDIR STATEDIR PACKAGES HOSTTOOLS

all: help

-include .config 

include rules/Definitions.make

ROOTDIR=$(subst $(quote),,$(PTXCONF_ROOT))
ifeq ("", $(PTXCONF_ROOT))
ROOTDIR=$(TOPDIR)/root
endif
ifndef PTXCONF_ROOT
ROOTDIR=$(TOPDIR)/root
endif

PTXCONF_TARGET_CONFIG_FILE ?= none
ifeq ("", $(PTXCONF_TARGET_CONFIG_FILE))
PTXCONF_TARGET_CONFIG_FILE =  none
endif
-include config/arch/$(subst $(quote),,$(PTXCONF_TARGET_CONFIG_FILE))

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
-include $(subst $(quote),,$(PTXCONF_VENDORTWEAKS))

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
# help message {{{
	@echo
	@echo "PTXdist - Pengutronix Distribution Build System"
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
	@echo "  make cuckoo-test             look for cuckoo-eggs in system"
	@echo
	@echo "Calling these targets affects the whole system. If you want to"
	@echo "do something for a packet do 'make packet_<action>'."
	@echo
	@echo "Available packages and versions:"
	@echo " $(PACKAGES)"
	@echo
	@echo "Available cross-chain packages:"
	@echo " $(XCHAIN)"
	@echo
	@echo "Available virtual packages:"
	@echo " $(VIRTUAL)"
	@echo
	@echo "Hosttools to be built:"
	@echo " $(HOSTTOOLS)"
	@echo
	@echo "Available vendortweaks:"
	@echo "  $(VENDORTWEAKS)"
	@echo
# }}}

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

images: $(STATEDIR)/images

$(STATEDIR)/images:
ifdef PTXCONF_IMAGE_TGZ
	cd $(ROOTDIR); \
	(awk -F: '{printf("chmod %s .%s; chown %s.%s .%s;\n", $$4, $$1, $$2, $$3, $$1);}' $(TOPDIR)/permissions && \
	echo "tar -zcvf $(TOPDIR)/images/root.tgz . ") | \
	$(PTXCONF_PREFIX)/bin/fakeroot -- 
endif
ifdef PTXCONF_IMAGE_JFFS2
	cd $(ROOTDIR); \
	(awk -F: '{printf("chmod %s .%s; chown %s.%s .%s;\n", $$4, $$1, $$2, $$3, $$1);}' $(TOPDIR)/permissions && \
	( \
		echo -n "$(PTXCONF_PREFIX)/bin/mkfs.jffs2 -d $(ROOTDIR) "; \
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo "-o $(TOPDIR)/images/root.jffs2" ) \
	) | $(PTXCONF_PREFIX)/bin/fakeroot -- 
endif
ifdef PTXCONF_IMAGE_HD
	$(TOPDIR)/scripts/genhdimg \
	-m $(GRUB_DIR)/stage1/stage1 \
	-n $(GRUB_DIR)/stage2/stage2 \
	-r $(ROOTDIR) \
	-i images \
	-f $(PTXCONF_IMAGE_HD_CONF)
endif
	touch $@

# Configuration system -------------------------------------------------------

ptx_lxdialog:
	cd scripts/lxdialog && ln -s -f ../ptx-modifications/Makefile.lxdialog.ptx Makefile

ptx_kconfig:
	cd scripts/kconfig && ln -s -f ../ptx-modifications/Makefile.kconfig.ptx Makefile

scripts/lxdialog/lxdialog: ptx_lxdialog
	make -C scripts/lxdialog lxdialog

scripts/kconfig/libkconfig.so: ptx_kconfig
	make -C scripts/kconfig libkconfig.so

scripts/kconfig/conf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig conf

scripts/kconfig/mconf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig mconf

scripts/kconfig/qconf: scripts/kconfig/libkconfig.so
	make -C scripts/kconfig qconf

menuconfig: scripts/lxdialog/lxdialog scripts/kconfig/mconf
	scripts/kconfig/mconf config/Kconfig

xconfig: scripts/kconfig/qconf
	scripts/kconfig/qconf config/Kconfig

gconfig: scripts/kconfig/gconf
	LD_LIBRARY_PATH=./scripts/kconfig ./scripts/kconfig/gconf config/Kconfig

oldconfig: ptx_kconfig scripts/kconfig/conf
	scripts/kconfig/conf -o config/Kconfig

# Config Targets -------------------------------------------------------------

%_config:
	@echo; \
	echo "[Searching for Config File:]"; \
	CFG=`find projects -name $(subst _config,.ptxconfig,$@)`; \
	if [ -n "$$CFG" ]; then \
		echo "using config file \"$$CFG\""; \
		cp $$CFG $(TOPDIR)/.config; \
	else \
		echo "could not find config file \"$$CFG\""; \
	fi; \
	echo

# Cuckoo Test ----------------------------------------------------------------
cuckoo-test: world
	@scripts/cuckoo-test $(PTXCONF_ARCH) root $(PTXCONF_GNU_TARGET)-

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
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.kconfig.ptx  -C scripts/kconfig clean
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.lxdialog.ptx -C scripts/lxdialog clean
	@rm -f scripts/kconfig/Makefile
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
	@echo "Available configs: "
	@echo
	@for i in `find projects -name "*.ptxconfig"`; do \
		basename `echo $$i | perl -p -e "s/.ptxconfig/_config/g"`; \
	done | sort 
	@echo

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

print-%:
	@echo $* is $($*)

.PHONY: dep_output_clean dep_tree dep_world skip_vendortweaks
# vim600:set foldmethod=marker:

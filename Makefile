# $Id: Makefile,v 1.88 2004/04/21 15:40:15 bsp Exp $
#
# Copyright (C) 2002 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2002 by Jochen Striepe <ptxdist@tolot.escape.de>
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# For further information about the PTXdist project see the README file.
#
PROJECT		:= PTXdist
VERSION		:= 0
PATCHLEVEL	:= 5
SUBLEVEL	:= 2
EXTRAVERSION	:= -cvs

FULLVERSION	:= $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

export PROJECT VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION FULLVERSION

TOPDIR			:= $(shell pwd)
BASENAME		:= $(shell basename $(TOPDIR))
BUILDDIR		:= $(TOPDIR)/build
XCHAIN_BUILDDIR		:= $(BUILDDIR)/xchain
NATIVE_BUILDDIR		:= $(BUILDDIR)/native
PATCHES_BUILDDIR	:= $(BUILDDIR)/patches
SRCDIR			:= $(TOPDIR)/src
PATCHDIR		:= $(TOPDIR)/patches
STATEDIR		:= $(TOPDIR)/state
BOOTDISKDIR		:= $(TOPDIR)/bootdisk
MISCDIR			:= $(TOPDIR)/misc

# Pengutronix Patch Repository
PTXPATCH_URL		:= http://www.pengutronix.de/software/ptxdist/patches

PACKAGES	=
XCHAIN		=
VIRTUAL		=
NATIVE		=

export TAR TOPDIR BUILDDIR ROOTDIR SRCDIR PTXSRCDIR STATEDIR PACKAGES

all: help

-include .config 

ROOTDIR=$(subst ",,$(PTXCONF_ROOT))
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
-include config/arch/$(subst ",,$(PTXCONF_TARGET_CONFIG_FILE))

include rules/Rules.make
include rules/Version.make
include $(filter-out rules/Virtual.make rules/Rules.make rules/Version.make,$(wildcard rules/*.make))
include rules/Virtual.make

# if specified, include vendor tweak makefile (run at the end of build)
# rewrite variable to make the magic in 'world' target work

PTXCONF_VENDORTWEAKS ?= none
ifeq ("", $(PTXCONF_VENDORTWEAKS))
PTXCONF_VENDORTWEAKS =  none
endif
-include rules/vendor-tweaks/$(subst ",,$(PTXCONF_VENDORTWEAKS))

# install targets 
PACKAGES_TARGETINSTALL 		:= $(addsuffix _targetinstall,$(PACKAGES)) $(addsuffix _targetinstall,$(VIRTUAL))
PACKAGES_GET			:= $(addsuffix _get,$(PACKAGES)) $(addsuffix _get,$(XCHAIN))
PACKAGES_EXTRACT		:= $(addsuffix _extract,$(PACKAGES))
PACKAGES_PREPARE		:= $(addsuffix _prepare,$(PACKAGES))
PACKAGES_COMPILE		:= $(addsuffix _compile,$(PACKAGES))

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
	@echo "Eventually needed native packes:"
	@echo " $(NATIVE)"
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

dep_world: $(PACKAGES_TARGETINSTALL) $(VENDORTWEAKS_TARGETINSTALL)
	@echo $@ : $^ | sed -e "s/_/./g" >> $(DEP_OUTPUT)

world: check_tools dep_output_clean dep_world $(BOOTDISK_TARGETINSTALL) dep_tree 

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
	scripts/kconfig/mconf config/Config.in

xconfig: scripts/kconfig/qconf
	scripts/kconfig/qconf config/Config.in

gconfig: scripts/kconfig/gconf
	LD_LIBRARY_PATH=./scripts/kconfig ./scripts/kconfig/gconf config/Config.in

oldconfig: ptx_kconfig scripts/kconfig/conf
	scripts/kconfig/conf -o config/Config.in 

# Config Targets -------------------------------------------------------------

i386-ratio-uno-2053-1_config:
	@echo "copying ratio UNO-2053-1 configuration"
	@cp config/i386-ratio-uno-2053-1.ptxconfig .config

i386-frako_config:
	@echo "copying frako configuration"
	@cp config/i386-frako.ptxconfig .config

i386-generic-glibc_config: 
	@echo "copying i386-generic-glibc configuration"
	@cp config/i386-generic-glibc.ptxconfig .config

i386-generic-uclibc_config: 
	@echo "copying i386-generic-uclibc configuration"
	@cp config/i386-generic-uclibc.ptxconfig .config

innokom_config:
	@echo "copying innokom configuration"
	@cp config/innokom.ptxconfig .config

innokom-3.3.2_config:
	@echo "copying innokom-3.3.2 configuration (WORK IN PROGRESS!)"
	@cp config/innokom-3.3.2-tmp.ptxconfig .config

mx1fs2_config:
	@echo "copying mx1fs2 configuration"
	@cp config/mx1fs2.ptxconfig .config

i586-rayonic_config:
	@echo "copying 586 rayonic configuration"
	@cp config/i586-rayonic.ptxconfig .config
	@cp config/rtaiconfig-rayonic .rtaiconfig

i386-rayonic_config:
	@echo "copying 386 rayonic configuration"
	@cp config/i386-rayonic.ptxconfig .config
	@cp config/rtaiconfig-rayonic .rtaiconfig

roi-eics_config:
	@echo "copying ROI EICS configuration"
	@cp config/geode-roi_eics.ptxconfig .config
	@cp config/rtaiconfig-roi .rtaiconfig

i386-scII-bmwm_config:
	@echo "copying solidcard-bmw configuration"
	@cp config/i386-scII-bmwm.ptxconfig .config

scIII-cameron_config:
	@echo "copying scIII-cameron configuration"
	@cp config/ppc405-cameron.ptxconfig .config

wystup_config:
	@echo "copying wystup configuration"
	@cp config/wystup.ptxconfig .config

# Toolchain Config Targets ---------------------------------------------------

toolchain-powerpc-405-linux_config:
	@echo "copying toolchain-powerpc-405-linux configuration"
	@cp config/toolchain-powerpc-405-linux .config

toolchain-arm-linux-3.3.2_config:
	@echo "copying toolchain-arm-linux configuration"
	@cp config/toolchain-arm-linux-3.3.2 .config

toolchain-arm-linux-2.95_config:
	@echo "copying toolchain-arm-linux-2.95 configuration"
	@cp config/toolchain-arm-linux-2.95 .config

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

clean: rootclean
	@echo
	@echo -n "cleaning build dir............... "
	@for i in $$(ls -I CVS $(BUILDDIR)); do echo -n $$i' '; rm -rf $(BUILDDIR)/"$$i"; done
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
	@echo -n "cleaning manual.................. "
	@make -s -C $(TOPDIR)/Documentation/manual clean
	@echo "done."
	@echo

rootclean:
	@echo
	@echo -n "cleaning root dir................ "
	@for i in $$(ls -I CVS $(ROOTDIR)); do echo -n $$i' '; rm -rf $(ROOTDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning state/*.targetinstall... "
	@rm -f $(STATEDIR)/*.targetinstall
	@echo "done."	
	@echo

getclean:
	@echo
	@echo -n "cleaning state/*.get............. "
	@rm -f $(STATEDIR)/*.get
	@echo "done."
	@echo

archive:
# FIXME: this should be automated
	$(TAR) -C $(TOPDIR)/.. -zcvf /tmp/$(BASENAME).tgz 	\
		--exclude CVS					\
		--exclude $(BASENAME)/build/* 			\
		--exclude $(BASENAME)/state/* 			\
		--exclude $(BASENAME)/src/* 			\
		--exclude $(BASENAME)/src			\
		--exclude $(BASENAME)/root/*			\
		--exclude $(BASENAME)/local/*			\
		--exclude $(BASENAME)/bootdisk/*		\
		--exclude $(BASENAME)/PATCHES-INCOMING		\
		--exclude $(BASENAME)/patches			\
		--exclude $(BASENAME)/Documentation/manual	\
		$(BASENAME)

archive-toolchain: virtual-xchain_install
	$(TAR) -C $(PTXCONF_PREFIX)/.. -jcvf $(TOPDIR)/$(PTXCONF_GNU_TARGET).tar.bz2 \
		$(shell basename $(PTXCONF_PREFIX))

configs:
	@echo
	@echo "Available configs: "
	@echo
	@grep -e ".*_config:" Makefile | grep -v grep | grep -v "^#"
	@echo

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

print-%:
	@echo $* is $($*)

.PHONY: dep_output_clean dep_tree dep_world skip_vendortweaks
# vim600:set foldmethod=marker:

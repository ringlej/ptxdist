# $Id: Makefile,v 1.49 2003/11/09 21:49:46 mkl Exp $
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
SUBLEVEL	:= 0
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

PACKAGES=
XCHAIN=
NATIVE=

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

include rules/Rules.make
include rules/Version.make
include $(filter-out rules/Virtual.make,$(wildcard rules/*.make))
include rules/Virtual.make

PTXCONF_TARGET_CONFIG_FILE ?= none
ifeq ("", $(PTXCONF_TARGET_CONFIG_FILE))
PTXCONF_TARGET_CONFIG_FILE =  none
endif
-include config/arch/$(subst ",,$(PTXCONF_TARGET_CONFIG_FILE))

# if specified, include vendor tweak makefile (run at the end of build)
# rewrite variable to make the magic in 'world' target work

PTXCONF_VENDORTWEAKS ?= none
ifeq ("", $(PTXCONF_VENDORTWEAKS))
PTXCONF_VENDORTWEAKS =  none
endif
-include rules/vendor-tweaks/$(subst ",,$(PTXCONF_VENDORTWEAKS))

# install targets 
PACKAGES_TARGETINSTALL 		:= $(addsuffix _targetinstall,$(PACKAGES))
PACKAGES_GET			:= $(addsuffix _get,$(PACKAGES))
PACKAGES_EXTRACT		:= $(addsuffix _extract,$(PACKAGES))
PACKAGES_PREPARE		:= $(addsuffix _prepare,$(PACKAGES))
PACKAGES_COMPILE		:= $(addsuffix _compile,$(PACKAGES))

VENDORTWEAKS_TARGETINSTALL	:= $(addsuffix _targetinstall,$(VENDORTWEAKS))

help:
# help message {{{
	@echo
	@echo "PTXdist - Pengutronix Distribution Build System"
	@echo
	@echo "Syntax:"
	@echo
	@echo "  make menuconfig       Configure the whole system"
	@echo
	@echo "  make extract          Extract all needed archives"
	@echo "  make prepare          Prepare the configured system for compilation"
	@echo "  make compile          Compile the packages"
	@echo "  make install          Install to rootdirectory"
	@echo "  make clean            Remove everything but local/"
	@echo "  make rootclean        Remove root directory contents"
	@echo "  make distclean        Clean everything"
	@echo
	@echo "  make world            Make-everything-and-be-happy"
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
	@echo "Eventually needed native packes:"
	@echo " $(NATIVE)"
	@echo
	@echo "Available vendortweaks:"
	@echo "  $(VENDORTWEAKS)"
	@echo
# }}}

get:     getclean $(PACKAGES_GET)
extract: $(PACKAGES_EXTRACT)
prepare: $(PACKAGES_PREPARE)
compile: $(PACKAGES_COMPILE)
install: $(PACKAGES_TARGETINSTALL)

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

world: dep_output_clean dep_world dep_tree 

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

oldconfig: ptx_kconfig scripts/kconfig/conf
	scripts/kconfig/conf -o config/Config.in 

# Config Targets -------------------------------------------------------------

i386-generic-glibc_config: 
	@echo "copying i386-generic-glibc config" $(call latestconfig, ptxconfig-i386-generic-glibc)
	@cp $(call latestconfig, ptxconfig-i386-generic-glibc) .config

i386-generic-uclibc_config: 
	@echo "copying i386-generic-uclibc config" $(call latestconfig, ptxconfig-i386-generic-uclibc)
	@cp $(call latestconfig, ptxconfig-i386-generic-uclibc) .config

innokom_config:
	@echo "copying innokom configuration"
	@cp config/innokom.ptxconfig .config

rayonic_config:
	@echo "copying rayonic config" $(call latestconfig, ptxconfig-rayonic)
	@cp $(call latestconfig, ptxconfig-rayonic) .config
	@cp $(call latestconfig, rtaiconfig-rayonic) .rtaiconfig

roi-eics_config:
	@echo "copying ROI EICS config" $(call latestconfig, roi-eics)
	@cp $(call latestconfig, ptxconfig-roi-eics) .config
	@cp $(call latestconfig, rtaiconfig-roi-eics) .rtaiconfig

scII-bmw_config:
	@echo "copying solidcard-bmw config" $(call latestconfig, ptxconfig-solidcard-bmw)
	@cp $(call latestconfig, ptxconfig-solidcard-bmw) .config

scII-cameron_config:
	@echo "copying scII-cameron config" $(call latestconfig, ptxconfig-cameron)
	@cp $(call latestconfig, ptxconfig-cameron) .config

# ----------------------------------------------------------------------------

distclean: clean
	@echo -n "cleaning .config, .kernelconfig.. "
	@rm -f .config* .kernelconfig .tmp* .rtaiconfig
	@echo "done."
	@echo -n "cleaning patches dir............. "
	@rm -rf $(TOPDIR)/patches
	@echo "done."
	@echo

clean: rootclean
	@echo
	@echo -n "cleaning build dir............... "
	@for i in $$(ls -I CVS $(BUILDDIR)); do echo -n $$i' '; rm -rf $(BUILDDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning state dir............... "
	@for i in $$(ls -I CVS $(STATEDIR)); do rm -rf $(STATEDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning scripts dir............. "
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.kconfig.ptx  -C scripts/kconfig clean
	@make -s -f $(TOPDIR)/scripts/ptx-modifications/Makefile.lxdialog.ptx -C scripts/lxdialog clean
	@echo "done."
	@echo -n "cleaning bootdisk image.......... "
	@rm -f $(TOPDIR)/boot.image
	@echo "done."
	@echo -n "cleaning dependency tree ........ "
	@rm -f $(DEP_OUTPUT) $(DEP_TREE_PS)
	@echo "done."
	@echo -n "cleaning logfile................. "
	@rm -f logfile*
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
		$(BASENAME)

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

print-%:
	@echo $* is $($*)

.PHONY: dep_output_clean dep_tree dep_world skip_vendortweaks
# vim600:set foldmethod=marker:

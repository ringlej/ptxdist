# $Id: Makefile,v 1.6 2003/06/25 10:31:20 robert Exp $
#
# (c) 2002 by Robert Schwebel <r.schwebel@pengutronix.de>
# (c) 2002 by Jochen Striepe <ptxdist@tolot.escape.de>
#
# For further information about the PTXDIST project see the README file.

PROJECT = PTXdist
VERSION = 0
PATCHLEVEL = 3
SUBLEVEL = 22
EXTRAVERSION =

export PROJECT VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION

MAKE=make
TAR=tar

TOPDIR=$(shell /bin/pwd)
BASENAME=$(shell /usr/bin/basename $(TOPDIR))
BUILDDIR=$(TOPDIR)/build
ROOTDIR=$(TOPDIR)/root
SRCDIR=$(TOPDIR)/src
PTXSRCDIR=$(TOPDIR)/src_ptx
STATEDIR=$(TOPDIR)/state
BOOTDISKDIR=$(TOPDIR)/bootdisk

INSTALL_LOG=$(TOPDIR)/tools/install-log-1.9/install-log

PACKAGES=

export TAR TOPDIR BUILDDIR ROOTDIR SRCDIR PTXSRCDIR STATEDIR PACKAGES

all: help

-include .config 

include $(wildcard rules/*.make)

# install targets 
PACKAGES_TARGETINSTALL 	= $(addsuffix _targetinstall,$(PACKAGES))
PACKAGES_GET		= $(addsuffix _get,$(PACKAGES))
PACKAGES_EXTRACT	= $(addsuffix _extract,$(PACKAGES))
PACKAGES_PREPARE	= $(addsuffix _prepare,$(PACKAGES))
PACKAGES_COMPILE	= $(addsuffix _compile,$(PACKAGES))

help:
# help message {{{
	@echo 
	@echo "PTXDIST - Pengutronix Distribution Build System"
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
	@echo 
	@echo "  make world            Make-everything-and-be-happy"
	@echo
	@echo "Calling these targets affects the whole system. If you want to"
	@echo "do something for a packet do 'make packet-<action>'."
	@echo
	@echo "Available packages and versions: "
	@echo "$(PACKAGES)"
	@echo 
# }}}

get:     $(PACKAGES_GET)
extract: $(PACKAGES_EXTRACT)
prepare: $(PACKAGES_PREPARE)
compile: $(PACKAGES_COMPILE)
install: $(PACKAGES_INSTALL)

dep_output_clean:
	if [ -e $(DEP_OUTPUT) ]; then rm -f $(DEP_OUTPUT); fi
	touch $(DEP_OUTPUT)

dep_tree:
	scripts/makedeptree $(DEP_OUTPUT) | $(DOT) -Tps > $(DEP_TREE_PS)

dep_world: $(PACKAGES_TARGETINSTALL)
	echo $@ : $^ | sed -e "s/_/./g" >> $(DEP_OUTPUT)
	
world: dep_output_clean dep_world dep_tree

# menuconfig:
# 	CONFIGDIR=$(TOPDIR)/config make -C config/config_system menuconfig

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

innokom_config:
	@echo "copying innokom config"
	@cp $(call latestconfig, ptxconfig-auerswald) .config
	@cp $(call latestconfig, kernel*auerswald) .kernelconfig

rayonic_config:
	@echo "copying rayonic config"
	@cp $(call latestconfig, ptxconfig-rayonic) .config
	@cp $(call latestconfig, kernel*rayonic) .kernelconfig

# ----------------------------------------------------------------------------
clean: rootclean
	@echo
	@echo -n "cleaning build dir............... "
	@for i in $$(ls -I CVS $(BUILDDIR)); do echo -n $$i' '; rm -rf $(BUILDDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning state dir............... "
	@for i in $$(ls -I CVS $(STATEDIR)); do rm -rf $(STATEDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning scripts dir............. "
	@make -s -C scripts/kconfig clean
	@make -s -C scripts/lxdialog clean
	@echo "done."
	@echo -n "cleaning bootdisk dir............ "
	@for i in $$(ls -I CVS $(BOOTDISKDIR)); do echo -n $$i' '; rm -rf $(BOOTDISKDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning dependency tree ........ "
	@rm -f $(DEP_OUTPUT) $(DEP_TREE_PS)
	@echo "done."
	@echo

rootclean:
	@echo
	@echo -n "cleaning root/ directory......... "
	@for i in $$(ls -I CVS $(ROOTDIR)); do echo -n $$i' '; rm -rf $(ROOTDIR)/"$$i"; done
	@echo "done."
	@echo -n "cleaning state/*.targetinstall... "
	@rm -f $(STATEDIR)/*.targetinstall
	@echo "done."	
	@echo

archive:
	# FIXME: this should be automated
	$(TAR) -C $(TOPDIR)/.. -zcvf /tmp/$(BASENAME).tgz 	\
		--exclude $(BASENAME)/arm-linux/* 		\
		--exclude $(BASENAME)/build/* 			\
		--exclude $(BASENAME)/state/* 			\
		--exclude $(BASENAME)/src/* 			\
		--exclude $(BASENAME)/root/*			\
		--exclude $(BASENAME)/local/*			\
		--exclude $(BASENAME)/src_ptx/busybox*		\
		--exclude $(BASENAME)/bootdisk/*		\
		$(BASENAME)

$(INSTALL_LOG): 
	make -C $(TOPDIR)/tools/install-log-1.9

.PHONY: dep_output_clean dep_tree dep_world
# vim600:set foldmethod=marker:

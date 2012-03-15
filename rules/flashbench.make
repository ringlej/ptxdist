# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <walle@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLASHBENCH) += flashbench

#
# Paths and names
#
FLASHBENCH_VERSION	:= 20120222
FLASHBENCH_MD5		:= 3d99608022b50e891e5f66d7c637d8b1
FLASHBENCH		:= flashbench-$(FLASHBENCH_VERSION)
FLASHBENCH_SUFFIX	:= tar.gz
FLASHBENCH_URL		:= http://bwalle.de/programme/$(FLASHBENCH).$(FLASHBENCH_SUFFIX)
FLASHBENCH_SOURCE	:= $(SRCDIR)/$(FLASHBENCH).$(FLASHBENCH_SUFFIX)
FLASHBENCH_DIR		:= $(BUILDDIR)/$(FLASHBENCH)
FLASHBENCH_LICENSE	:= GPL v2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLASHBENCH_CONF_TOOL	:= NO
FLASHBENCH_MAKE_ENV	:= $(CROSS_ENV)
FLASHBENCH_MAKE_OPT	:= CC=$(CROSS_CC) \
	EXTRA_CFLAGS=-DMAX_BUFSIZE=$(shell expr 1024 \* 1024 \* $(PTXCONF_FLASHBENCH_MAX_BUFSIZE))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flashbench.install:
	@$(call targetinfo)
	install -d $(FLASHBENCH_PKGDIR)/usr/sbin/
	install -m0755 $(FLASHBENCH_DIR)/flashbench $(FLASHBENCH_PKGDIR)/usr/sbin
	install -m0755 $(FLASHBENCH_DIR)/erase $(FLASHBENCH_PKGDIR)/usr/sbin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flashbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, flashbench)
	@$(call install_fixup, flashbench,PRIORITY,optional)
	@$(call install_fixup, flashbench,SECTION,base)
	@$(call install_fixup, flashbench,AUTHOR,"Bernhard Walle <walle@corscience.de>")
	@$(call install_fixup, flashbench,DESCRIPTION,missing)

	@$(call install_copy, flashbench, 0, 0, 0755, -, /usr/sbin/flashbench)
	@$(call install_copy, flashbench, 0, 0, 0755, -, /usr/sbin/erase)

	@$(call install_finish, flashbench)

	@$(call touch)

# vim: syntax=make

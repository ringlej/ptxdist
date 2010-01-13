# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSYSFS) += libsysfs

#
# Paths and names
#
LIBSYSFS_VERSION	:= 2.1.0
LIBSYSFS		:= sysfsutils-$(LIBSYSFS_VERSION)
LIBSYSFS_SUFFIX		:= tar.gz
LIBSYSFS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/linux-diag/$(LIBSYSFS).$(LIBSYSFS_SUFFIX)
LIBSYSFS_SOURCE		:= $(SRCDIR)/$(LIBSYSFS).$(LIBSYSFS_SUFFIX)
LIBSYSFS_DIR		:= $(BUILDDIR)/$(LIBSYSFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBSYSFS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBSYSFS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSYSFS_PATH	:= PATH=$(CROSS_PATH)
LIBSYSFS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBSYSFS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsysfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsysfs)
	@$(call install_fixup, libsysfs,PACKAGE,libsysfs)
	@$(call install_fixup, libsysfs,PRIORITY,optional)
	@$(call install_fixup, libsysfs,VERSION,$(LIBSYSFS_VERSION))
	@$(call install_fixup, libsysfs,SECTION,base)
	@$(call install_fixup, libsysfs,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsysfs,DEPENDS,)
	@$(call install_fixup, libsysfs,DESCRIPTION,missing)

	@$(call install_copy, libsysfs, 0,0, 644, -, /usr/lib/libsysfs.so.2.0.1)
	@$(call install_link, libsysfs, libsysfs.so.2.0.1, /usr/lib/libsysfs.so.2)
	@$(call install_link, libsysfs, libsysfs.so.2.0.1, /usr/lib/libsysfs.so)

ifdef PTXCONF_LIBSYSFS_SYSTOOL
	@$(call install_copy, libsysfs, 0, 0, 0775, -, /usr/bin/systool)
endif

	@$(call install_finish, libsysfs)

	@$(call touch)

# vim: syntax=make

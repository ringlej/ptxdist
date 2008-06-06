# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSFSUTILS) += sysfsutils

#
# Paths and names
#
SYSFSUTILS_VERSION	:= 2.1.0
SYSFSUTILS		:= sysfsutils-$(SYSFSUTILS_VERSION)
SYSFSUTILS_SUFFIX	:= tar.gz
SYSFSUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/linux-diag/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_SOURCE	:= $(SRCDIR)/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_DIR		:= $(BUILDDIR)/$(SYSFSUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSFSUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSFSUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSFSUTILS_PATH	:= PATH=$(CROSS_PATH)
SYSFSUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SYSFSUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysfsutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysfsutils)
	@$(call install_fixup, sysfsutils,PACKAGE,sysfsutils)
	@$(call install_fixup, sysfsutils,PRIORITY,optional)
	@$(call install_fixup, sysfsutils,VERSION,$(SYSFSUTILS_VERSION))
	@$(call install_fixup, sysfsutils,SECTION,base)
	@$(call install_fixup, sysfsutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, sysfsutils,DEPENDS,)
	@$(call install_fixup, sysfsutils,DESCRIPTION,missing)

ifdef PTXCONF_SYSFSUTILS_LIB
	@$(call install_copy, sysfsutils, 0, 0, 0644, $(SYSFSUTILS_DIR)/lib/.libs/libsysfs.so.2.0.1, /lib/libsysfs.so.2.0.1)
	@$(call install_link, sysfsutils, libsysfs.so.2.0.1, /lib/libsysfs.so.2)
	@$(call install_link, sysfsutils, libsysfs.so.2.0.1, /lib/libsysfs.so)
endif
ifdef PTXCONF_SYSFSUTILS_SYSTOOL
	@$(call install_copy, sysfsutils, 0, 0, 0775, $(SYSFSUTILS_DIR)/cmd/systool, /bin/systool)
endif
	@$(call install_finish, sysfsutils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysfsutils_clean:
	rm -rf $(STATEDIR)/sysfsutils.*
	rm -rf $(PKGDIR)/sysfsutils_*
	rm -rf $(SYSFSUTILS_DIR)

# vim: syntax=make

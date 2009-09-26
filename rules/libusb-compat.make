# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSB_COMPAT) += libusb-compat

#
# Paths and names
#
LIBUSB_COMPAT_VERSION	:= 0.1.3
LIBUSB_COMPAT		:= libusb-compat-$(LIBUSB_COMPAT_VERSION)
LIBUSB_COMPAT_SUFFIX	:= tar.bz2
LIBUSB_COMPAT_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libusb/$(LIBUSB_COMPAT).$(LIBUSB_COMPAT_SUFFIX)
LIBUSB_COMPAT_SOURCE	:= $(SRCDIR)/$(LIBUSB_COMPAT).$(LIBUSB_COMPAT_SUFFIX)
LIBUSB_COMPAT_DIR	:= $(BUILDDIR)/$(LIBUSB_COMPAT)
LIBUSB_COMPAT_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBUSB_COMPAT_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBUSB_COMPAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSB_COMPAT_PATH	:= PATH=$(CROSS_PATH)
LIBUSB_COMPAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSB_COMPAT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb-compat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusb-compat)
	@$(call install_fixup, libusb-compat,PACKAGE,libusb-compat)
	@$(call install_fixup, libusb-compat,PRIORITY,optional)
	@$(call install_fixup, libusb-compat,VERSION,$(LIBUSB_COMPAT_VERSION))
	@$(call install_fixup, libusb-compat,SECTION,base)
	@$(call install_fixup, libusb-compat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libusb-compat,DEPENDS,)
	@$(call install_fixup, libusb-compat,DESCRIPTION,missing)

	@$(call install_copy, libusb-compat, 0, 0, 0644, -, /usr/lib/libusb-0.1.so.4.4.4 )
	@$(call install_link, libusb-compat, libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so.4)
	@$(call install_link, libusb-compat, libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so)

	@$(call install_finish, libusb-compat)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libusb-compat_clean:
	rm -rf $(STATEDIR)/libusb-compat.*
	rm -rf $(PKGDIR)/libusb-compat_*
	rm -rf $(LIBUSB_COMPAT_DIR)

# vim: syntax=make

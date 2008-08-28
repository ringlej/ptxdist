# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSB) += libusb

#
# Paths and names
#
LIBUSB_VERSION	:= 0.1.12
LIBUSB		:= libusb-$(LIBUSB_VERSION)
LIBUSB_SUFFIX	:= tar.gz
LIBUSB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libusb/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_SOURCE	:= $(SRCDIR)/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_DIR	:= $(BUILDDIR)/$(LIBUSB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBUSB_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBUSB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSB_PATH	:= PATH=$(CROSS_PATH)
LIBUSB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSB_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBUSB_DOCS
LIBUSB_AUTOCONF += --enable-build-docs
else
LIBUSB_AUTOCONF += --disable-build-docs
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusb)
	@$(call install_fixup, libusb,PACKAGE,libusb)
	@$(call install_fixup, libusb,PRIORITY,optional)
	@$(call install_fixup, libusb,VERSION,$(LIBUSB_VERSION))
	@$(call install_fixup, libusb,SECTION,base)
	@$(call install_fixup, libusb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libusb,DEPENDS,)
	@$(call install_fixup, libusb,DESCRIPTION,missing)

	@$(call install_copy, libusb, 0, 0, 0644, $(LIBUSB_DIR)/.libs/libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so.4.4.4 )
	@$(call install_link, libusb, libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so.4)
	@$(call install_link, libusb, libusb-0.1.so.4.4.4, /usr/lib/libusb.so)

	@$(call install_finish, libusb)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libusb_clean:
	rm -rf $(STATEDIR)/libusb.*
	rm -rf $(PKGDIR)/libusb_*
	rm -rf $(LIBUSB_DIR)

# vim: syntax=make

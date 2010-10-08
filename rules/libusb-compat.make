# -*-makefile-*-
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
LIBUSB_COMPAT_MD5	:= 570ac2ea085b80d1f74ddc7c6a93c0eb
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
	@$(call install_fixup, libusb-compat,PRIORITY,optional)
	@$(call install_fixup, libusb-compat,SECTION,base)
	@$(call install_fixup, libusb-compat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libusb-compat,DESCRIPTION,missing)

	@$(call install_lib, libusb-compat, 0, 0, 0644, libusb-0.1)

	@$(call install_finish, libusb-compat)

	@$(call touch)

# vim: syntax=make

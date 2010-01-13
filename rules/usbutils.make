# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USBUTILS) += usbutils

#
# Paths and names
#
USBUTILS_VERSION	:= 0.86
USBUTILS		:= usbutils-$(USBUTILS_VERSION)
USBUTILS_SUFFIX		:= tar.gz
USBUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/linux-usb/$(USBUTILS).$(USBUTILS_SUFFIX)
USBUTILS_SOURCE		:= $(SRCDIR)/$(USBUTILS).$(USBUTILS_SUFFIX)
USBUTILS_DIR		:= $(BUILDDIR)/$(USBUTILS)
USBUTILS_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(USBUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, USBUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

USBUTILS_PATH	:= PATH=$(CROSS_PATH)
USBUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
USBUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-largefile \
	--disable-zlib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usbutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usbutils)
	@$(call install_fixup, usbutils,PACKAGE,usbutils)
	@$(call install_fixup, usbutils,PRIORITY,optional)
	@$(call install_fixup, usbutils,VERSION,$(USBUTILS_VERSION))
	@$(call install_fixup, usbutils,SECTION,base)
	@$(call install_fixup, usbutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, usbutils,DEPENDS,)
	@$(call install_fixup, usbutils,DESCRIPTION,missing)

ifdef PTXCONF_USBUTILS_LSUSB
	@$(call install_copy, usbutils, 0, 0, 0755, -, \
		/usr/sbin/lsusb)
endif
	@$(call install_copy, usbutils, 0, 0, 0644, -, \
		/usr/share/usb.ids,n)

	@$(call install_finish, usbutils)

	@$(call touch)

# vim: syntax=make

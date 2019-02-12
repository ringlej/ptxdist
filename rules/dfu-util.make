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
PACKAGES-$(PTXCONF_DFU_UTIL) += dfu-util

#
# Paths and names
#
DFU_UTIL_VERSION	:= 0.9
DFU_UTIL_MD5		:= 233bb1e08ef4b405062445d84e28fde6
DFU_UTIL		:= dfu-util-$(DFU_UTIL_VERSION)
DFU_UTIL_SUFFIX		:= tar.gz
DFU_UTIL_URL		:= http://dfu-util.sourceforge.net/releases/$(DFU_UTIL).$(DFU_UTIL_SUFFIX)
DFU_UTIL_SOURCE		:= $(SRCDIR)/$(DFU_UTIL).$(DFU_UTIL_SUFFIX)
DFU_UTIL_DIR		:= $(BUILDDIR)/$(DFU_UTIL)
DFU_UTIL_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DFU_UTIL_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_usb_libusb_init=no

#
# autoconf
#
DFU_UTIL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dfu-util.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dfu-util)
	@$(call install_fixup, dfu-util,PRIORITY,optional)
	@$(call install_fixup, dfu-util,SECTION,base)
	@$(call install_fixup, dfu-util,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dfu-util,DESCRIPTION,missing)

	@$(call install_copy, dfu-util, 0, 0, 0755, -, /usr/bin/dfu-util)

	@$(call install_finish, dfu-util)

	@$(call touch)

# vim: syntax=make

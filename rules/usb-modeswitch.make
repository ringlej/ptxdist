# -*-makefile-*-
#
# Copyright (C) 2013 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USB_MODESWITCH) += usb-modeswitch

#
# Paths and names
#
USB_MODESWITCH_VERSION	:= 1.2.5
USB_MODESWITCH_MD5	:= c393603908eceab95444c5bde790f6f0
USB_MODESWITCH		:= usb-modeswitch-$(USB_MODESWITCH_VERSION)
USB_MODESWITCH_SUFFIX	:= tar.bz2
USB_MODESWITCH_URL	:= http://www.draisberghof.de/usb_modeswitch/$(USB_MODESWITCH).$(USB_MODESWITCH_SUFFIX)
USB_MODESWITCH_SOURCE	:= $(SRCDIR)/$(USB_MODESWITCH).$(USB_MODESWITCH_SUFFIX)
USB_MODESWITCH_DIR	:= $(BUILDDIR)/$(USB_MODESWITCH)
USB_MODESWITCH_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
USB_MODESWITCH_CONF_TOOL	:= NO
USB_MODESWITCH_MAKE_ENV		:= $(CROSS_ENV)
USB_MODESWITCH_MAKE_OPT		:= $(CROSS_ENV_PROGS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usb-modeswitch.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usb-modeswitch)
	@$(call install_fixup, usb-modeswitch,PRIORITY,optional)
	@$(call install_fixup, usb-modeswitch,SECTION,base)
	@$(call install_fixup, usb-modeswitch,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, usb-modeswitch,DESCRIPTION,missing)

	@$(call install_copy, usb-modeswitch, 0, 0, 0755, -, /usr/sbin/usb_modeswitch)

	@$(call install_finish, usb-modeswitch)

	@$(call touch)

# vim: syntax=make

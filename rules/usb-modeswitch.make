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
USB_MODESWITCH_VERSION	:= 2.5.2
USB_MODESWITCH_MD5	:= 16b9a8efa1bf8fbd7d5612757eae4f26
USB_MODESWITCH		:= usb-modeswitch-$(USB_MODESWITCH_VERSION)
USB_MODESWITCH_SUFFIX	:= tar.bz2
USB_MODESWITCH_URL	:= http://www.draisberghof.de/usb_modeswitch/$(USB_MODESWITCH).$(USB_MODESWITCH_SUFFIX)
USB_MODESWITCH_SOURCE	:= $(SRCDIR)/$(USB_MODESWITCH).$(USB_MODESWITCH_SUFFIX)
USB_MODESWITCH_DIR	:= $(BUILDDIR)/$(USB_MODESWITCH)
USB_MODESWITCH_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
USB_MODESWITCH_CONF_TOOL	:= NO
USB_MODESWITCH_MAKE_ENV		:= $(CROSS_ENV)
USB_MODESWITCH_MAKE_OPT		:= $(CROSS_ENV_PROGS)
USB_MODESWITCH_INSTALL_OPT	:= \
	UDEVDIR=$(USB_MODESWITCH_PKGDIR)/usr/lib/udev \
	install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usb-modeswitch.install:
	@$(call targetinfo)
	@$(call world/install, USB_MODESWITCH)
	@install -vD -m 0644 $(USB_MODESWITCH_DIR)/usb_modeswitch@.service \
		$(USB_MODESWITCH_PKGDIR)/usr/lib/systemd/system/usb_modeswitch@.service
	@$(call touch)

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

	@$(call install_copy, usb-modeswitch, 0, 0, 0755, -, \
		/usr/sbin/usb_modeswitch)
ifneq ($(PTXCONF_USB_MODESWITCH_UDEV_HELPER)$(PTXCONF_USB_MODESWITCH_SYSTEMD_UNIT),)
	@$(call install_copy, usb-modeswitch, 0, 0, 0755, -, \
		/usr/sbin/usb_modeswitch_dispatcher)
	@$(call install_alternative, usb-modeswitch, 0, 0, 0644, \
		/etc/usb_modeswitch.conf)
endif
ifdef PTXCONF_USB_MODESWITCH_UDEV_HELPER
	@$(call install_copy, usb-modeswitch, 0, 0, 0755, -, \
		/usr/lib/udev/usb_modeswitch)
endif
ifdef PTXCONF_USB_MODESWITCH_SYSTEMD_UNIT
	@$(call install_copy, usb-modeswitch, 0, 0, 0644, -, \
		/usr/lib/systemd/system/usb_modeswitch@.service)
endif

	@$(call install_finish, usb-modeswitch)

	@$(call touch)

# vim: syntax=make

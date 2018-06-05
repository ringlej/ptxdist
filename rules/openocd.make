# -*-makefile-*-
#
# Copyright (C) 2014 by Andreas Pretzsch <apr@cn-eng.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_OPENOCD) += openocd

OPENOCD_VERSION	:= 0.8.0
OPENOCD_MD5	:= 6d83c34763a5f1d1ac7ad83c5a11f4fb
OPENOCD		:= openocd-$(OPENOCD_VERSION)
OPENOCD_SUFFIX	:= tar.bz2
OPENOCD_URL	:= $(call ptx/mirror, SF, openocd/$(OPENOCD).$(OPENOCD_SUFFIX))
OPENOCD_SOURCE	:= $(SRCDIR)/$(OPENOCD).$(OPENOCD_SUFFIX)
OPENOCD_DIR	:= $(BUILDDIR)/$(OPENOCD)
# License: OpenOCD: GPLv2+, jimtcl: BSD
OPENOCD_LICENSE	:= GPL-2.0-or-later AND BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENOCD_CONF_TOOL	:= autoconf
OPENOCD_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-werror \
	--$(call ptx/endis, PTXCONF_OPENOCD_DUMMY)-dummy \
	--$(call ptx/endis, PTXCONF_OPENOCD_FTDI)-ftdi \
	--$(call ptx/endis, PTXCONF_OPENOCD_STLINK)-stlink \
	--$(call ptx/endis, PTXCONF_OPENOCD_TI_ICDI)-ti-icdi \
	--$(call ptx/endis, PTXCONF_OPENOCD_ULINK)-ulink \
	--$(call ptx/endis, PTXCONF_OPENOCD_USB_BLASTER_2)-usb-blaster-2 \
	--$(call ptx/endis, PTXCONF_OPENOCD_JLINK)-jlink \
	--$(call ptx/endis, PTXCONF_OPENOCD_OSBDM)-osbdm \
	--$(call ptx/endis, PTXCONF_OPENOCD_OPENDOUS)-opendous \
	--$(call ptx/endis, PTXCONF_OPENOCD_AICE)-aice \
	--$(call ptx/endis, PTXCONF_OPENOCD_VSLLINK)-vsllink \
	--$(call ptx/endis, PTXCONF_OPENOCD_USBPROG)-usbprog \
	--$(call ptx/endis, PTXCONF_OPENOCD_RLINK)-rlink \
	--$(call ptx/endis, PTXCONF_OPENOCD_ARMJTAGEW)-armjtagew \
	--$(call ptx/endis, PTXCONF_OPENOCD_CMSIS_DAP)-cmsis-dap \
	--$(call ptx/endis, PTXCONF_OPENOCD_PARPORT)-parport \
	--$(call ptx/disen, PTXCONF_OPENOCD_PARPORT_DISABLE_PARPORT_PPDEV)-parport-ppdev \
	--$(call ptx/endis, PTXCONF_OPENOCD_PARPORT_GIVEIO)-parport-giveio \
	--$(call ptx/endis, PTXCONF_OPENOCD_JTAG_VPI)-jtag_vpi \
	--$(call ptx/endis, PTXCONF_OPENOCD_USB_BLASTER_LIBFTDI)-usb_blaster_libftdi \
	--$(call ptx/endis, PTXCONF_OPENOCD_USB_BLASTER_FTD2XX)-usb_blaster_ftd2xx \
	--$(call ptx/endis, PTXCONF_OPENOCD_AMTJTAGACCEL)-amtjtagaccel \
	--$(call ptx/endis, PTXCONF_OPENOCD_ZY1000)-zy1000 \
	--$(call ptx/endis, PTXCONF_OPENOCD_ZY1000_MASTER)-zy1000-master \
	--$(call ptx/endis, PTXCONF_OPENOCD_IOUTIL)-ioutil \
	--$(call ptx/endis, PTXCONF_OPENOCD_EP93XX)-ep93xx \
	--$(call ptx/endis, PTXCONF_OPENOCD_AT91RM9200)-at91rm9200 \
	--$(call ptx/endis, PTXCONF_OPENOCD_BCM2835GPIO)-bcm2835gpio \
	--$(call ptx/endis, PTXCONF_OPENOCD_GW16012)-gw16012 \
	--$(call ptx/endis, PTXCONF_OPENOCD_PRESTO_LIBFTDI)-presto_libftdi \
	--$(call ptx/endis, PTXCONF_OPENOCD_PRESTO_FTD2XX)-presto_ftd2xx \
	--$(call ptx/endis, PTXCONF_OPENOCD_OPENJTAG_FTD2XX)-openjtag_ftd2xx \
	--$(call ptx/endis, PTXCONF_OPENOCD_OPENJTAG_FTDI)-openjtag_ftdi \
	--$(call ptx/endis, PTXCONF_OPENOCD_OOCD_TRACE)-oocd_trace \
	--$(call ptx/endis, PTXCONF_OPENOCD_BUSPIRATE)-buspirate \
	--$(call ptx/endis, PTXCONF_OPENOCD_SYSFSGPIO)-sysfsgpio \
	--disable-minidriver-dummy \
	--$(call ptx/endis, PTXCONF_OPENOCD_REMOTE_BITBANG)-remote-bitbang

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openocd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openocd)
	@$(call install_fixup, openocd,PRIORITY,optional)
	@$(call install_fixup, openocd,SECTION,base)
	@$(call install_fixup, openocd,AUTHOR,"Andreas Pretzsch <apr@cn-eng.de>")
	@$(call install_fixup, openocd,DESCRIPTION,"OpenOCD - Open On-Chip Debugger")

	@$(call install_copy, openocd, 0, 0, 0755, -, /usr/bin/openocd)
ifneq ($(call remove_quotes,$(PTXCONF_OPENOCD_SCRIPTDIR)),)
	@$(call install_alternative_tree, openocd, 0, 0, $(PTXCONF_OPENOCD_SCRIPTDIR))
endif

	@$(call install_finish, openocd)

	@$(call touch)


# vim: syntax=make

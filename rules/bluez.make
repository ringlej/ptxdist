# -*-makefile-*-
#
# Copyright (C) 2010 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLUEZ) += bluez

#
# Paths and names
#
BLUEZ_VERSION	:= 4.96
BLUEZ_MD5	:= 1d363ed751f89133f953182e843b2a19 296111afac49e3f9035085ac14daf518
BLUEZ		:= bluez-$(BLUEZ_VERSION)
BLUEZ_SUFFIX	:= tar.gz
BLUEZ_URL	:= $(call ptx/mirror, KERNEL, bluetooth/$(BLUEZ).$(BLUEZ_SUFFIX))
BLUEZ_SOURCE	:= $(SRCDIR)/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_DIR	:= $(BUILDDIR)/$(BLUEZ)
BLUEZ_LICENSE	:= GPLv2+ LGPLv2.1+

# the tools don't depend on the generated headers
BLUEZ_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#
# autoconf
#
BLUEZ_CONF_TOOL	:= autoconf
BLUEZ_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--enable-optimization \
	--disable-fortify \
	--disable-pie \
	--enable-network \
	--disable-sap \
	--disable-proximity \
	--enable-serial \
	--enable-input \
	--enable-audio \
	--enable-service \
	--disable-health \
	--disable-pnat \
	--disable-gatt-example \
	--$(call ptx/endis, PTXCONF_BLUEZ_GSTREAMER)-gstreamer \
	--$(call ptx/endis, PTXCONF_BLUEZ_ALSA)-alsa \
	--enable-usb \
	--disable-tracer \
	--enable-tools \
	--enable-bccmd \
	--disable-pcmcia \
	--disable-hid2hci \
	--disable-dfutool \
	--disable-hidd \
	--disable-pand \
	--disable-dund \
	--disable-cups \
	--enable-test \
	--enable-datafiles \
	--enable-debug \
	--disable-maemo6 \
	--disable-dbusoob \
	--disable-wiimote \
	--disable-hal \
	--disable-thermometer \
	--disable-capng \
	--with-systemdunitdir=/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bluez.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  bluez)
	@$(call install_fixup, bluez,PRIORITY,optional)
	@$(call install_fixup, bluez,SECTION,base)
	@$(call install_fixup, bluez,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, bluez,DESCRIPTION,missing)

	@$(call install_lib, bluez, 0, 0, 0644, libbluetooth)

ifdef PTXCONF_BLUEZ_ALSA
	@$(foreach alsamod, ctl_bluetooth pcm_bluetooth, \
		$(call install_lib, bluez, 0, 0, 0644, \
			alsa-lib/libasound_module_$(alsamod));)
endif

ifdef PTXCONF_BLUEZ_GSTREAMER
	@$(call install_lib, bluez, 0, 0, 0644, gstreamer-0.10/libgstbluetooth)
endif

ifdef PTXCONF_BLUEZ_UTILS
	@$(foreach binprogram, ciptool l2ping hcitool rctest rfcomm sdptool, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/bin/$(binprogram));)

	@$(foreach sbinprogram, bccmd hciattach hciconfig, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/sbin/$(sbinprogram));)
endif

ifdef PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS
	@$(foreach testprog, simple-agent simple-service test-telephony \
			test-adapter test-audio test-device test-discovery \
			test-input test-manager test-network test-serial \
			test-service test-telephony test-textfile \
			monitor-bluetooth, \
		$(call install_copy, bluez, 0, 0, 0755, \
			$(BLUEZ_DIR)/test/$(testprog), \
			/usr/share/doc/bluez/examples/$(testprog));)
endif

	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/sbin/bluetoothd)

	@$(call install_copy, bluez, 0, 0, 0644, -, \
		/etc/dbus-1/system.d/bluetooth.conf)
	@$(call install_tree, bluez, 0, 0, -, /lib/udev/rules.d/)

ifdef PTXCONF_BLUEZ_SYSTEMD_UNIT
	@$(call install_copy, bluez, 0, 0, 0644, -, \
		/lib/systemd/system/bluetooth.service)
	@$(call install_link, bluez, ../bluetooth.service, \
		/lib/systemd/system/multi-user.target.wants/bluetooth.service)
endif

	@$(call install_finish, bluez)
	@$(call touch)

# vim: syntax=make

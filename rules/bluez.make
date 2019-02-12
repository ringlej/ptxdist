# -*-makefile-*-
#
# Copyright (C) 2010 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
# Copyright (C) 2018 Pengutronix, Roland Hieber <r.hieber@pengutronix.de>
#
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
BLUEZ_VERSION	:= 5.50
BLUEZ_MD5	:= 860349d2afebf130f772c0f2943b5a27
BLUEZ		:= bluez-$(BLUEZ_VERSION)
BLUEZ_SUFFIX	:= tar.gz
BLUEZ_URL	:= $(call ptx/mirror, KERNEL, bluetooth/$(BLUEZ).$(BLUEZ_SUFFIX))
BLUEZ_SOURCE	:= $(SRCDIR)/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_DIR	:= $(BUILDDIR)/$(BLUEZ)
BLUEZ_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
BLUEZ_LICENSE_FILES := \
	  file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e \
	  file://COPYING.LIB;md5=fb504b67c50331fc78734fed90fb0e09

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BLUEZ_CONF_TOOL	:= autoconf
BLUEZ_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--enable-optimization \
	--disable-debug \
	--disable-pie \
	--enable-threads \
	--disable-backtrace \
	--enable-library \
	--$(call ptx/endis, PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS)-test \
	--disable-nfc \
	--disable-sap \
	--enable-a2dp \
	--enable-avrcp \
	--enable-network \
	--enable-hid \
	--enable-hog \
	--disable-health \
	--$(call ptx/endis, PTXCONF_BLUEZ_TOOLS)-tools \
	--$(call ptx/endis, PTXCONF_BLUEZ_TOOLS)-monitor \
	--enable-udev \
	--disable-cups \
	--disable-mesh \
	--disable-midi \
	--enable-obex \
	--disable-btpclient \
	--$(call ptx/endis, PTXCONF_BLUEZ_CLIENT)-client \
	--enable-systemd \
	--enable-datafiles \
	--disable-manpages \
	--disable-experimental \
	--$(call ptx/endis, PTXCONF_BLUEZ_TOOLS_DEPRECATED)-deprecated \
	--disable-sixaxis \
	--disable-android \
	--disable-logger \
	--with-dbusconfdir=/usr/share \
	--with-dbussystembusdir=/usr/share/dbus-1/system-services \
	--with-dbussessionbusdir=/usr/share/dbus-1/services \
	--with-udevdir=/usr/lib/udev \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--with-systemduserunitdir=/usr/lib/systemd/user

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bluez.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  bluez)
	@$(call install_fixup, bluez,PRIORITY,optional)
	@$(call install_fixup, bluez,SECTION,base)
	@$(call install_fixup, bluez,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, bluez,DESCRIPTION, "Bluetooth protocol stack")

	@$(call install_lib, bluez, 0, 0, 0644, libbluetooth)

	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/libexec/bluetooth/bluetoothd)
	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/libexec/bluetooth/obexd)
	@$(call install_lib, bluez, 0, 0, 0644, libbluetooth)

ifdef PTXCONF_BLUEZ_TOOLS
	@$(foreach binprogram, bccmd bluemoon btattach btmon hex2hcd l2ping \
			l2test mpris-proxy rctest, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/bin/$(binprogram))$(ptx/nl))

ifdef PTXCONF_BLUEZ_TOOLS_DEPRECATED
	@$(foreach binprogram, ciptool hciattach hciconfig hcidump hcitool \
			rfcomm sdptool, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/bin/$(binprogram))$(ptx/nl))
endif
endif

ifdef PTXCONF_BLUEZ_CLIENT
	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/bin/bluetoothctl)
endif

ifdef PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS
	@$(foreach testdata, service-did.xml service-ftp.xml service-opp.xml \
			service-record.dtd service-spp.xml, \
		$(call install_copy, bluez, 0, 0, 0644, -, \
			/usr/lib/bluez/test/$(testdata))$(ptx/nl))

	@$(foreach testprog, bluezutils.py dbusdef.py example-advertisement \
			example-gatt-client example-gatt-server ftp-client \
			list-devices map-client monitor-bluetooth opp-client \
			pbap-client sap_client.py simple-agent simple-endpoint \
			simple-player test-adapter test-device test-discovery \
			test-gatt-profile test-health test-health-sink test-hfp \
			test-manager test-nap test-network test-profile \
			test-sap-server, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/lib/bluez/test/$(testprog))$(ptx/nl))
	@$(foreach testprog, bluezutils.py dbusdef.py sap_client.py, \
		$(call install_copy, bluez, 0, 0, 0644, -, \
			/usr/lib/bluez/test/$(testprog))$(ptx/nl))
endif

	@$(call install_alternative, bluez, 0, 0, 0644, \
		/usr/share/dbus-1/system.d/bluetooth.conf)
	@$(call install_alternative, bluez, 0, 0, 0644, \
		/usr/lib/udev/rules.d/97-hid2hci.rules)
	@$(call install_copy, bluez, 0, 0, 0644, -, /usr/lib/udev/hid2hci)

ifdef PTXCONF_BLUEZ_SYSTEMD_UNIT
	@$(call install_alternative, bluez, 0, 0, 0644, \
		/usr/lib/systemd/system/bluetooth.service)
	@$(call install_link, bluez, ../bluetooth.service, \
		/usr/lib/systemd/system/multi-user.target.wants/bluetooth.service)
	@$(call install_alternative, bluez, 0, 0, 0644, \
		/usr/lib/systemd/user/obex.service)
endif

	@$(call install_finish, bluez)
	@$(call touch)

# vim: syntax=make

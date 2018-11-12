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
BLUEZ_VERSION	:= 5.30
BLUEZ_MD5	:= a7b99d40cd78c7497abdfd7f024fd07b
BLUEZ		:= bluez-$(BLUEZ_VERSION)
BLUEZ_SUFFIX	:= tar.gz
BLUEZ_URL	:= $(call ptx/mirror, KERNEL, bluetooth/$(BLUEZ).$(BLUEZ_SUFFIX))
BLUEZ_SOURCE	:= $(SRCDIR)/$(BLUEZ).$(BLUEZ_SUFFIX)
BLUEZ_DIR	:= $(BUILDDIR)/$(BLUEZ)
BLUEZ_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
ifdef PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS
BLUEZ_DEVPKG	:= NO
endif

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
	--enable-library \
	--$(call ptx/endis, PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS)-test \
	--enable-tools \
	--enable-monitor \
	--enable-udev \
	--disable-cups \
	--disable-obex \
	--$(call ptx/endis, PTXCONF_BLUEZ_CLIENT)-client \
	--enable-systemd \
	--enable-datafiles \
	--disable-manpages \
	--disable-experimental \
	--disable-sixaxis \
	--disable-android \
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

ifdef PTXCONF_BLUEZ_UTILS
	@$(foreach binprogram, bccmd bluemoon btmon ciptool \
			hciattach hciconfig hcidump hcitool hex2hcd l2ping \
			l2test mpris-proxy rctest rfcomm sdptool, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/bin/$(binprogram))$(ptx/nl))
endif

ifdef PTXCONF_BLUEZ_CLIENT
	@$(call install_copy, bluez, 0, 0, 0755, -, /usr/bin/bluetoothctl)

	@$(call install_copy, bluez, 0, 0, 0755, $(BLUEZ_DIR)/attrib/gatttool, \
		/usr/bin/gatttool)
endif

ifdef PTXCONF_BLUEZ_INSTALL_TESTSCRIPTS
	@$(foreach testdata, service-ftp.xml service-did.xml service-spp.xml \
			service-record.dtd service-opp.xml, \
		$(call install_copy, bluez, 0, 0, 0644, -, \
			/usr/lib/bluez/test/$(testdata))$(ptx/nl))

	@$(foreach testprog, list-devices opp-client \
			simple-endpoint test-alert test-discovery \
			test-heartrate test-nap test-proximity \
			map-client pbap-client simple-player test-cyclingspeed \
			test-health test-hfp test-network test-sap-server \
			ftp-client monitor-bluetooth simple-agent \
			test-adapter test-device test-health-sink test-manager \
			test-profile test-thermometer, \
		$(call install_copy, bluez, 0, 0, 0755, -, \
			/usr/lib/bluez/test/$(testprog))$(ptx/nl))
	@$(foreach testprog, bluezutils.py dbusdef.py sap_client.py, \
		$(call install_copy, bluez, 0, 0, 0644, -, \
			/usr/lib/bluez/test/$(testprog))$(ptx/nl))
endif

	@$(call install_copy, bluez, 0, 0, 0644, -, \
		/usr/share/dbus-1/system.d/bluetooth.conf)
	@$(call install_tree, bluez, 0, 0, -, /usr/lib/udev/rules.d/)

ifdef PTXCONF_BLUEZ_SYSTEMD_UNIT
	@$(call install_copy, bluez, 0, 0, 0644, -, \
		/usr/lib/systemd/system/bluetooth.service)
	@$(call install_link, bluez, ../bluetooth.service, \
		/usr/lib/systemd/system/multi-user.target.wants/bluetooth.service)
	@$(call install_copy, bluez, 0, 0, 0644, -, \
		/usr/lib/systemd/user/obex.service)
endif

	@$(call install_finish, bluez)
	@$(call touch)

# vim: syntax=make

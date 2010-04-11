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
PACKAGES-$(PTXCONF_CONNMAN) += connman

#
# Paths and names
#
CONNMAN_VERSION	:= 0.10
CONNMAN		:= connman-$(CONNMAN_VERSION)
CONNMAN_SUFFIX	:= tar.gz
CONNMAN_URL	:= http://ftp.moblin.org/connman/releases/$(CONNMAN).$(CONNMAN_SUFFIX)
CONNMAN_SOURCE	:= $(SRCDIR)/$(CONNMAN).$(CONNMAN_SUFFIX)
CONNMAN_DIR	:= $(BUILDDIR)/$(CONNMAN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CONNMAN_SOURCE):
	@$(call targetinfo)
	@$(call get, CONNMAN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CONNMAN_PATH	:= PATH=$(CROSS_PATH)
CONNMAN_ENV 	:= \
	$(CROSS_ENV) \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=y

#
# autoconf
#
CONNMAN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-debug \
	--enable-threads \
	--enable-datafiles

ifdef PTXCONF_CONNMAN_LOOPBACK
CONNMAN_AUTOCONF += --enable-loopback
else
CONNMAN_AUTOCONF += --disable-loopback
endif
ifdef PTXCONF_CONNMAN_ETHERNET
CONNMAN_AUTOCONF += --enable-ethernet
else
CONNMAN_AUTOCONF += --disable-ethernet
endif
ifdef PTXCONF_CONNMAN_WIFI
CONNMAN_AUTOCONF += --enable-wifi
else
CONNMAN_AUTOCONF += --disable-wifi
endif
ifdef PTXCONF_CONNMAN_WIMAX
CONNMAN_AUTOCONF += --enable-wimax
else
CONNMAN_AUTOCONF += --disable-wimax
endif
ifdef PTXCONF_CONNMAN_BLUETOOTH
CONNMAN_AUTOCONF += --enable-bluetooth
else
CONNMAN_AUTOCONF += --disable-bluetooth
endif
ifdef PTXCONF_CONNMAN_UDHCP
CONNMAN_AUTOCONF += --enable-udhcp
else
CONNMAN_AUTOCONF += --disable-udhcp
endif
ifdef PTXCONF_CONNMAN_DHCLIENT
CONNMAN_AUTOCONF += --enable-dhclient
else
CONNMAN_AUTOCONF += --disable-dhclient
endif
ifdef PTXCONF_CONNMAN_RESOLVCONF
CONNMAN_AUTOCONF += --enable-resolvconf
else
CONNMAN_AUTOCONF += --disable-resolvconf
endif
ifdef PTXCONF_CONNMAN_DNSPROXY
CONNMAN_AUTOCONF += --enable-dnsproxy
else
CONNMAN_AUTOCONF += --disable-dnsproxy
endif
ifdef PTXCONF_CONNMAN_NOVATEL
CONNMAN_AUTOCONF += --enable-novatel
else
CONNMAN_AUTOCONF += --disable-novatel
endif
ifdef PTXCONF_CONNMAN_HUAWEI
CONNMAN_AUTOCONF += --enable-huawei
else
CONNMAN_AUTOCONF += --disable-huawei
endif
ifdef PTXCONF_CONNMAN_HSO
CONNMAN_AUTOCONF += --enable-hso
else
CONNMAN_AUTOCONF += --disable-hso
endif
ifdef PTXCONF_CONNMAN_PPP
CONNMAN_AUTOCONF += --enable-ppp
else
CONNMAN_AUTOCONF += --disable-ppp
endif
ifdef PTXCONF_CONNMAN_UDEV
CONNMAN_AUTOCONF += --enable-udev
else
CONNMAN_AUTOCONF += --disable-udev
endif
ifdef PTXCONF_CONNMAN_POLKIT
CONNMAN_AUTOCONF += --enable-polkit
else
CONNMAN_AUTOCONF += --disable-polkit
endif
ifdef PTXCONF_CONNMAN_CLIENT
CONNMAN_AUTOCONF += --enable-client
else
CONNMAN_AUTOCONF += --disable-client
endif
ifdef PTXCONF_CONNMAN_FAKE
CONNMAN_AUTOCONF += --enable-fake
else
CONNMAN_AUTOCONF += --disable-fake
endif

CONNMAN_TESTS := \
	connect-network \
	create-network \
	debug-connman \
	disable-device \
	disable-network \
	disconnect-network \
	enable-device \
	get-state \
	list-connections \
	list-devices \
	list-networks \
	list-profiles \
	monitor-connman \
	select-connection \
	select-network \
	set-address \
	set-passphrase \
	set-policy \
	show-introspection \
	simple-agent \
	start-scanning \
	test-compat \
	test-connman \
	test-manager

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.install:
	@$(call targetinfo)
	@$(call install, CONNMAN)
	install -D -m 755 "$(CONNMAN_DIR)/client/cm" \
		"$(CONNMAN_PKGDIR)/usr/sbin/cm"
	@for i in $(CONNMAN_TESTS); do \
		install -D -m 755 "$(CONNMAN_DIR)/test/$$i" \
			"$(CONNMAN_PKGDIR)/usr/sbin/cm-$$i"; \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.targetinstall:
	@$(call targetinfo)

	@$(call install_init, connman)
	@$(call install_fixup, connman,PACKAGE,connman)
	@$(call install_fixup, connman,PRIORITY,optional)
	@$(call install_fixup, connman,VERSION,$(CONNMAN_VERSION))
	@$(call install_fixup, connman,SECTION,base)
	@$(call install_fixup, connman,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, connman,DEPENDS,)
	@$(call install_fixup, connman,DESCRIPTION,missing)

#	# binary
	@$(call install_copy, connman, 0, 0, 0755, -, /usr/sbin/connmand)

#	# dirs
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman)
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman/scripts)
	@$(call install_copy, connman, 0, 0, 0755, /usr/lib/connman/plugins)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_CONNMAN_STARTSCRIPT
	@$(call install_alternative, connman, 0, 0, 0755, /etc/init.d/connman, n)
endif
endif

#	# dbus config
	@$(call install_alternative, connman, 0, 0, 0644, /etc/dbus-1/system.d/connman.conf)

#	#
#	# plugins
#	#
ifdef PTXCONF_CONNMAN_BLUETOOTH
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/bluetooth.so)
endif
ifdef PTXCONF_CONNMAN_DHCLIENT
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/dhclient.so)
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/scripts/dhclient.conf)
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/scripts/dhclient-script)
endif
ifdef PTXCONF_CONNMAN_DNSPROXY
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/dnsproxy.so)
endif
ifdef PTXCONF_CONNMAN_ETHERNET
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/ethernet.so)
endif
ifdef PTXCONF_CONNMAN_FAKE
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/fake.so)
endif
ifdef PTXCONF_CONNMAN_HSO
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/hso.so)
endif
ifdef PTXCONF_CONNMAN_LOOPBACK
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/loopback.so)
endif
ifdef PTXCONF_CONNMAN_POLKIG
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/polkit.so)
endif
ifdef PTXCONF_CONNMAN_RESOLVCONF
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/resolvconf.so)
endif
ifdef PTXCONF_CONNMAN_UDHCP
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/udhcp.so)
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/scripts/udhcpc-script)
endif
ifdef PTXCONF_CONNMAN_WIFI
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/wifi.so)
endif
ifdef PTXCONF_CONNMAN_WIMAX
	@$(call install_copy, connman, 0, 0, 0644, -, /usr/lib/connman/plugins/wimax.so)
endif

#	# command line client
ifdef PTXCONF_CONNMAN_CLIENT
	@$(call install_copy, connman, 0, 0, 0755, -, /usr/sbin/cm)
endif

#	# python tests
ifdef PTXCONF_CONNMAN_TESTS
	@for i in $(CONNMAN_TESTS); do \
		$(call install_copy, connman, 0, 0, 0755, -, \
			/usr/sbin/cm-$$i); \
	done
endif

	@$(call install_finish, connman)

	@$(call touch)

# vim: syntax=make

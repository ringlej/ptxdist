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
CONNMAN_VERSION	:= 1.0
CONNMAN_MD5	:= 0bdda5c38ed4b8cc2a5840dcd84a6805
CONNMAN		:= connman-$(CONNMAN_VERSION)
CONNMAN_SUFFIX	:= tar.gz
CONNMAN_URL	:= $(call ptx/mirror, KERNEL, network/connman/$(CONNMAN).$(CONNMAN_SUFFIX))
CONNMAN_SOURCE	:= $(SRCDIR)/$(CONNMAN).$(CONNMAN_SUFFIX)
CONNMAN_DIR	:= $(BUILDDIR)/$(CONNMAN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CONNMAN_CONF_TOOL	:= autoconf
CONNMAN_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-debug \
	--enable-threads \
	--disable-hh2serial-gps \
	--disable-openconnect \
	--disable-openvpn \
	--disable-vpnc \
	--disable-l2tp \
	--disable-pptp \
	--$(call ptx/endis, PTXCONF_CONNMAN_WIMAX)-iwmx \
	--disable-iospm \
	--disable-tist \
	--disable-test \
	--disable-nmcompat \
	--$(call ptx/endis, PTXCONF_CONNMAN_POLKIT)-polkit \
	--$(call ptx/endis, PTXCONF_CONNMAN_LOOPBACK)-loopback \
	--$(call ptx/endis, PTXCONF_CONNMAN_ETHERNET)-ethernet \
	--$(call ptx/endis, PTXCONF_CONNMAN_WIFI)-wifi \
	--$(call ptx/endis, PTXCONF_CONNMAN_BLUETOOTH)-bluetooth \
	--disable-ofono \
	--disable-pacrunner \
	--$(call ptx/endis, PTXCONF_CONNMAN_CLIENT)-client \
	--disable-tools \
	--enable-datafiles \
	--with-systemdunitdir=/lib/systemd/system

CONNMAN_TESTS := \
	backtrace \
	connect-vpn \
	disable-tethering \
	disconnect-vpn \
	enable-tethering \
	get-global-timeservers \
	get-proxy-autoconfig \
	get-services \
	get-state \
	list-services \
	monitor-connman \
	monitor-services \
	service-move-before \
	set-domains \
	set-global-timeservers \
	set-ipv4-method \
	set-ipv6-method \
	set-nameservers \
	set-proxy \
	show-introspection \
	simple-agent \
	test-clock \
	test-compat \
	test-connman \
	test-counter \
	test-manager \
	test-new-supplicant \
	test-session \
	test-supplicant

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.install:
	@$(call targetinfo)
	@$(call install, CONNMAN)
ifdef PTXCONF_CONNMAN_CLIENT
	install -D -m 755 "$(CONNMAN_DIR)/client/cm" \
		"$(CONNMAN_PKGDIR)/usr/sbin/cm"
endif
ifdef PTXCONF_CONNMAN_TESTS
	@$(foreach test, $(CONNMAN_TESTS), \
		install -D -m 755 "$(CONNMAN_DIR)/test/$(test)" \
			"$(CONNMAN_PKGDIR)/usr/sbin/cm-$(test)";)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/connman.targetinstall:
	@$(call targetinfo)

	@$(call install_init, connman)
	@$(call install_fixup, connman,PRIORITY,optional)
	@$(call install_fixup, connman,SECTION,base)
	@$(call install_fixup, connman,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, connman,DESCRIPTION,missing)

#	# binary
	@$(call install_copy, connman, 0, 0, 0755, -, /usr/sbin/connmand)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_CONNMAN_STARTSCRIPT
	@$(call install_alternative, connman, 0, 0, 0755, /etc/init.d/connman, n)

ifneq ($(call remove_quotes, $(PTXCONF_CONNMAN_BBINIT_LINK)),)
	@$(call install_link, connman, \
		../init.d/connman, \
		/etc/rc.d/$(PTXCONF_CONNMAN_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_CONNMAN_SYSTEMD_UNIT
	@$(call install_alternative, connman, 0, 0, 0644, \
		/lib/systemd/system/connman.service)
	@$(call install_link, connman, ../connman.service, \
		/lib/systemd/system/multi-user.target.wants/connman.service)
	@$(call install_alternative, connman, 0, 0, 0644, \
		/lib/systemd/system/connman-ignore.service)
	@$(call install_link, connman, ../connman-ignore.service, \
		/lib/systemd/system/connman.service.wants/connman-ignore.service)
	@$(call install_alternative, connman, 0, 0, 0755, \
		/lib/systemd/connman-ignore)
endif

#	# ship settings which enable wired interfaces per default
	@$(call install_alternative, connman, 0, 0, 0600, \
		/var/lib/connman/settings)

#	# dbus config
	@$(call install_alternative, connman, 0, 0, 0644, /etc/dbus-1/system.d/connman.conf)

#	# command line client
ifdef PTXCONF_CONNMAN_CLIENT
	@$(call install_copy, connman, 0, 0, 0755, -, /usr/sbin/cm)
endif

#	# python tests
ifdef PTXCONF_CONNMAN_TESTS
	@$(foreach test, $(CONNMAN_TESTS), \
		$(call install_copy, connman, 0, 0, 0755, -, \
			/usr/sbin/cm-$(test));)
endif

	@$(call install_finish, connman)

	@$(call touch)

# vim: syntax=make

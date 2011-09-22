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
CONNMAN_VERSION	:= 0.76
CONNMAN_MD5	:= 59b4cfd9fa4f736f7a2d88ee0c758fe9
CONNMAN		:= connman-$(CONNMAN_VERSION)
CONNMAN_SUFFIX	:= tar.gz
CONNMAN_URL	:= $(PTXCONF_SETUP_KERNELMIRROR)/network/connman/$(CONNMAN).$(CONNMAN_SUFFIX)
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
	--$(call ptx/endis, PTXCONF_CONNMAN_ETHERNET)-ethernet \
	--$(call ptx/endis, PTXCONF_CONNMAN_WIFI)-wifi \
	--$(call ptx/endis, PTXCONF_CONNMAN_BLUETOOTH)-bluetooth \
	--disable-hh2serial-gps \
	--disable-ofono \
	--disable-openconnect \
	--disable-portal \
	--disable-openvpn \
	--disable-vpnc \
	--$(call ptx/endis, PTXCONF_CONNMAN_LOOPBACK)-loopback \
	--disable-pacrunner \
	--disable-google \
	--disable-meego \
	--$(call ptx/endis, PTXCONF_CONNMAN_WIMAX)-iwmx \
	--disable-iospm \
	--disable-ntpd \
	--disable-nmcompat \
	--disable-tist \
	--$(call ptx/endis, PTXCONF_CONNMAN_POLKIT)-polkit \
	--$(call ptx/endis, PTXCONF_CONNMAN_CLIENT)-client \
	--disable-tools \
	--disable-test \
	--$(call ptx/endis, PTXCONF_CONNMAN_FAKE)-fake \
	--disable-capng \
	--enable-datafiles

ifdef PTXCONF_CONNMAN_SYSTEMD_UNIT
CONNMAN_CONF_OPT += --with-systemdunitdir=/lib/systemd/system
else
CONNMAN_CONF_OPT += --without-systemdunitdir
endif

CONNMAN_TESTS := \
	backtrace \
	connect-service \
	connect-vpn \
	disable-tethering \
	disconnect-vpn \
	enable-tethering \
	find-service \
	get-proxy-autoconfig \
	get-services \
	get-state \
	list-profiles \
	list-services \
	monitor-connman \
	monitor-manager \
	monitor-services \
	provision-service \
	set-address \
	set-domains \
	set-ipv4-method \
	set-ipv6-method \
	set-nameservers \
	set-proxy \
	show-introspection \
	simple-agent \
	test-compat \
	test-connman \
	test-counter \
	test-manager \
	test-profile \
	test-session

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

CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_LOOPBACK)	+= loopback
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_ETHERNET)	+= ethernet
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_WIFI)		+= wifi
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_WIMAX)	+= iwmx
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_BLUETOOTH)	+= bluetooth
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_POLKIT)	+= polkit
CONNMAN_PLUGINS-$(PTXCONF_CONNMAN_FAKE)		+= fake

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
	@$(call install_copy, connman, 0, 0, 0644, -, \
		/lib/systemd/system/connman.service)
	@$(call install_link, connman, ../connman.service, \
		/lib/systemd/system/multi-user.target.wants/connman.service)
endif

#	# dbus config
	@$(call install_alternative, connman, 0, 0, 0644, /etc/dbus-1/system.d/connman.conf)

#	#
#	# plugins
#	#
	@$(foreach plugin, $(CONNMAN_PLUGINS-y), \
		$(call install_copy, connman, 0, 0, 0644, -, \
			/usr/lib/connman/plugins/$(plugin).so);)

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

# -*-makefile-*-
#
# Copyright (C) 2009, 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2012 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETWORKMANAGER) += networkmanager

#
# Paths and names
#
NETWORKMANAGER_VERSION	:= 1.14.0
NETWORKMANAGER_MD5	:= bedae3bb29bc68825b6c616a68cc6ba9
NETWORKMANAGER		:= NetworkManager-$(NETWORKMANAGER_VERSION)
NETWORKMANAGER_SUFFIX	:= tar.xz
NETWORKMANAGER_URL	:= https://ftp.gnome.org/pub/GNOME/sources/NetworkManager/1.14/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_DIR	:= $(BUILDDIR)/$(NETWORKMANAGER)
NETWORKMANAGER_LICENSE	:= GPL-2.0-or-later AND LGPL-2.0-or-later
NETWORKMANAGER_LICENSE_FILES := file://COPYING;md5=cbbffd568227ada506640fe950a4823b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETWORKMANAGER_CONF_TOOL := autoconf
NETWORKMANAGER_CONF_OPT = \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-nls \
	--disable-rpath \
	--disable-config-plugin-ibft \
	--disable-ifcfg-rh \
	--enable-ifupdown \
	--disable-code-coverage \
	--$(call ptx/endis,PTXCONF_NETWORKMANAGER_WIRELESS)-wifi \
	--disable-introspection \
	--disable-qt \
	--disable-teamdctl \
	--disable-json-validation \
	--disable-polkit \
	--disable-polkit-agent \
	--disable-modify-system \
	--$(call ptx/endis,PTXCONF_NETWORKMANAGER_PPP)-ppp \
	--disable-bluez5-dun \
	--disable-ovs \
	--$(call ptx/endis,PTXCONF_NETWORKMANAGER_CONCHECK)-concheck \
	--enable-more-warnings \
	--disable-more-asserts \
	--disable-more-logging \
	--disable-lto \
	--enable-ld-gc=auto \
	--disable-undefined-sanitizer \
	--disable-vala \
	--disable-tests \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_WIRELESS)-wext \
	--without-iwd \
	--without-libnm-glib \
	--with-udev-dir=/usr/lib/udev \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--with-hostname-persist=default \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_SYSTEMD_UNIT)-systemd-journal \
	--with-config-logging-backend-default="" \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_SYSTEMD_UNIT)-systemd-logind \
	--without-consolekit \
	--without-session-tracking \
	--with-suspend-resume=$(call ptx/ifdef,PTXCONF_NETWORKMANAGER_SYSTEMD_UNIT,systemd,upower) \
	--without-selinux \
	--without-libaudit \
	--with-crypto=gnutls \
	--with-dbus-sys-dir=/usr/share/dbus-1/system.d \
	--with-pppd-plugin-dir=$(PPP_SHARED_INST_PATH) \
	--with-pppd=/usr/sbin/pppd \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_WWAN)-modem-manager-1 \
	--without-ofono \
	--without-dhcpcanon \
	--with-dhclient=/usr/sbin/dhclient \
	--without-dhcpcd \
	--with-config-dhcp-default=internal \
	--without-resolvconf \
	--without-netconfig \
	--with-config-dns-rc-manager-default=file \
	--with-iptables=/usr/sbin/iptables \
	--with-dnsmasq=/usr/sbin/dnsmasq \
	--with-dnssec-trigger=/bin/true \
	--with-system-ca-path=/etc/ssl/certs \
	--with-kernel-firmware-dir=/lib/firmware \
	--without-libpsl \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_NMCLI)-nmcli \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_NMTUI)-nmtui \
	--without-address-sanitizer \
	--without-valgrind

ifdef PTXCONF_NETWORKMANAGER_WWAN
NETWORKMANAGER_LDFLAGS	:= \
	-Wl,-rpath,/usr/lib/NetworkManager/$(NETWORKMANAGER_VERSION)
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.install:
	@$(call targetinfo)
	@$(call world/install, NETWORKMANAGER)

ifdef PTXCONF_NETWORKMANAGER_EXAMPLES
	@cd $(NETWORKMANAGER_DIR)/examples/C/glib/ \
		&& for FILE in `find -type f -executable -printf '%f\n'`; do \
		install -vD -m 755 "$${FILE}" "$(NETWORKMANAGER_PKGDIR)/usr/bin/nm-$${FILE}"; \
	done
	@cd $(NETWORKMANAGER_DIR)/examples/python/dbus \
		&& for FILE in `find -name "*.py" -printf '%f\n'`; do \
		install -vD -m 755 "$${FILE}" "$(NETWORKMANAGER_PKGDIR)/usr/bin/nm-$${FILE}"; \
	done
	@cd $(NETWORKMANAGER_DIR)/examples/shell/ \
		&& for FILE in `find -name "*.sh" -printf '%f\n'`; do \
		install -vD -m 755 "$${FILE}" "$(NETWORKMANAGER_PKGDIR)/usr/bin/nm-$${FILE}"; \
	done
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager.targetinstall:
	@$(call targetinfo)

	@$(call install_init, networkmanager)
	@$(call install_fixup, networkmanager,PRIORITY,optional)
	@$(call install_fixup, networkmanager,SECTION,base)
	@$(call install_fixup, networkmanager,AUTHOR,"Jan Luebbe <j.luebbe@pengutronix.de>")
	@$(call install_fixup, networkmanager,DESCRIPTION, "networkmanager")

	@$(call install_alternative, networkmanager, 0, 0, 0644, /etc/NetworkManager/NetworkManager.conf)
	@$(call install_copy, networkmanager, 0, 0, 0755, /etc/NetworkManager/dispatcher.d/)
	@$(call install_copy, networkmanager, 0, 0, 0755, /etc/NetworkManager/system-connections/)

#	# unmanage NFS root devices
	@$(call install_alternative, networkmanager, 0, 0, 0755, /usr/lib/init/nm-unmanage.sh)

	@$(call install_copy, networkmanager, 0, 0, 0755, /var/lib/NetworkManager)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NETWORKMANAGER_STARTSCRIPT
	@$(call install_alternative, networkmanager, 0, 0, 0755, /etc/init.d/NetworkManager)

ifneq ($(call remove_quotes, $(PTXCONF_NETWORKMANAGER_BBINIT_LINK)),)
	@$(call install_link, networkmanager, \
		../init.d/NetworkManager, \
		/etc/rc.d/$(PTXCONF_NETWORKMANAGER_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_NETWORKMANAGER_SYSTEMD_UNIT
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/NetworkManager.service)
	@$(call install_link, networkmanager, ../NetworkManager.service, \
		/usr/lib/systemd/system/multi-user.target.wants/NetworkManager.service)
	@$(call install_link, networkmanager, NetworkManager.service, \
		/usr/lib/systemd/system/dbus-org.freedesktop.NetworkManager.service)
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/NetworkManager-unmanage.service)
	@$(call install_link, networkmanager, ../NetworkManager-unmanage.service, \
		/usr/lib/systemd/system/NetworkManager.service.wants/NetworkManager-unmanage.service)
ifdef PTXCONF_NETWORKMANAGER_NM_ONLINE
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/NetworkManager-wait-online.service)
endif
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/NetworkManager-dispatcher.service)
	@$(call install_link, networkmanager, NetworkManager-dispatcher.service, \
		/usr/lib/systemd/system/dbus-org.freedesktop.nm-dispatcher.service)
endif

	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/sbin/NetworkManager)
ifdef PTXCONF_NETWORKMANAGER_NM_ONLINE
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nm-online)
endif
ifdef PTXCONF_NETWORKMANAGER_NMCLI
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nmcli)
endif
ifdef PTXCONF_NETWORKMANAGER_NMTUI
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nmtui)
endif

	@$(call install_tree, networkmanager, 0, 0, -, /usr/libexec/)

	@$(call install_lib, networkmanager, 0, 0, 0644, \
		NetworkManager/$(NETWORKMANAGER_VERSION)/libnm-settings-plugin-ifupdown)
ifdef PTXCONF_NETWORKMANAGER_WIRELESS
	@$(call install_lib, networkmanager, 0, 0, 0644, \
		NetworkManager/$(NETWORKMANAGER_VERSION)/libnm-device-plugin-wifi)
endif
ifdef PTXCONF_NETWORKMANAGER_WWAN
	@$(call install_lib, networkmanager, 0, 0, 0644, \
		NetworkManager/$(NETWORKMANAGER_VERSION)/libnm-device-plugin-wwan)
	@$(call install_lib, networkmanager, 0, 0, 0644, \
		NetworkManager/$(NETWORKMANAGER_VERSION)/libnm-wwan)
endif
ifdef PTXCONF_NETWORKMANAGER_PPP
	@$(call install_lib, networkmanager, 0, 0, 0644, \
		NetworkManager/$(NETWORKMANAGER_VERSION)/libnm-ppp-plugin)
	@$(call install_copy, networkmanager, 0, 0, 0644, -, $(PPP_SHARED_INST_PATH)/nm-pppd-plugin.so)
endif
	@$(call install_lib, networkmanager, 0, 0, 0644, libnm)

	@$(call install_tree, networkmanager, 0, 0, -, /usr/share/dbus-1/system.d/)
	@$(call install_tree, networkmanager, 0, 0, -, /usr/share/dbus-1/system-services/)

ifdef PTXCONF_NETWORKMANAGER_EXAMPLES
	@$(call install_glob, networkmanager, 0, 0, -, /usr/bin, */nm-*-*)
endif

	@$(call install_finish, networkmanager)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
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
NETWORKMANAGER_VERSION	:= 1.0.10
NETWORKMANAGER_MD5	:= a8f54460a4708efd840358f32d0968fd
NETWORKMANAGER		:= NetworkManager-$(NETWORKMANAGER_VERSION)
NETWORKMANAGER_SUFFIX	:= tar.xz
NETWORKMANAGER_URL	:= http://ftp.gnome.org/pub/GNOME/sources/NetworkManager/1.0/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER).$(NETWORKMANAGER_SUFFIX)
NETWORKMANAGER_DIR	:= $(BUILDDIR)/$(NETWORKMANAGER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETWORKMANAGER_CONF_TOOL := autoconf
NETWORKMANAGER_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-nls \
	--disable-rpath \
	--disable-ifcfg-rh \
	--disable-ifcfg-suse \
	--enable-ifupdown \
	--disable-ifnet \
	--disable-code-coverage \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_WIRELESS)-wifi \
	--disable-introspection \
	--disable-qt \
	--disable-wimax \
	--disable-polkit \
	--disable-modify-system \
	--$(call ptx/endis,PTXCONF_NETWORKMANAGER_PPP)-ppp \
	--disable-bluez5-dun \
	--disable-concheck \
	--enable-more-warnings \
	--disable-more-asserts \
	--disable-more-logging \
	--disable-vala \
	--disable-tests \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_WIRELESS)-wext \
	--with-systemdsystemunitdir=/lib/systemd/system \
	--with-session-tracking=no \
	--with-suspend-resume=systemd \
	--with-crypto=gnutls \
	--with-dbus-sys-dir=/usr/share/dbus-1/system.d \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_WWAN)-modem-manager-1 \
	--with-dhclient=/sbin/dhclient \
	--without-dhcpcd \
	--without-resolvconf \
	--without-netconfig \
	--with-iptables=/usr/sbin/iptables \
	--with-dnsmasq=/usr/sbin/dnsmasq \
	--without-system-ca-path \
	--with-kernel-firmware-dir=/lib/firmware \
	--without-libsoup \
	--$(call ptx/wwo,PTXCONF_NETWORKMANAGER_NMTUI)-nmtui \
	--without-valgrind \
	--without-tests

ifdef PTXCONF_NETWORKMANAGER_PPP
NETWORKMANAGER_CONF_OPT += \
	--with-pppd-plugin-dir=$(PPP_SHARED_INST_PATH)
endif

ifdef PTXCONF_NETWORKMANAGER_WWAN
NETWORKMANAGER_LDFLAGS	:= \
	-Wl,-rpath,/usr/lib/NetworkManager
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
	@$(call install_alternative, networkmanager, 0, 0, 0755, /lib/init/nm-unmanage.sh)

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
		/lib/systemd/system/NetworkManager.service)
	@$(call install_link, networkmanager, ../NetworkManager.service, \
		/lib/systemd/system/multi-user.target.wants/NetworkManager.service)
	@$(call install_link, networkmanager, NetworkManager.service, \
		/lib/systemd/system/dbus-org.freedesktop.NetworkManager.service)
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/lib/systemd/system/NetworkManager-unmanage.service)
	@$(call install_link, networkmanager, ../NetworkManager-unmanage.service, \
		/lib/systemd/system/NetworkManager.service.wants/NetworkManager-unmanage.service)
ifdef PTXCONF_NETWORKMANAGER_NM_ONLINE
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/lib/systemd/system/NetworkManager-wait-online.service)
endif
	@$(call install_alternative, networkmanager, 0, 0, 0644, \
		/lib/systemd/system/NetworkManager-dispatcher.service)
	@$(call install_link, networkmanager, NetworkManager-dispatcher.service, \
		/lib/systemd/system/dbus-org.freedesktop.nm-dispatcher.service)
endif

	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/sbin/NetworkManager)
ifdef PTXCONF_NETWORKMANAGER_NM_ONLINE
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nm-online)
endif
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nmcli)
ifdef PTXCONF_NETWORKMANAGER_NMTUI
	@$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/nmtui)
endif

	@$(call install_tree, networkmanager, 0, 0, -, /usr/libexec/)

	@$(call install_lib, networkmanager, 0, 0, 0644, NetworkManager/libnm-settings-plugin-ifupdown)
ifdef PTXCONF_NETWORKMANAGER_WIRELESS
	@$(call install_lib, networkmanager, 0, 0, 0644, NetworkManager/libnm-device-plugin-wifi)
endif
ifdef PTXCONF_NETWORKMANAGER_WWAN
	@$(call install_lib, networkmanager, 0, 0, 0644, NetworkManager/libnm-device-plugin-wwan)
	@$(call install_lib, networkmanager, 0, 0, 0644, NetworkManager/libnm-wwan)
endif
ifdef PTXCONF_NETWORKMANAGER_PPP
	@$(call install_copy, networkmanager, 0, 0, 0644, -, $(PPP_SHARED_INST_PATH)/nm-pppd-plugin.so)
endif
	@$(call install_lib, networkmanager, 0, 0, 0644, libnm)
	@$(call install_lib, networkmanager, 0, 0, 0644, libnm-util)
	@$(call install_lib, networkmanager, 0, 0, 0644, libnm-glib)
	@$(call install_lib, networkmanager, 0, 0, 0644, libnm-glib-vpn)

	@$(call install_tree, networkmanager, 0, 0, -, /usr/share/dbus-1/system.d/)
	@$(call install_tree, networkmanager, 0, 0, -, /usr/share/dbus-1/system-services/)

ifdef PTXCONF_NETWORKMANAGER_EXAMPLES
	@cd $(NETWORKMANAGER_PKGDIR)/usr/bin/ \
		&& for FILE in `find -name "nm-*-*" -printf '%f\n'`; do \
		$(call install_copy, networkmanager, 0, 0, 0755, -, /usr/bin/$${FILE}); \
	done
endif

	@$(call install_finish, networkmanager)

	@$(call touch)

# vim: syntax=make

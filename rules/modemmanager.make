# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MODEMMANAGER) += modemmanager

#
# Paths and names
#
MODEMMANAGER_VERSION	:= 1.8.2
MODEMMANAGER_MD5	:= a49c9f73e46c7b89e5efedda250d22c0
MODEMMANAGER		:= ModemManager-$(MODEMMANAGER_VERSION)
MODEMMANAGER_SUFFIX	:= tar.xz
MODEMMANAGER_URL	:= http://www.freedesktop.org/software/ModemManager/$(MODEMMANAGER).$(MODEMMANAGER_SUFFIX)
MODEMMANAGER_SOURCE	:= $(SRCDIR)/$(MODEMMANAGER).$(MODEMMANAGER_SUFFIX)
MODEMMANAGER_DIR	:= $(BUILDDIR)/$(MODEMMANAGER)
MODEMMANAGER_LICENSE	:= GPL-2.0-or-later AND GPL-3.0-or-later AND LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#MODEMMANAGER_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
MODEMMANAGER_CONF_TOOL	:= autoconf
MODEMMANAGER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-nls \
	--disable-rpath \
	--disable-introspection \
	--disable-vala \
	--disable-more-warnings \
	--with-gnu-ld \
	--with-dbus-sys-dir=/usr/share/dbus-1/system.d \
	--with-udev-base-dir=/usr/lib/udev \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--$(call ptx/wwo, PTXCONF_INITMETHOD_SYSTEMD)-systemd-suspend-resume \
	--$(call ptx/wwo, PTXCONF_INITMETHOD_SYSTEMD)-systemd-journal \
	--without-polkit \
	--with-mbim \
	--with-qmi

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/modemmanager.targetinstall:
	@$(call targetinfo)

	@$(call install_init, modemmanager)
	@$(call install_fixup, modemmanager,PRIORITY,optional)
	@$(call install_fixup, modemmanager,SECTION,base)
	@$(call install_fixup, modemmanager,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, modemmanager,DESCRIPTION,missing)

	@$(call install_copy, modemmanager, 0, 0, 0755, -, \
		/usr/sbin/ModemManager)
	@$(call install_copy, modemmanager, 0, 0, 0755, -, /usr/bin/mmcli)

	@$(call install_lib, modemmanager, 0, 0, 0644, libmm-glib)
	@$(call install_glob, modemmanager, 0, 0, -, /usr/lib/ModemManager/, *.so)

	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/share/dbus-1/system.d/org.freedesktop.ModemManager1.conf)
	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/share/dbus-1/system-services/org.freedesktop.ModemManager1.service)

	@$(call install_tree, modemmanager, 0, 0, -, /usr/lib/udev/rules.d/)

ifdef PTXCONF_MODEMMANAGER_SYSTEMD_UNIT
	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/ModemManager.service)
	@$(call install_link, modemmanager, ModemManager.service, \
		/usr/lib/systemd/system/dbus-org.freedesktop.ModemManager1.service)
	@$(call install_link, modemmanager, ../ModemManager.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ModemManager.service)
endif

	@$(call install_finish, modemmanager)

	@$(call touch)

# vim: syntax=make

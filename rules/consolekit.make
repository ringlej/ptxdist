# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CONSOLEKIT) += consolekit

#
# Paths and names
#
CONSOLEKIT_VERSION	:= 0.4.1
CONSOLEKIT		:= ConsoleKit-$(CONSOLEKIT_VERSION)
CONSOLEKIT_SUFFIX	:= tar.bz2
CONSOLEKIT_URL		:= http://www.freedesktop.org/software/ConsoleKit/dist/$(CONSOLEKIT).$(CONSOLEKIT_SUFFIX)
CONSOLEKIT_SOURCE	:= $(SRCDIR)/$(CONSOLEKIT).$(CONSOLEKIT_SUFFIX)
CONSOLEKIT_DIR		:= $(BUILDDIR)/$(CONSOLEKIT)
CONSOLEKIT_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CONSOLEKIT_SOURCE):
	@$(call targetinfo)
	@$(call get, CONSOLEKIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CONSOLEKIT_CONF_TOOL	:= autoconf
CONSOLEKIT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-pam-module \
	--disable-docbook-docs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/consolekit.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  consolekit)
	@$(call install_fixup, consolekit,PACKAGE,consolekit)
	@$(call install_fixup, consolekit,PRIORITY,optional)
	@$(call install_fixup, consolekit,VERSION,$(CONSOLEKIT_VERSION))
	@$(call install_fixup, consolekit,SECTION,base)
	@$(call install_fixup, consolekit,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, consolekit,DEPENDS,)
	@$(call install_fixup, consolekit,DESCRIPTION,missing)

	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/etc/ConsoleKit/seats.d/00-primary.seat)

# dbus
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/etc/dbus-1/system.d/ConsoleKit.conf)
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/usr/share/dbus-1/interfaces/org.freedesktop.ConsoleKit.Manager.xml)
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/usr/share/dbus-1/interfaces/org.freedesktop.ConsoleKit.Seat.xml)
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/usr/share/dbus-1/interfaces/org.freedesktop.ConsoleKit.Session.xml)
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/usr/share/dbus-1/system-services/org.freedesktop.ConsoleKit.service)
# polkit
	@$(call install_copy, consolekit, 0, 0, 0644, -, \
		/usr/share/polkit-1/actions/org.freedesktop.consolekit.policy)

	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/bin/ck-history)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/bin/ck-launch-session)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/bin/ck-list-sessions)

	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/lib/ConsoleKit/scripts/ck-system-restart)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/lib/ConsoleKit/scripts/ck-system-stop)

	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/lib/libck-connector.so.0.0.0)
	@$(call install_link, consolekit, /usr/lib/libck-connector.so.0.0.0, \
		libck-connector.so.0)
	@$(call install_link, consolekit, /usr/lib/libck-connector.so.0.0.0, \
		libck-connector.so)

	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/libexec/ck-collect-session-info)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/libexec/ck-get-x11-display-device)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/libexec/ck-get-x11-server-pid)

	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/sbin/ck-log-system-restart)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/sbin/ck-log-system-start)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/sbin/ck-log-system-stop)
	@$(call install_copy, consolekit, 0, 0, 0755, -, \
		/usr/sbin/console-kit-daemon)

	@$(call install_finish, consolekit)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DBUS_GLIB) += host-dbus-glib

#
# Paths and names
#
HOST_DBUS_GLIB_DIR	= $(HOST_BUILDDIR)/$(DBUS_GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DBUS_GLIB_PATH	:= PATH=$(HOST_PATH)
HOST_DBUS_GLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_DBUS_GLIB_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-bash-completion \
	--disable-doxygen-docs \
	--disable-gcov \
	--disable-gtk-doc \
	--disable-tests

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dbus-glib.install:
	@$(call targetinfo)
	@$(call install, HOST_DBUS_GLIB)
	install -D -m 644 "$(HOST_DBUS_GLIB_DIR)/tools/dbus-bus-introspect.xml" \
		"$(HOST_DBUS_GLIB_PKGDIR)/share/dbus-glib/dbus-bus-introspect.xml"
	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
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
PACKAGES-$(PTXCONF_DBUS_GLIB) += dbus-glib

#
# Paths and names
#
DBUS_GLIB_VERSION	:= 0.82
DBUS_GLIB		:= dbus-glib-$(DBUS_GLIB_VERSION)
DBUS_GLIB_SUFFIX	:= tar.gz
DBUS_GLIB_URL		:= http://dbus.freedesktop.org/releases/dbus-glib/$(DBUS_GLIB).$(DBUS_GLIB_SUFFIX)
DBUS_GLIB_SOURCE	:= $(SRCDIR)/$(DBUS_GLIB).$(DBUS_GLIB_SUFFIX)
DBUS_GLIB_DIR		:= $(BUILDDIR)/$(DBUS_GLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DBUS_GLIB_SOURCE):
	@$(call targetinfo)
	@$(call get, DBUS_GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DBUS_GLIB_PATH	:= PATH=$(CROSS_PATH)
DBUS_GLIB_ENV	:= $(CROSS_ENV)

#
# autoconf
#
# use = here, not :=
DBUS_GLIB_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-bash-completion \
	--disable-doxygen-docs \
	--disable-gcov \
	--disable-gtk-doc \
	--disable-tests \
	--with-dbus-binding-tool=$(PTXCONF_SYSROOT_HOST)/bin/dbus-binding-tool \
	--with-introspect-xml=$(HOST_DBUS_GLIB_DIR)/tools/dbus-bus-introspect.xml

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus-glib)
	@$(call install_fixup, dbus-glib,PACKAGE,dbus-glib)
	@$(call install_fixup, dbus-glib,PRIORITY,optional)
	@$(call install_fixup, dbus-glib,VERSION,$(DBUS_GLIB_VERSION))
	@$(call install_fixup, dbus-glib,SECTION,base)
	@$(call install_fixup, dbus-glib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dbus-glib,DEPENDS,)
	@$(call install_fixup, dbus-glib,DESCRIPTION,missing)

	@$(call install_copy, dbus-glib, 0, 0, 0644, -, \
		/usr/lib/libdbus-glib-1.so.2.1.0)
	@$(call install_link, dbus-glib, libdbus-glib-1.so.2.1.0, \
		/usr/lib/libdbus-glib-1.so.2)
	@$(call install_link, dbus-glib, libdbus-glib-1.so.2.1.0, \
		/usr/lib/libdbus-glib-1.so)

	@$(call install_finish, dbus-glib)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus-glib_clean:
	rm -rf $(STATEDIR)/dbus-glib.*
	rm -rf $(PKGDIR)/dbus-glib_*
	rm -rf $(DBUS_GLIB_DIR)

# vim: syntax=make

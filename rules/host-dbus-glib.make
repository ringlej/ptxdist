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
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dbus-glib.get: $(STATEDIR)/dbus-glib.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dbus-glib.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_DBUS_GLIB_DIR))
	@$(call extract, DBUS_GLIB, $(HOST_BUILDDIR))
	@$(call patchin, DBUS_GLIB, $(HOST_DBUS_GLIB_DIR))
	@$(call touch)

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
# Clean
# ----------------------------------------------------------------------------

host-dbus-glib_clean:
	rm -rf $(STATEDIR)/host-dbus-glib.*
	rm -rf $(HOST_DBUS_GLIB_DIR)

# vim: syntax=make

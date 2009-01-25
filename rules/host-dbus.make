# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DBUS) += host-dbus

#
# Paths and names
#
HOST_DBUS_DIR	= $(HOST_BUILDDIR)/$(DBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dbus.get: $(STATEDIR)/dbus.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dbus.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_DBUS_DIR))
	@$(call extract, DBUS, $(HOST_BUILDDIR))
	@$(call patchin, DBUS, $(HOST_DBUS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DBUS_PATH	:= PATH=$(HOST_PATH)
HOST_DBUS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_DBUS_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-abstract-sockets=yes \
	--with-xml=expat \
	--disable-selinux \
	--disable-libaudit   

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-dbus_clean:
	rm -rf $(STATEDIR)/host-dbus.*
	rm -rf $(HOST_DBUS_DIR)

# vim: syntax=make

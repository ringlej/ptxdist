# -*-makefile-*-
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

# vim: syntax=make

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

#
# autoconf
#
HOST_DBUS_CONF_TOOL	:= autoconf
HOST_DBUS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--disable-tests \
	--disable-embedded-tests \
	--disable-modular-tests \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-asserts \
	--disable-checks \
	--disable-xml-docs \
	--disable-doxygen-docs \
	--disable-compiler-coverage \
	--enable-abstract-sockets=yes \
	--disable-libaudit \
	--disable-dnotify \
	--disable-inotify \
	--disable-kqueue \
	--disable-console-owner-file \
	--disable-userdb-cache \
	--disable-selinux \
	--with-xml=expat \
	--disable-systemd \
	--without-valgrind \
	--disable-stats

# vim: syntax=make

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
	--enable-silent-rules \
	--disable-static \
	--disable-compiler-coverage \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-asserts \
	--disable-checks \
	--disable-xml-docs \
	--disable-doxygen-docs \
	--disable-ducktype-docs \
	--enable-abstract-sockets=yes \
	--disable-selinux \
	--disable-apparmor \
	--disable-libaudit \
	--disable-inotify \
	--disable-kqueue \
	--disable-console-owner-file \
	--disable-systemd \
	--disable-embedded-tests \
	--disable-modular-tests \
	--disable-tests \
	--disable-epoll \
	--disable-x11-autolaunch \
	--disable-stats \
	--disable-user-session \
	--without-x \
	--without-valgrind

# vim: syntax=make

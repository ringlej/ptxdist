# -*-makefile-*-
#
# Copyright (C) 2010 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UTIL_LINUX_NG) += host-util-linux-ng

#
# Paths and names
#
HOST_UTIL_LINUX_NG_DIR	= $(HOST_BUILDDIR)/$(UTIL_LINUX_NG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

HOST_UTIL_LINUX_NG_CONF_TOOL	:= autoconf
HOST_UTIL_LINUX_NG_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-nls \
	--disable-static-programs \
	--disable-all-programs \
	--enable-tls \
	--enable-libuuid \
	--enable-libblkid \
	--enable-libmount \
	--disable-bash-completion \
	--disable-pg-bell \
	--disable-use-tty-group \
	--disable-sulogin-emergency-mount \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid \
	--without-audit \
	--without-udev \
	--without-ncurses \
	--without-slang \
	--without-utempter \
	--without-user \
	--without-systemd \
	--without-smack \
	--without-python

# vim: syntax=make

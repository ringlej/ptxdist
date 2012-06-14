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

HOST_UTIL_LINUX_NG_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-nls \
	--disable-use-tty-group \
	--disable-makeinstall-chown \
	--disable-gtk-doc \
	--disable-mount \
	--disable-fsck \
	--disable-uuidd \
	--disable-nls \
	--disable-agetty \
	--disable-cramfs \
	--disable-switch_root \
	--disable-pivot_root \
	--disable-fallocate \
	--disable-unshare \
	--disable-init \
	--disable-kill \
	--disable-last \
	--disable-mesg \
	--disable-partx \
	--disable-raw \
	--disable-rename \
	--disable-reset \
	--disable-login-utils \
	--disable-schedutils \
	--disable-wall \
	--disable-write \
	--enable-libuuid \
	--enable-libblkid \
	--enable-libmount

# vim: syntax=make

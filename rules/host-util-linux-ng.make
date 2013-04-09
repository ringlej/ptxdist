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
	--disable-gtk-doc \
	--disable-nls \
	--disable-most-builds \
	--enable-libuuid \
	--enable-libblkid \
	--disable-libmount \
	--disable-deprecated-mount \
	--disable-mount \
	--disable-losetup \
	--disable-fsck \
	--disable-partx \
	--disable-uuidd \
	--disable-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--disable-arch \
	--disable-ddate \
	--disable-eject \
	--disable-agetty \
	--disable-cramfs \
	--disable-wdctl \
	--disable-switch_root \
	--disable-pivot_root \
	--disable-elvtune \
	--disable-kill \
	--disable-last \
	--disable-utmpdump \
	--disable-line \
	--disable-mesg \
	--disable-raw \
	--disable-rename \
	--disable-reset \
	--disable-vipw \
	--disable-newgrp \
	--disable-chfn-chsh \
	--disable-chsh-only-listed \
	--disable-login \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-sulogin \
	--disable-su \
	--disable-schedutils \
	--disable-wall \
	--disable-write \
	--disable-chkdupexe \
	--disable-socket-activation \
	--disable-pg-bell \
	--enable-require-password \
	--disable-use-tty-group \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid

# vim: syntax=make

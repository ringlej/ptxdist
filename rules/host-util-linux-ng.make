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
	--enable-tls \
	--disable-most-builds \
	--enable-libuuid \
	--enable-libblkid \
	--disable-libmount \
	--disable-deprecated-mount \
	--disable-mount \
	--disable-losetup \
	--disable-cytune \
	--disable-fsck \
	--disable-partx \
	--disable-uuidd \
	--disable-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--disable-nsenter \
	--disable-setpriv \
	--disable-eject \
	--disable-agetty \
	--disable-cramfs \
	--disable-bfs \
	--disable-fdformat \
	--disable-hwclock \
	--disable-wdctl \
	--disable-switch_root \
	--disable-pivot_root \
	--disable-tunelp \
	--disable-kill \
	--disable-deprecated-last \
	--disable-last \
	--disable-utmpdump \
	--disable-line \
	--disable-mesg \
	--disable-raw \
	--disable-rename \
	--disable-reset \
	--disable-vipw \
	--disable-newgrp \
	--disable-chfn-chsh-password \
	--disable-chfn-chsh \
	--disable-chsh-only-listed \
	--disable-login \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-nologin \
	--disable-sulogin \
	--disable-su \
	--disable-runuser \
	--disable-ul \
	--disable-more \
	--disable-setterm \
	--disable-pg \
	--disable-schedutils \
	--disable-wall \
	--disable-write \
	--disable-socket-activation \
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
	--without-python

# vim: syntax=make

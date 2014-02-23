# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEMD) += host-systemd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_SYSTEMD_CONF_TOOL	:= autoconf
HOST_SYSTEMD_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-silent-rules \
	--disable-static \
	--disable-nls \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--disable-address-sanitizer \
	--disable-undefined-sanitizer \
	--disable-python-devel \
	--disable-dbus \
	--disable-compat-libs \
	--disable-coverage \
	--disable-kmod \
	--disable-blkid \
	--disable-seccomp \
	--disable-ima \
	--disable-chkconfig \
	--disable-selinux \
	--disable-apparmor \
	--disable-xz \
	--disable-pam \
	--disable-acl \
	--disable-smack \
	--disable-gcrypt \
	--disable-audit \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-microhttpd \
	--disable-gnutls \
	--disable-binfmt \
	--disable-vconsole \
	--disable-readahead \
	--disable-bootchart \
	--disable-quotacheck \
	--disable-tmpfiles \
	--disable-randomseed \
	--disable-backlight \
	--disable-rfkill \
	--disable-logind \
	--disable-machined \
	--disable-hostnamed \
	--disable-timedated \
	--disable-timesyncd \
	--disable-localed \
	--disable-coredump \
	--disable-polkit \
	--disable-resolved \
	--disable-networkd \
	--disable-efi \
	--disable-multi-seat-x \
	--disable-kdbus \
	--disable-myhostname \
	--disable-gudev \
	--disable-manpages \
	--enable-split-usr \
	--disable-tests \
	--without-python \
	--with-ntp-servers= \
	--with-sysvinit-path="" \
	--with-sysvrcnd-path="" \
	--with-rootprefix= \
	--with-rootlibdir=/lib

# vim: syntax=make

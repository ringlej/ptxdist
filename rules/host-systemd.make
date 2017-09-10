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

HOST_SYSTEMD_CONF_ENV	:= \
	$(HOST_ENV) \
	AR=ar NM=nm RANLIB=ranlib \
	cc_cv_LDFLAGS__Wl___gc_sections=no \
	cc_cv_CFLAGS__Werror_shadow=no \
	ac_cv_path_INTLTOOL_MERGE=:

#
# autoconf
#
HOST_SYSTEMD_CONF_TOOL	:= autoconf
HOST_SYSTEMD_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-silent-rules \
	--disable-static \
	--disable-address-sanitizer \
	--disable-undefined-sanitizer \
	--disable-lto \
	--disable-dbus \
	--disable-glib \
	--disable-utmp \
	--disable-coverage \
	--disable-kmod \
	--disable-xkbcommon \
	--disable-blkid \
	--disable-seccomp \
	--disable-ima \
	--disable-selinux \
	--disable-apparmor \
	--disable-adm-group \
	--disable-wheel-group \
	--disable-xz \
	--disable-zlib \
	--disable-bzip2 \
	--disable-lz4 \
	--disable-pam \
	--disable-acl \
	--disable-smack \
	--disable-gcrypt \
	--disable-audit \
	--disable-elfutils \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-gnutls \
	--disable-microhttpd \
	--disable-libcurl \
	--disable-libidn \
	--disable-libidn2 \
	--disable-idn \
	--disable-nss-systemd \
	--disable-libiptc \
	--disable-binfmt \
	--disable-vconsole \
	--disable-quotacheck \
	--disable-tmpfiles \
	--disable-environment-d \
	--disable-sysusers \
	--disable-gshadow \
	--disable-firstboot \
	--disable-randomseed \
	--disable-backlight \
	--disable-rfkill \
	--disable-logind \
	--disable-machined \
	--disable-importd \
	--disable-hostnamed \
	--disable-timedated \
	--disable-timesyncd \
	--disable-localed \
	--disable-coredump \
	--disable-polkit \
	--disable-resolved \
	--disable-networkd \
	--disable-efi \
	--disable-gnuefi \
	--disable-tpm \
	--disable-myhostname \
	--enable-hwdb \
	--disable-manpages \
	--disable-hibernate \
	--disable-ldconfig \
	--enable-split-usr \
	--disable-tests \
	--disable-debug \
	--without-python \
	--with-ntp-servers= \
	--with-dns-servers= \
	--with-sysvinit-path="" \
	--with-sysvrcnd-path="" \
	--with-rootprefix=/usr \
	--with-rootlibdir=/lib

# vim: syntax=make

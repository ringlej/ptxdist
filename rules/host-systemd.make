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
	ac_cv_path_INTLTOOL_MERGE=:

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
	--disable-utmp \
	--disable-compat-libs \
	--disable-coverage \
	--disable-kmod \
	--disable-xkbcommon \
	--disable-blkid \
	--disable-seccomp \
	--disable-ima \
	--disable-chkconfig \
	--disable-selinux \
	--disable-apparmor \
	--disable-xz \
	--disable-zlib \
	--enable-bzip2 \
	--disable-lz4 \
	--disable-pam \
	--disable-acl \
	--disable-smack \
	--disable-gcrypt \
	--disable-audit \
	--disable-elfutils \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-microhttpd \
	--disable-gnutls \
	--disable-libcurl \
	--disable-libidn \
	--disable-libiptc \
	--disable-binfmt \
	--disable-vconsole \
	--disable-bootchart \
	--disable-quotacheck \
	--disable-tmpfiles \
	--disable-sysusers \
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
	--disable-terminal \
	--disable-kdbus \
	--disable-myhostname \
	--disable-gudev \
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
	--with-rootprefix= \
	--with-rootlibdir=/lib

$(STATEDIR)/host-systemd.prepare:
	@$(call targetinfo)
	@$(call world/prepare, HOST_SYSTEMD)
#	# needed for broken v220 tarball
	@$(call compile, HOST_SYSTEMD, clean-generic)
	@$(call touch)

# vim: syntax=make

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
	--enable-largefile \
	--enable-silent-rules \
	--disable-static \
	--disable-nls \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--disable-kmod \
	--disable-blkid \
	--disable-ima \
	--disable-chkconfig \
	--disable-selinux \
	--disable-xz \
	--disable-tcpwrap \
	--disable-pam \
	--disable-acl \
	--disable-xattr \
	--disable-gcrypt \
	--disable-audit \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-microhttpd \
	--disable-binfmt \
	--disable-vconsole \
	--disable-readahead \
	--disable-bootchart \
	--disable-quotacheck \
	--disable-randomseed \
	--disable-logind \
	--disable-hostnamed \
	--disable-timedated \
	--disable-localed \
	--disable-coredump \
	--disable-polkit \
	--disable-efi \
	--disable-myhostname \
	--disable-gudev \
	--disable-keymap \
	--disable-manpages \
	--enable-split-usr \
	--disable-tests \
	--with-sysvinit-path="" \
	--with-sysvrcnd-path="" \
	--without-python \
	--with-rootprefix= \
	--with-rootlibdir=/lib

# vim: syntax=make

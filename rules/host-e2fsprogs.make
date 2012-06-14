# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_E2FSPROGS_CONF_TOOL	:= autoconf
HOST_E2FSPROGS_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--disable-symlink-install \
	--disable-symlink-build \
	--disable-verbose-makecmds \
	--enable-compression \
	--enable-htree \
	--disable-elf-shlibs \
	--disable-bsd-shlibs \
	--disable-profile \
	--disable-checker \
	--disable-jbd-debug \
	--disable-blkid-debug \
	--disable-testio-debug \
	--enable-libuuid \
	--enable-libblkid \
	--disable-quota \
	--disable-debugfs \
	--disable-imager \
	--disable-resizer \
	--disable-defrag \
	--enable-fsck \
	--disable-e2initrd-helper \
	--disable-tls \
	--disable-uuidd \
	--disable-nls \
	--disable-rpath \
	--without-diet-libc

# vim: syntax=make


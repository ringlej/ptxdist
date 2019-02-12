# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XZ) += host-xz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XZ_CONF_TOOL	:= autoconf
HOST_XZ_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--libdir=/lib/xz \
	--disable-debug \
	--disable-external-sha256 \
	--enable-assembler \
	--disable-small \
	--enable-threads \
	--enable-xz \
	--disable-xzdec \
	--disable-lzmadec \
	--disable-lzmainfo \
	--disable-lzma-links \
	--disable-scripts \
	--disable-shared \
	--disable-doc \
	--enable-symbol-versions \
	--disable-sandbox \
	--enable-static \
	--disable-nls \
	--enable-rpath \
	--enable-unaligned-access=auto \
	--disable-werror

# vim: syntax=make

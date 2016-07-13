# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PIXMAN) += host-pixman

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PIXMAN_CONF_TOOL	:= autoconf
HOST_PIXMAN_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--disable-openmp \
	--disable-loongson-mmi \
	--enable-gcc-inline-asm \
	--disable-static-testprogs \
	--disable-timers \
	--disable-gtk \
	--disable-libpng

# vim: syntax=make

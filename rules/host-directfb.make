# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DIRECTFB) += host-directfb

#
# Paths and names
#
HOST_DIRECTFB_DIR	= $(HOST_BUILDDIR)/$(DIRECTFB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DIRECTFB_PATH	:= PATH=$(HOST_PATH)
HOST_DIRECTFB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_DIRECTFB_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-osx \
	--disable-x11 \
	--disable-network \
	--disable-multi \
	--disable-voodoo \
	--disable-unique \
	--disable-fbdev \
	--disable-sdl \
	--disable-vnc \
	--disable-sysfs \
	--disable-jpeg \
	--disable-zlib \
	--disable-gif \
	--disable-freetype \
	--disable-video4linux \
	--disable-video4linux2 \
	\
	--with-gfxdrivers=none \
	--with-inputdrivers=none \
	\
	--enable-png

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-directfb.compile:
	@$(call targetinfo)
	cd $(HOST_DIRECTFB_DIR)/tools && $(HOST_DIRECTFB_PATH) $(MAKE) $(PARALLELMFLAGS) directfb-csource
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-directfb.install:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

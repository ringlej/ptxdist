# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Pengutronix e.K., Hildesheim, Germany
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UMKIMAGE) += host-umkimage

#
# Paths and names
#
HOST_UMKIMAGE_VERSION	:= 1.1.6
HOST_UMKIMAGE		:= u-boot-mkimage-$(HOST_UMKIMAGE_VERSION)
HOST_UMKIMAGE_SUFFIX	:= tar.bz2
HOST_UMKIMAGE_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOST_UMKIMAGE).$(HOST_UMKIMAGE_SUFFIX)
HOST_UMKIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_UMKIMAGE).$(HOST_UMKIMAGE_SUFFIX)
HOST_UMKIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_UMKIMAGE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_UMKIMAGE_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_UMKIMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-umkimage.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_UMKIMAGE_DIR))
	@$(call extract, HOST_UMKIMAGE, $(HOST_BUILDDIR))
	@$(call patchin, HOST_UMKIMAGE, $(HOST_UMKIMAGE_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_UMKIMAGE_PATH	:= PATH=$(HOST_PATH)
HOST_UMKIMAGE_MAKE_ENV	:= $(HOST_ENV) CFLAGS="$(HOST_CPPFLAGS)"

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-umkimage.install:
	@$(call targetinfo)
	install $(HOST_UMKIMAGE_DIR)/mkimage $(PTXCONF_SYSROOT_HOST)/bin/mkimage
	@$(call touch)

# vim: syntax=make

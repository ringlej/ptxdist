# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 by Pengutronix e.K., Hildesheim, Germany
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

host-umkimage_get: $(STATEDIR)/host-umkimage.get

$(STATEDIR)/host-umkimage.get: $(host-umkimage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_UMKIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_UMKIMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-umkimage_extract: $(STATEDIR)/host-umkimage.extract

$(STATEDIR)/host-umkimage.extract: $(host-umkimage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UMKIMAGE_DIR))
	@$(call extract, HOST_UMKIMAGE, $(HOST_BUILDDIR))
	@$(call patchin, HOST_UMKIMAGE, $(HOST_UMKIMAGE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-umkimage_prepare: $(STATEDIR)/host-umkimage.prepare

HOST_UMKIMAGE_PATH	:= PATH=$(HOST_PATH)
HOST_UMKIMAGE_ENV 	:= $(HOST_ENV) CFLAGS="$(HOST_CPPFLAGS)"

$(STATEDIR)/host-umkimage.prepare: $(host-umkimage_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_UMKIMAGE_DIR) && $(HOST_UMKIMAGE_PATH) $(MAKE) clean
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-umkimage_compile: $(STATEDIR)/host-umkimage.compile

$(STATEDIR)/host-umkimage.compile: $(host-umkimage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_UMKIMAGE_DIR) && $(HOST_UMKIMAGE_PATH) $(HOST_UMKIMAGE_ENV) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-umkimage_install: $(STATEDIR)/host-umkimage.install

$(STATEDIR)/host-umkimage.install: $(host-umkimage_install_deps_default)
	@$(call targetinfo, $@)
	install $(HOST_UMKIMAGE_DIR)/mkimage $(PTXCONF_SYSROOT_HOST)/bin/mkimage
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-umkimage_clean:
	rm -rf $(STATEDIR)/host-umkimage.*
	rm -rf $(HOST_UMKIMAGE_DIR)

# vim: syntax=make

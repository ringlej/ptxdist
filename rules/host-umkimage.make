# -*-makefile-*-
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
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
HOST_UMKIMAGE_VERSION	= 1.1.2
HOST_UMKIMAGE		= u-boot-mkimage-$(HOST_UMKIMAGE_VERSION)
HOST_UMKIMAGE_SUFFIX	= tar.gz
HOST_UMKIMAGE_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOST_UMKIMAGE).$(HOST_UMKIMAGE_SUFFIX)
HOST_UMKIMAGE_SOURCE	= $(SRCDIR)/$(HOST_UMKIMAGE).$(HOST_UMKIMAGE_SUFFIX)
HOST_UMKIMAGE_DIR		= $(HOST_BUILDDIR)/$(HOST_UMKIMAGE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-umkimage_get: $(STATEDIR)/host-umkimage.get

host-umkimage_get_deps = $(HOST_UMKIMAGE_SOURCE)

$(STATEDIR)/host-umkimage.get: $(host-umkimage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_UMKIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_UMKIMAGE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-umkimage_extract: $(STATEDIR)/host-umkimage.extract

host-umkimage_extract_deps = $(STATEDIR)/host-umkimage.get

$(STATEDIR)/host-umkimage.extract: $(host-umkimage_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UMKIMAGE_DIR))
	@$(call extract, $(HOST_UMKIMAGE_SOURCE), $(HOST_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-umkimage_prepare: $(STATEDIR)/host-umkimage.prepare

#
# dependencies
#
host-umkimage_prepare_deps =  $(STATEDIR)/host-umkimage.extract
host-umkimage_prepare_deps += $(STATEDIR)/host-zlib.install

HOST_UMKIMAGE_MAKEVARS	= CC=$(HOSTCC)
HOST_UMKIMAGE_ENV		= CFLAGS=-I$(PTXCONF_PREFIX)/include

$(STATEDIR)/host-umkimage.prepare: $(host-umkimage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-umkimage_compile: $(STATEDIR)/host-umkimage.compile

host-umkimage_compile_deps = $(STATEDIR)/host-umkimage.prepare

$(STATEDIR)/host-umkimage.compile: $(host-umkimage_compile_deps_default)
	@$(call targetinfo, $@)
	$(HOST_UMKIMAGE_ENV) make -C $(HOST_UMKIMAGE_DIR) $(HOST_UMKIMAGE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-umkimage_install: $(STATEDIR)/host-umkimage.install

$(STATEDIR)/host-umkimage.install: $(STATEDIR)/host-umkimage.compile
	@$(call targetinfo, $@)
	# FIXME
	mkdir -p $(PTXCONF_PREFIX)/usr/bin
	install $(HOST_UMKIMAGE_DIR)/mkimage $(PTXCONF_PREFIX)/bin/u-boot-mkimage
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-umkimage_targetinstall: $(STATEDIR)/host-umkimage.targetinstall

host-umkimage_targetinstall_deps = $(STATEDIR)/host-umkimage.install

$(STATEDIR)/host-umkimage.targetinstall: $(host-umkimage_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-umkimage_clean:
	rm -rf $(STATEDIR)/host-umkimage.*
	rm -rf $(HOST_UMKIMAGE_DIR)

# vim: syntax=make

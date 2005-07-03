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
ifdef PTXCONF_HOSTTOOL_UMKIMAGE
PACKAGES += hosttool-umkimage
endif

#
# Paths and names
#
HOSTTOOL_UMKIMAGE_VERSION	= 1.1.2
HOSTTOOL_UMKIMAGE		= u-boot-mkimage-$(HOSTTOOL_UMKIMAGE_VERSION)
HOSTTOOL_UMKIMAGE_SUFFIX	= tar.gz
HOSTTOOL_UMKIMAGE_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOSTTOOL_UMKIMAGE).$(HOSTTOOL_UMKIMAGE_SUFFIX)
HOSTTOOL_UMKIMAGE_SOURCE	= $(SRCDIR)/$(HOSTTOOL_UMKIMAGE).$(HOSTTOOL_UMKIMAGE_SUFFIX)
HOSTTOOL_UMKIMAGE_DIR		= $(BUILDDIR)/$(HOSTTOOL_UMKIMAGE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-umkimage_get: $(STATEDIR)/hosttool-umkimage.get

hosttool-umkimage_get_deps = $(HOSTTOOL_UMKIMAGE_SOURCE)

$(STATEDIR)/hosttool-umkimage.get: $(hosttool-umkimage_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(HOSTTOOL_UMKIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_UMKIMAGE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-umkimage_extract: $(STATEDIR)/hosttool-umkimage.extract

hosttool-umkimage_extract_deps = $(STATEDIR)/hosttool-umkimage.get

$(STATEDIR)/hosttool-umkimage.extract: $(hosttool-umkimage_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_UMKIMAGE_DIR))
	@$(call extract, $(HOSTTOOL_UMKIMAGE_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-umkimage_prepare: $(STATEDIR)/hosttool-umkimage.prepare

#
# dependencies
#
hosttool-umkimage_prepare_deps =  $(STATEDIR)/hosttool-umkimage.extract
hosttool-umkimage_prepare_deps += $(STATEDIR)/hosttool-zlib.install

HOSTTOOL_UMKIMAGE_MAKEVARS	= CC=$(HOSTCC)
HOSTTOOL_UMKIMAGE_ENV		= CFLAGS=-I$(PTXCONF_PREFIX)/include

$(STATEDIR)/hosttool-umkimage.prepare: $(hosttool-umkimage_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-umkimage_compile: $(STATEDIR)/hosttool-umkimage.compile

hosttool-umkimage_compile_deps = $(STATEDIR)/hosttool-umkimage.prepare

$(STATEDIR)/hosttool-umkimage.compile: $(hosttool-umkimage_compile_deps)
	@$(call targetinfo, $@)
	$(HOSTTOOL_UMKIMAGE_ENV) make -C $(HOSTTOOL_UMKIMAGE_DIR) $(HOSTTOOL_UMKIMAGE_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-umkimage_install: $(STATEDIR)/hosttool-umkimage.install

$(STATEDIR)/hosttool-umkimage.install: $(STATEDIR)/hosttool-umkimage.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin
	install $(HOSTTOOL_UMKIMAGE_DIR)/mkimage $(PTXCONF_PREFIX)/bin/u-boot-mkimage
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-umkimage_targetinstall: $(STATEDIR)/hosttool-umkimage.targetinstall

hosttool-umkimage_targetinstall_deps = $(STATEDIR)/hosttool-umkimage.install

$(STATEDIR)/hosttool-umkimage.targetinstall: $(hosttool-umkimage_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-umkimage_clean:
	rm -rf $(STATEDIR)/hosttool-umkimage.*
	rm -rf $(HOSTTOOL_UMKIMAGE_DIR)

# vim: syntax=make

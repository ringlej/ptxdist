# -*-makefile-*-
# $Id: xchain-umkimage.make,v 1.4 2003/10/24 01:10:56 mkl Exp $
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
ifdef PTXCONF_XCHAIN_UMKIMAGE
PACKAGES += xchain-umkimage
endif

#
# Paths and names
#
XCHAIN_UMKIMAGE_VERSION	= 20030424
XCHAIN_UMKIMAGE		= u-boot-mkimage-$(XCHAIN_UMKIMAGE_VERSION)
XCHAIN_UMKIMAGE_SUFFIX	= tar.gz
XCHAIN_UMKIMAGE_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XCHAIN_UMKIMAGE).$(XCHAIN_UMKIMAGE_SUFFIX)
XCHAIN_UMKIMAGE_SOURCE	= $(SRCDIR)/$(XCHAIN_UMKIMAGE).$(XCHAIN_UMKIMAGE_SUFFIX)
XCHAIN_UMKIMAGE_DIR	= $(BUILDDIR)/$(XCHAIN_UMKIMAGE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-umkimage_get: $(STATEDIR)/xchain-umkimage.get

xchain-umkimage_get_deps = $(XCHAIN_UMKIMAGE_SOURCE)

$(STATEDIR)/xchain-umkimage.get: $(xchain-umkimage_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(XCHAIN_UMKIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN_UMKIMAGE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-umkimage_extract: $(STATEDIR)/xchain-umkimage.extract

xchain-umkimage_extract_deps = $(STATEDIR)/xchain-umkimage.get

$(STATEDIR)/xchain-umkimage.extract: $(xchain-umkimage_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_UMKIMAGE_DIR))
	@$(call extract, $(XCHAIN_UMKIMAGE_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-umkimage_prepare: $(STATEDIR)/xchain-umkimage.prepare

#
# dependencies
#
xchain-umkimage_prepare_deps = \
	$(STATEDIR)/xchain-umkimage.extract \
	$(STATEDIR)/xchain-zlib.install

XCHAIN_UMKIMAGE_MAKEVARS	= CC=$(HOSTCC)
XCHAIN_UMKIMAGE_ENV		= CFLAGS=-I$(PTXCONF_PREFIX)/include

$(STATEDIR)/xchain-umkimage.prepare: $(xchain-umkimage_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-umkimage_compile: $(STATEDIR)/xchain-umkimage.compile

xchain-umkimage_compile_deps = $(STATEDIR)/xchain-umkimage.prepare

$(STATEDIR)/xchain-umkimage.compile: $(xchain-umkimage_compile_deps)
	@$(call targetinfo, $@)
	$(XCHAIN_UMKIMAGE_ENV) make -C $(XCHAIN_UMKIMAGE_DIR) $(XCHAIN_UMKIMAGE_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-umkimage_install: $(STATEDIR)/xchain-umkimage.install

$(STATEDIR)/xchain-umkimage.install: $(STATEDIR)/xchain-umkimage.compile
	@$(call targetinfo, $@)
	install $(XCHAIN_UMKIMAGE_DIR)/mkimage $(PTXCONF_PREFIX)/bin/u-boot-mkimage
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-umkimage_targetinstall: $(STATEDIR)/xchain-umkimage.targetinstall

xchain-umkimage_targetinstall_deps = $(STATEDIR)/xchain-umkimage.compile

$(STATEDIR)/xchain-umkimage.targetinstall: $(xchain-umkimage_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-umkimage_clean:
	rm -rf $(STATEDIR)/xchain-umkimage.*
	rm -rf $(XCHAIN_UMKIMAGE_DIR)

# vim: syntax=make

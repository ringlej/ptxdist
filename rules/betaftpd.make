# -*-makefile-*-
# $Id: betaftpd.make,v 1.1 2003/11/05 00:56:58 mkl Exp $
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_BETAFTPD
PACKAGES += betaftpd
endif

#
# Paths and names
#
BETAFTPD_VERSION	= 0.0.8pre17
BETAFTPD		= betaftpd-$(BETAFTPD_VERSION)
BETAFTPD_SUFFIX		= tar.gz
BETAFTPD_URL		= http://betaftpd.sourceforge.net/download/$(BETAFTPD).$(BETAFTPD_SUFFIX)
BETAFTPD_SOURCE		= $(SRCDIR)/$(BETAFTPD).$(BETAFTPD_SUFFIX)
BETAFTPD_DIR		= $(BUILDDIR)/$(BETAFTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

betaftpd_get: $(STATEDIR)/betaftpd.get

betaftpd_get_deps = $(BETAFTPD_SOURCE)

$(STATEDIR)/betaftpd.get: $(betaftpd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(BETAFTPD))
	touch $@

$(BETAFTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BETAFTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

betaftpd_extract: $(STATEDIR)/betaftpd.extract

betaftpd_extract_deps = $(STATEDIR)/betaftpd.get

$(STATEDIR)/betaftpd.extract: $(betaftpd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BETAFTPD_DIR))
	@$(call extract, $(BETAFTPD_SOURCE))
	@$(call patchin, $(BETAFTPD))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

betaftpd_prepare: $(STATEDIR)/betaftpd.prepare

#
# dependencies
#
betaftpd_prepare_deps =  \
	$(STATEDIR)/betaftpd.extract \
	$(STATEDIR)/rn.install	\
	$(STATEDIR)/virtual-xchain.install

BETAFTPD_PATH	=  PATH=$(CROSS_PATH)
BETAFTPD_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
BETAFTPD_AUTOCONF = \
	--prefix=$(CROSS_LIB_DIR) \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/betaftpd.prepare: $(betaftpd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BETAFTPD_DIR)/config.cache)
	cd $(BETAFTPD_DIR) && \
		$(BETAFTPD_PATH) $(BETAFTPD_ENV) \
		./configure $(BETAFTPD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

betaftpd_compile: $(STATEDIR)/betaftpd.compile

betaftpd_compile_deps = $(STATEDIR)/betaftpd.prepare

$(STATEDIR)/betaftpd.compile: $(betaftpd_compile_deps)
	@$(call targetinfo, $@)
	$(BETAFTPD_PATH) make -C $(BETAFTPD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

betaftpd_install: $(STATEDIR)/betaftpd.install

$(STATEDIR)/betaftpd.install: $(STATEDIR)/betaftpd.compile
	@$(call targetinfo, $@)
	$(BETAFTPD_PATH) make -C $(BETAFTPD_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

betaftpd_targetinstall: $(STATEDIR)/betaftpd.targetinstall

betaftpd_targetinstall_deps = $(STATEDIR)/betaftpd.install

$(STATEDIR)/betaftpd.targetinstall: $(betaftpd_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

betaftpd_clean:
	rm -rf $(STATEDIR)/betaftpd.*
	rm -rf $(BETAFTPD_DIR)

# vim: syntax=make

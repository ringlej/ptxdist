# -*-makefile-*-
# $Id: template 1469 2004-07-01 16:08:08Z rsc $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_EFAX
PACKAGES += efax
endif

#
# Paths and names
#
EFAX_VERSION		= 0.9
EFAX			= efax-$(EFAX_VERSION)
EFAX_SUFFIX		= tar.gz
EFAX_URL		= ftp://ftp.metalab.unc.edu/pub/Linux/apps/serialcomm/fax/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE		= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR		= $(BUILDDIR)/$(EFAX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

efax_get: $(STATEDIR)/efax.get

efax_get_deps = $(EFAX_SOURCE)

$(STATEDIR)/efax.get: $(efax_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(EFAX))
	touch $@

$(EFAX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(EFAX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

efax_extract: $(STATEDIR)/efax.extract

efax_extract_deps = $(STATEDIR)/efax.get

$(STATEDIR)/efax.extract: $(efax_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR))
	@$(call extract, $(EFAX_SOURCE))
	@$(call patchin, $(EFAX))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

efax_prepare: $(STATEDIR)/efax.prepare

#
# dependencies
#
efax_prepare_deps = \
	$(STATEDIR)/efax.extract \
	$(STATEDIR)/virtual-xchain.install

EFAX_PATH	=  PATH=$(CROSS_PATH)
EFAX_ENV 	=  $(CROSS_ENV)
#EFAX_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#EFAX_ENV	+=

#
# autoconf
#
EFAX_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/efax.prepare: $(efax_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR)/config.cache)
	cd $(EFAX_DIR) && \
		$(EFAX_PATH) $(EFAX_ENV) \
		./configure $(EFAX_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

efax_compile: $(STATEDIR)/efax.compile

efax_compile_deps = $(STATEDIR)/efax.prepare

$(STATEDIR)/efax.compile: $(efax_compile_deps)
	@$(call targetinfo, $@)
	cd $(EFAX_DIR) && $(EFAX_ENV) $(EFAX_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

efax_install: $(STATEDIR)/efax.install

$(STATEDIR)/efax.install: $(STATEDIR)/efax.compile
	@$(call targetinfo, $@)
	cd $(EFAX_DIR) && $(EFAX_ENV) $(EFAX_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

efax_targetinstall: $(STATEDIR)/efax.targetinstall

efax_targetinstall_deps = $(STATEDIR)/efax.compile

$(STATEDIR)/efax.targetinstall: $(efax_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

efax_clean:
	rm -rf $(STATEDIR)/efax.*
	rm -rf $(EFAX_DIR)

# vim: syntax=make

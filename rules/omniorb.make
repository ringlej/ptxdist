# -*-makefile-*-
# $Id: template 2078 2004-12-01 15:28:17Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_OMNIORB
PACKAGES += omniorb
endif

#
# Paths and names
#
OMNIORB_VERSION		= 4.0.5
OMNIORB			= omniORB-$(OMNIORB_VERSION)
OMNIORB_SUFFIX		= tar.gz
OMNIORB_URL		= $(PTXCONF_SFMIRROR)/omniorb/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_SOURCE		= $(SRCDIR)/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_DIR		= $(BUILDDIR)/$(OMNIORB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

omniorb_get: $(STATEDIR)/omniorb.get

omniorb_get_deps = $(OMNIORB_SOURCE)

$(STATEDIR)/omniorb.get: $(omniorb_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(OMNIORB))
	touch $@

$(OMNIORB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OMNIORB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

omniorb_extract: $(STATEDIR)/omniorb.extract

omniorb_extract_deps = $(STATEDIR)/omniorb.get

$(STATEDIR)/omniorb.extract: $(omniorb_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OMNIORB_DIR))
	@$(call extract, $(OMNIORB_SOURCE))
	@$(call patchin, $(OMNIORB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

omniorb_prepare: $(STATEDIR)/omniorb.prepare

#
# dependencies
#
omniorb_prepare_deps = \
	$(STATEDIR)/omniorb.extract \
	$(STATEDIR)/virtual-xchain.install

OMNIORB_PATH	=  PATH=$(CROSS_PATH)
OMNIORB_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OMNIORB_AUTOCONF =  $(CROSS_AUTOCONF)
OMNIORB_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
ifdef PTXCONF_OMNIORB_SSL
OMNIORB_AUTOCONF += --with-ssl
endif

$(STATEDIR)/omniorb.prepare: $(omniorb_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OMNIORB_DIR)/config.cache)
	cd $(OMNIORB_DIR) && \
		$(OMNIORB_PATH) $(OMNIORB_ENV) \
		./configure $(OMNIORB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

omniorb_compile: $(STATEDIR)/omniorb.compile

omniorb_compile_deps = $(STATEDIR)/omniorb.prepare

$(STATEDIR)/omniorb.compile: $(omniorb_compile_deps)
	@$(call targetinfo, $@)
	cd $(OMNIORB_DIR) && $(OMNIORB_ENV) $(OMNIORB_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

omniorb_install: $(STATEDIR)/omniorb.install

$(STATEDIR)/omniorb.install: $(STATEDIR)/omniorb.compile
	@$(call targetinfo, $@)
	cd $(OMNIORB_DIR) && $(OMNIORB_ENV) $(OMNIORB_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

omniorb_targetinstall: $(STATEDIR)/omniorb.targetinstall

omniorb_targetinstall_deps = $(STATEDIR)/omniorb.compile

$(STATEDIR)/omniorb.targetinstall: $(omniorb_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

omniorb_clean:
	rm -rf $(STATEDIR)/omniorb.*
	rm -rf $(OMNIORB_DIR)

# vim: syntax=make

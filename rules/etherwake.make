# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_ETHERWAKE
PACKAGES += etherwake
endif

#
# Paths and names
#
ETHERWAKE_VERSION	= 1.08
ETHERWAKE		= etherwake-$(ETHERWAKE_VERSION).orig
ETHERWAKE_SUFFIX	= tar.gz
ETHERWAKE_URL		= $(PTXCONF_DEBPOOLM)/pool/main/e/etherwake/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_SOURCE	= $(SRCDIR)/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_DIR		= $(BUILDDIR)/$(ETHERWAKE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

etherwake_get: $(STATEDIR)/etherwake.get

etherwake_get_deps = $(ETHERWAKE_SOURCE)

$(STATEDIR)/etherwake.get: $(etherwake_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(ETHERWAKE))
	touch $@

$(ETHERWAKE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ETHERWAKE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

etherwake_extract: $(STATEDIR)/etherwake.extract

etherwake_extract_deps = $(STATEDIR)/etherwake.get

$(STATEDIR)/etherwake.extract: $(etherwake_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR))
	@$(call extract, $(ETHERWAKE_SOURCE))
	@$(call patchin, $(ETHERWAKE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

etherwake_prepare: $(STATEDIR)/etherwake.prepare

#
# dependencies
#
etherwake_prepare_deps = \
	$(STATEDIR)/etherwake.extract \
	$(STATEDIR)/virtual-xchain.install

ETHERWAKE_PATH	=  PATH=$(CROSS_PATH)
ETHERWAKE_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/etherwake.prepare: $(etherwake_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR)/config.cache)
	cd $(ETHERWAKE_DIR) && \
		perl -i -p -e 's/CC.*=.*//' $(ETHERWAKE_DIR)/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

etherwake_compile: $(STATEDIR)/etherwake.compile

etherwake_compile_deps = $(STATEDIR)/etherwake.prepare

$(STATEDIR)/etherwake.compile: $(etherwake_compile_deps)
	@$(call targetinfo, $@)
	cd $(ETHERWAKE_DIR) && $(ETHERWAKE_ENV) $(ETHERWAKE_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

etherwake_install: $(STATEDIR)/etherwake.install

$(STATEDIR)/etherwake.install: $(STATEDIR)/etherwake.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

etherwake_targetinstall: $(STATEDIR)/etherwake.targetinstall

etherwake_targetinstall_deps = $(STATEDIR)/etherwake.compile

$(STATEDIR)/etherwake.targetinstall: $(etherwake_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/sbin
	install  $(ETHERWAKE_DIR)/etherwake $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/etherwake
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

etherwake_clean:
	rm -rf $(STATEDIR)/etherwake.*
	rm -rf $(ETHERWAKE_DIR)

# vim: syntax=make

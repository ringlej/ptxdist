# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_BETAFTPD) += betaftpd

#
# Paths and names
#
BETAFTPD_VERSION	= 0.0.8pre17
BETAFTPD		= betaftpd-$(BETAFTPD_VERSION)
BETAFTPD_SUFFIX		= tar.gz
BETAFTPD_URL		= $(PTXCONF_SETUP_SFMIRROR)/betaftpd/$(BETAFTPD).$(BETAFTPD_SUFFIX)
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
	@$(call touch, $@)

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
	@$(call touch, $@)

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
BETAFTPD_AUTOCONF =  $(CROSS_AUTOCONF)
BETAFTPD_AUTOCONF += --prefix=$(CROSS_LIB_DIR) \

$(STATEDIR)/betaftpd.prepare: $(betaftpd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BETAFTPD_DIR)/config.cache)
	cd $(BETAFTPD_DIR) && \
		$(BETAFTPD_PATH) $(BETAFTPD_ENV) \
		./configure $(BETAFTPD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

betaftpd_compile: $(STATEDIR)/betaftpd.compile

betaftpd_compile_deps = $(STATEDIR)/betaftpd.prepare

$(STATEDIR)/betaftpd.compile: $(betaftpd_compile_deps)
	@$(call targetinfo, $@)
	$(BETAFTPD_PATH) make -C $(BETAFTPD_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

betaftpd_install: $(STATEDIR)/betaftpd.install

$(STATEDIR)/betaftpd.install: $(STATEDIR)/betaftpd.compile
	@$(call targetinfo, $@)
	# RSC: FIXME: is it correct that we only install and do not targetinstall? 
	@$(call install, BETAFTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

betaftpd_targetinstall: $(STATEDIR)/betaftpd.targetinstall

betaftpd_targetinstall_deps = $(STATEDIR)/betaftpd.install

$(STATEDIR)/betaftpd.targetinstall: $(betaftpd_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

betaftpd_clean:
	rm -rf $(STATEDIR)/betaftpd.*
	rm -rf $(BETAFTPD_DIR)

# vim: syntax=make

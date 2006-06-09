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

# FIXME: ipkgize

#
# We provide this package
#
PACKAGES-$(PTXCONF_OMNIORB) += omniorb

#
# Paths and names
#
OMNIORB_VERSION		= 4.0.5
OMNIORB			= omniORB-$(OMNIORB_VERSION)
OMNIORB_SUFFIX		= tar.gz
OMNIORB_URL		= $(PTXCONF_SETUP_SFMIRROR)/omniorb/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_SOURCE		= $(SRCDIR)/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_DIR		= $(BUILDDIR)/$(OMNIORB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

omniorb_get: $(STATEDIR)/omniorb.get

$(STATEDIR)/omniorb.get: $(omniorb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OMNIORB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OMNIORB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

omniorb_extract: $(STATEDIR)/omniorb.extract

$(STATEDIR)/omniorb.extract: $(omniorb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OMNIORB_DIR))
	@$(call extract, OMNIORB)
	@$(call patchin, OMNIORB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

omniorb_prepare: $(STATEDIR)/omniorb.prepare

OMNIORB_PATH	=  PATH=$(CROSS_PATH)
OMNIORB_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OMNIORB_AUTOCONF =  $(CROSS_AUTOCONF_USR)
ifdef PTXCONF_OMNIORB_SSL
OMNIORB_AUTOCONF += --with-ssl
endif

$(STATEDIR)/omniorb.prepare: $(omniorb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OMNIORB_DIR)/config.cache)
	cd $(OMNIORB_DIR) && \
		$(OMNIORB_PATH) $(OMNIORB_ENV) \
		./configure $(OMNIORB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

omniorb_compile: $(STATEDIR)/omniorb.compile

$(STATEDIR)/omniorb.compile: $(omniorb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OMNIORB_DIR) && $(OMNIORB_ENV) $(OMNIORB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

omniorb_install: $(STATEDIR)/omniorb.install

$(STATEDIR)/omniorb.install: $(omniorb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, OMNIORB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

omniorb_targetinstall: $(STATEDIR)/omniorb.targetinstall

$(STATEDIR)/omniorb.targetinstall: $(omniorb_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

omniorb_clean:
	rm -rf $(STATEDIR)/omniorb.*
	rm -rf $(OMNIORB_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: flex.make,v 1.1 2005/04/06 14:58:00 nesladek Exp $
#
# Copyright (C) 2005 by Jiri Nesladek
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLEX) += flex

#
# Paths and names
#
FLEX_VERSION	= 2.5.4
FLEX		= flex-$(FLEX_VERSION)
FLEX_SUFFIX	= tar.gz
FLEX_URL	= $(PTXCONF_SETUP_SFMIRROR)/flex/$(FLEX)a.$(FLEX_SUFFIX)
FLEX_SOURCE	= $(SRCDIR)/$(FLEX)a.$(FLEX_SUFFIX)
FLEX_DIR	= $(BUILDDIR)/$(FLEX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

flex_get: $(STATEDIR)/flex.get

$(STATEDIR)/flex.get: $(flex_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FLEX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FLEX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

flex_extract: $(STATEDIR)/flex.extract

$(STATEDIR)/flex.extract: $(flex_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FLEX_DIR))
	@$(call extract, FLEX)
	@$(call patchin, FLEX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

flex_prepare: $(STATEDIR)/flex.prepare

FLEX_PATH	=  PATH=$(CROSS_PATH)
FLEX_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
FLEX_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/flex.prepare: $(flex_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FLEX_DIR)/config.cache)
	cd $(FLEX_DIR) && \
		$(FLEX_PATH) $(FLEX_ENV) \
		./configure $(FLEX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

flex_compile: $(STATEDIR)/flex.compile

$(STATEDIR)/flex.compile: $(flex_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FLEX_DIR) && $(FLEX_ENV) $(FLEX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

flex_install: $(STATEDIR)/flex.install

$(STATEDIR)/flex.install: $(flex_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FLEX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

flex_targetinstall: $(STATEDIR)/flex.targetinstall

$(STATEDIR)/flex.targetinstall: $(flex_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

flex_clean:
	rm -rf $(STATEDIR)/flex.*
	rm -rf $(FLEX_DIR)

# vim: syntax=make

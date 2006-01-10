# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# RSC: FIXME: make this a hosttool

#
# FIXME: Broken Package
#

#
# Paths and names
#
AUTOMAKE176_VERSION	= 1.7.6
AUTOMAKE176		= automake-$(AUTOMAKE176_VERSION)
AUTOMAKE176_SUFFIX	= tar.bz2
AUTOMAKE176_URL		= $(PTXCONF_SETUP_GNUMIRROR)/automake/$(AUTOMAKE176).$(AUTOMAKE176_SUFFIX)
AUTOMAKE176_SOURCE	= $(SRCDIR)/$(AUTOMAKE176).$(AUTOMAKE176_SUFFIX)
AUTOMAKE176_DIR		= $(BUILDDIR)/$(AUTOMAKE176)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

automake176_get: $(STATEDIR)/automake176.get

automake176_get_deps	=  $(AUTOMAKE176_SOURCE)

$(STATEDIR)/automake176.get: $(automake176_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(AUTOMAKE176_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(AUTOMAKE176_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

automake176_extract: $(STATEDIR)/automake176.extract

automake176_extract_deps	=  $(STATEDIR)/automake176.get

$(STATEDIR)/automake176.extract: $(automake176_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AUTOMAKE176_DIR))
	@$(call extract, $(AUTOMAKE176_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

automake176_prepare: $(STATEDIR)/automake176.prepare

#
# dependencies
#
automake176_prepare_deps =  \
	$(STATEDIR)/autoconf257.install \
	$(STATEDIR)/automake176.extract

AUTOMAKE176_PATH	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$(CROSS_PATH)

#
# autoconf
#
# FIXME FIXME FIXME
AUTOMAKE176_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(AUTOMAKE176)

$(STATEDIR)/automake176.prepare: $(automake176_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AUTOMAKE176_BUILDDIR))
	cd $(AUTOMAKE176_DIR) && \
		$(AUTOMAKE176_PATH) \
		./configure $(AUTOMAKE176_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

automake176_compile: $(STATEDIR)/automake176.compile

automake176_compile_deps =  $(STATEDIR)/automake176.prepare

$(STATEDIR)/automake176.compile: $(automake176_compile_deps)
	@$(call targetinfo, $@)
	$(AUTOMAKE176_PATH) make -C $(AUTOMAKE176_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

automake176_install: $(STATEDIR)/automake176.install

$(STATEDIR)/automake176.install: $(STATEDIR)/automake176.compile
	@$(call targetinfo, $@)
	@$(call install, AUTOMAKE176)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

automake176_targetinstall: $(STATEDIR)/automake176.targetinstall

automake176_targetinstall_deps	=

$(STATEDIR)/automake176.targetinstall: $(automake176_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

automake176_clean:
	rm -rf $(STATEDIR)/automake176.*
	rm -rf $(AUTOMAKE176_DIR)

# vim: syntax=make

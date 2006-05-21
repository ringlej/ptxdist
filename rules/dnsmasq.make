# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DNSMASQ) += dnsmasq

#
# Paths and names
#
DNSMASQ_VERSION		= 2.24
DNSMASQ			= dnsmasq-$(DNSMASQ_VERSION)
DNSMASQ_SUFFIX		= tar.gz
DNSMASQ_URL		= http://www.thekelleys.org.uk/dnsmasq/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_SOURCE		= $(SRCDIR)/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_DIR		= $(BUILDDIR)/$(DNSMASQ)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dnsmasq_get: $(STATEDIR)/dnsmasq.get

$(STATEDIR)/dnsmasq.get: $(dnsmasq_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DNSMASQ_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DNSMASQ)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dnsmasq_extract: $(STATEDIR)/dnsmasq.extract

$(STATEDIR)/dnsmasq.extract: $(dnsmasq_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DNSMASQ_DIR))
	@$(call extract, DNSMASQ)
	@$(call patchin, DNSMASQ)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dnsmasq_prepare: $(STATEDIR)/dnsmasq.prepare

DNSMASQ_PATH	=  PATH=$(CROSS_PATH)
DNSMASQ_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/dnsmasq.prepare: $(dnsmasq_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dnsmasq_compile: $(STATEDIR)/dnsmasq.compile

$(STATEDIR)/dnsmasq.compile: $(dnsmasq_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DNSMASQ_DIR) && $(DNSMASQ_PATH) $(DNSMASQ_ENV) make $(DNSMASQ_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dnsmasq_install: $(STATEDIR)/dnsmasq.install

$(STATEDIR)/dnsmasq.install: $(dnsmasq_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DNSMASQ)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dnsmasq_targetinstall: $(STATEDIR)/dnsmasq.targetinstall

$(STATEDIR)/dnsmasq.targetinstall: $(dnsmasq_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dnsmasq)
	@$(call install_fixup, dnsmasq,PACKAGE,dnsmasq)
	@$(call install_fixup, dnsmasq,PRIORITY,optional)
	@$(call install_fixup, dnsmasq,VERSION,$(DNSMASQ_VERSION))
	@$(call install_fixup, dnsmasq,SECTION,base)
	@$(call install_fixup, dnsmasq,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dnsmasq,DEPENDS,)
	@$(call install_fixup, dnsmasq,DESCRIPTION,missing)
	
	@$(call install_copy, dnsmasq, 0, 0, 0755, $(DNSMASQ_DIR)/src/dnsmasq, /sbin/dnsmasq)

	@$(call install_finish, dnsmasq)
	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dnsmasq_clean:
	rm -rf $(STATEDIR)/dnsmasq.*
	rm -rf $(IMAGEDIR)/dnsmasq_*
	rm -rf $(DNSMASQ_DIR)

# vim: syntax=make

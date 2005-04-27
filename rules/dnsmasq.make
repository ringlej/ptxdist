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
ifdef PTXCONF_DNSMASQ
PACKAGES += dnsmasq
endif

#
# Paths and names
#
DNSMASQ_VERSION		= 2.13
DNSMASQ			= dnsmasq-$(DNSMASQ_VERSION)
DNSMASQ_SUFFIX		= tar.gz
DNSMASQ_URL		= http://www.thekelleys.org.uk/dnsmasq/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_SOURCE		= $(SRCDIR)/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_DIR		= $(BUILDDIR)/$(DNSMASQ)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dnsmasq_get: $(STATEDIR)/dnsmasq.get

dnsmasq_get_deps = $(DNSMASQ_SOURCE)

$(STATEDIR)/dnsmasq.get: $(dnsmasq_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(DNSMASQ)) 
	touch $@

$(DNSMASQ_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DNSMASQ_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dnsmasq_extract: $(STATEDIR)/dnsmasq.extract

dnsmasq_extract_deps = $(STATEDIR)/dnsmasq.get

$(STATEDIR)/dnsmasq.extract: $(dnsmasq_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DNSMASQ_DIR))
	@$(call extract, $(DNSMASQ_SOURCE))
	@$(call patchin, $(DNSMASQ))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dnsmasq_prepare: $(STATEDIR)/dnsmasq.prepare

#
# dependencies
#
dnsmasq_prepare_deps = \
	$(STATEDIR)/dnsmasq.extract \
	$(STATEDIR)/virtual-xchain.install

DNSMASQ_PATH	=  PATH=$(CROSS_PATH)
DNSMASQ_ENV 	=  $(CROSS_ENV)
#DNSMASQ_ENV	+=

$(STATEDIR)/dnsmasq.prepare: $(dnsmasq_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dnsmasq_compile: $(STATEDIR)/dnsmasq.compile

dnsmasq_compile_deps = $(STATEDIR)/dnsmasq.prepare

$(STATEDIR)/dnsmasq.compile: $(dnsmasq_compile_deps)
	@$(call targetinfo, $@)
	$(DNSMASQ_PATH) $(DNSMASQ_ENV) make -C $(DNSMASQ_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dnsmasq_install: $(STATEDIR)/dnsmasq.install

$(STATEDIR)/dnsmasq.install: $(STATEDIR)/dnsmasq.compile
	@$(call targetinfo, $@)
	$(DNSMASQ_PATH) make -C $(DNSMASQ_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dnsmasq_targetinstall: $(STATEDIR)/dnsmasq.targetinstall

dnsmasq_targetinstall_deps = $(STATEDIR)/dnsmasq.compile

$(STATEDIR)/dnsmasq.targetinstall: $(dnsmasq_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,dnsmasq)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(DNSMASQ_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(DNSMASQ_DIR)/src/dnsmasq, /sbin/dnsmasq)

	@$(call install_finish)
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dnsmasq_clean:
	rm -rf $(STATEDIR)/dnsmasq.*
	rm -rf $(IMAGEDIR)/dnsmasq_*
	rm -rf $(DNSMASQ_DIR)

# vim: syntax=make

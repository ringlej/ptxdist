# -*-makefile-*-
# $Id: dhcp.make,v 1.4 2004/08/27 14:50:40 bsp Exp $
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
ifdef PTXCONF_DHCP
PACKAGES += dhcp
endif

#
# Paths and names
#
DHCP_VERSION	= 3.0.1
DHCP		= dhcp-$(DHCP_VERSION)
DHCP_SUFFIX	= tar.gz
DHCP_URL	= ftp://ftp.isc.org/isc/dhcp/$(DHCP).$(DHCP_SUFFIX)
DHCP_SOURCE	= $(SRCDIR)/$(DHCP).$(DHCP_SUFFIX)
DHCP_DIR	= $(BUILDDIR)/$(DHCP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dhcp_get: $(STATEDIR)/dhcp.get

dhcp_get_deps = $(DHCP_SOURCE)

$(STATEDIR)/dhcp.get: $(dhcp_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(DHCP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DHCP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dhcp_extract: $(STATEDIR)/dhcp.extract

dhcp_extract_deps = $(STATEDIR)/dhcp.get

$(STATEDIR)/dhcp.extract: $(dhcp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DHCP_DIR))
	@$(call extract, $(DHCP_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dhcp_prepare: $(STATEDIR)/dhcp.prepare

#
# dependencies
#
dhcp_prepare_deps = \
	$(STATEDIR)/dhcp.extract \
	$(STATEDIR)/virtual-xchain.install

DHCP_PATH	=  PATH=$(CROSS_PATH)
DHCP_ENV 	=  $(CROSS_ENV)
#DHCP_ENV	+=

$(STATEDIR)/dhcp.prepare: $(dhcp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DHCP_DIR)/config.cache)
	cd $(DHCP_DIR) && \
		$(DHCP_PATH) $(DHCP_ENV) \
		./configure $(PTXCONF_GNU_TARGET)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dhcp_compile: $(STATEDIR)/dhcp.compile

dhcp_compile_deps = $(STATEDIR)/dhcp.prepare

$(STATEDIR)/dhcp.compile: $(dhcp_compile_deps)
	@$(call targetinfo, $@)
	cd $(DHCP_DIR) && $(DHCP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dhcp_install: $(STATEDIR)/dhcp.install

$(STATEDIR)/dhcp.install: $(STATEDIR)/dhcp.compile
	@$(call targetinfo, $@)
	$(DHCP_PATH) make -C $(DHCP_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dhcp_targetinstall: $(STATEDIR)/dhcp.targetinstall

dhcp_targetinstall_deps = $(STATEDIR)/dhcp.compile

$(STATEDIR)/dhcp.targetinstall: $(dhcp_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dhcp_clean:
	rm -rf $(STATEDIR)/dhcp.*
	rm -rf $(DHCP_DIR)

# vim: syntax=make

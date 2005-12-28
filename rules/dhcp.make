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
PACKAGES-$(PTXCONF_DHCP) += dhcp

#
# Paths and names
#
DHCP_VERSION	= 3.0.3
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
	@$(call touch, $@)

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
	@$(call touch, $@)

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

# linux-2.2 is the way to go ;-)

$(STATEDIR)/dhcp.prepare: $(dhcp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DHCP_DIR)/config.cache)
	cd $(DHCP_DIR) && \
		$(DHCP_PATH) $(DHCP_ENV) \
		./configure "linux-2.2"
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dhcp_compile: $(STATEDIR)/dhcp.compile

dhcp_compile_deps = $(STATEDIR)/dhcp.prepare

$(STATEDIR)/dhcp.compile: $(dhcp_compile_deps)
	@$(call targetinfo, $@)
	cd $(DHCP_DIR) && $(DHCP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dhcp_install: $(STATEDIR)/dhcp.install

$(STATEDIR)/dhcp.install: $(STATEDIR)/dhcp.compile
	@$(call targetinfo, $@)
	@$(call install, DHCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dhcp_targetinstall: $(STATEDIR)/dhcp.targetinstall

dhcp_targetinstall_deps = $(STATEDIR)/dhcp.compile

$(STATEDIR)/dhcp.targetinstall: $(dhcp_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,dhcp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(DHCP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(DHCP_DIR)/work.linux-2.2/server/dhcpd, /usr/sbin/dhcpd)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dhcp_clean:
	rm -rf $(STATEDIR)/dhcp.*
	rm -rf $(IMAGEDIR)/dhcp_*
	rm -rf $(DHCP_DIR)

# vim: syntax=make

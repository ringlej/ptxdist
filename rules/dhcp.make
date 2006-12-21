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
DHCP_VERSION	= 3.0.5
DHCP		= dhcp-$(DHCP_VERSION)
DHCP_SUFFIX	= tar.gz
DHCP_URL	= ftp://ftp.isc.org/isc/dhcp/$(DHCP).$(DHCP_SUFFIX)
DHCP_SOURCE	= $(SRCDIR)/$(DHCP).$(DHCP_SUFFIX)
DHCP_DIR	= $(BUILDDIR)/$(DHCP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dhcp_get: $(STATEDIR)/dhcp.get

$(STATEDIR)/dhcp.get: $(dhcp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DHCP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DHCP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dhcp_extract: $(STATEDIR)/dhcp.extract

$(STATEDIR)/dhcp.extract: $(dhcp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DHCP_DIR))
	@$(call extract, DHCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dhcp_prepare: $(STATEDIR)/dhcp.prepare

DHCP_PATH	=  PATH=$(CROSS_PATH)
DHCP_ENV 	=  $(CROSS_ENV)
#DHCP_ENV	+=

# linux-2.2 is the way to go ;-)

$(STATEDIR)/dhcp.prepare: $(dhcp_prepare_deps_default)
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

$(STATEDIR)/dhcp.compile: $(dhcp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DHCP_DIR) && $(DHCP_PATH) $(DHCP_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dhcp_install: $(STATEDIR)/dhcp.install

$(STATEDIR)/dhcp.install: $(dhcp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DHCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dhcp_targetinstall: $(STATEDIR)/dhcp.targetinstall

$(STATEDIR)/dhcp.targetinstall: $(dhcp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dhcp)
	@$(call install_fixup, dhcp,PACKAGE,dhcp)
	@$(call install_fixup, dhcp,PRIORITY,optional)
	@$(call install_fixup, dhcp,VERSION,$(DHCP_VERSION))
	@$(call install_fixup, dhcp,SECTION,base)
	@$(call install_fixup, dhcp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dhcp,DEPENDS,)
	@$(call install_fixup, dhcp,DESCRIPTION,missing)

ifdef PTXCONF_DHCP_SERVER
	@$(call install_copy, dhcp, 0, 0, 0755, \
		$(DHCP_DIR)/work.linux-2.2/server/dhcpd, /sbin/dhcpd)
endif

ifdef PTXCONF_DHCP_CLIENT
	@$(call install_copy, dhcp, 0, 0, 0755, \
		$(DHCP_DIR)/work.linux-2.2/client/dhclient, /sbin/dhclient)
	@$(call install_copy, dhcp, 0, 0, 0755, /var/state/dhcp )

ifdef PTXCONF_DHCP_CLIENT_CONFIG_DEFAULT
	@$(call install_copy, dhcp, 0, 0, 0755, \
		$(DHCP_DIR)/client/dhclient.conf, /etc/dhclient.conf, n)
endif
ifdef PTXCONF_DHCP_CLIENT_CONFIG_USER
	@$(call install_copy, dhcp, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/dhclient.conf, \
		/etc/dhclient.conf, n)
endif
	@$(call install_copy, dhcp, 0, 0, 0755, \
		$(DHCP_DIR)/client/scripts/linux, /sbin/dhclient-script, n)
endif

ifdef PTXCONF_DHCP_RELAY
	@$(call install_copy, dhcp, 0, 0, 0755, $(DHCP_DIR)/work.linux-2.2/relay/dhcrelay, /sbin/dhcrelay)
endif

	@$(call install_finish, dhcp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dhcp_clean:
	rm -rf $(STATEDIR)/dhcp.*
	rm -rf $(IMAGEDIR)/dhcp_*
	rm -rf $(DHCP_DIR)

# vim: syntax=make

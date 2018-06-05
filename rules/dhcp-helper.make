# -*-makefile-*-
#
# Copyright (C) 2015 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DHCP_HELPER) += dhcp-helper

#
# Paths and names
#
DHCP_HELPER_VERSION	:= 1.1
DHCP_HELPER_MD5		:= d749a53d8b488b6a15b7400185b99bb3
DHCP_HELPER		:= dhcp-helper-$(DHCP_HELPER_VERSION)
DHCP_HELPER_SUFFIX	:= tar.gz
DHCP_HELPER_URL		:= http://www.thekelleys.org.uk/dhcp-helper/$(DHCP_HELPER).$(DHCP_HELPER_SUFFIX)
DHCP_HELPER_SOURCE	:= $(SRCDIR)/$(DHCP_HELPER).$(DHCP_HELPER_SUFFIX)
DHCP_HELPER_DIR		:= $(BUILDDIR)/$(DHCP_HELPER)
DHCP_HELPER_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DHCP_HELPER_CONF_TOOL	:=  NO
DHCP_HELPER_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	PREFIX=/usr

DHCP_HELPER_INSTALL_OPT := \
	$(DHCP_HELPER_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dhcp-helper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dhcp-helper)
	@$(call install_fixup, dhcp-helper,PRIORITY,optional)
	@$(call install_fixup, dhcp-helper,SECTION,base)
	@$(call install_fixup, dhcp-helper,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, dhcp-helper,DESCRIPTION,missing)

	@$(call install_copy, dhcp-helper, 0, 0, 0755, -, /usr/sbin/dhcp-helper)

	@$(call install_finish, dhcp-helper)

	@$(call touch)

# vim: syntax=make

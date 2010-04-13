# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHTOOL) += ethtool

#
# Paths and names
#
ETHTOOL_VERSION	:= 6+20090323.orig
ETHTOOL_SUFFIX	:= tar.gz
ETHTOOL		:= ethtool-$(ETHTOOL_VERSION)
ETHTOOL_TARBALL	:= ethtool_$(ETHTOOL_VERSION).$(ETHTOOL_SUFFIX)
ETHTOOL_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/e/ethtool/$(ETHTOOL_TARBALL)
ETHTOOL_SOURCE	:= $(SRCDIR)/$(ETHTOOL_TARBALL)
ETHTOOL_DIR	:= $(BUILDDIR)/$(ETHTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ETHTOOL_SOURCE):
	@$(call targetinfo)
	@$(call get, ETHTOOL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ETHTOOL_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ethtool.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ethtool)
	@$(call install_fixup, ethtool,PACKAGE,ethtool)
	@$(call install_fixup, ethtool,PRIORITY,optional)
	@$(call install_fixup, ethtool,VERSION,$(ETHTOOL_VERSION))
	@$(call install_fixup, ethtool,SECTION,base)
	@$(call install_fixup, ethtool,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ethtool,DEPENDS,)
	@$(call install_fixup, ethtool,DESCRIPTION,missing)

	@$(call install_copy, ethtool, 0, 0, 0755, -, /usr/sbin/ethtool)

	@$(call install_finish, ethtool)

	@$(call touch)

# vim: syntax=make

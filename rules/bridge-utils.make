# -*-makefile-*-
#
# Copyright (C) 2005 by Gary Thomas <gary@mlbassoc.com>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BRIDGE_UTILS) += bridge-utils

#
# Paths and names
#
BRIDGE_UTILS_VERSION	:= 1.6
BRIDGE_UTILS_MD5	:= f369e90e85e4bb46baa26a7b9d66b578
BRIDGE_UTILS		:= bridge-utils-$(BRIDGE_UTILS_VERSION)
BRIDGE_UTILS_SUFFIX	:= tar.gz
BRIDGE_UTILS_URL	:= https://www.kernel.org/pub/linux/utils/net/bridge-utils/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_SOURCE	:= $(SRCDIR)/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_DIR	:= $(BUILDDIR)/$(BRIDGE_UTILS)
BRIDGE_UTILS_LICENSE	:= GPL-2.0-or-later


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BRIDGE_UTILS_CONF_TOOL	:= autoconf

# Set with-linux-headers to something that doesn't exist to avoid the default
# path picking up a path from the build host.
BRIDGE_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-linux-headers=/this/path/must/not/exist

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bridge-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bridge-utils)
	@$(call install_fixup, bridge-utils,PRIORITY,optional)
	@$(call install_fixup, bridge-utils,SECTION,base)
	@$(call install_fixup, bridge-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bridge-utils,DESCRIPTION,missing)

	@$(call install_copy, bridge-utils, 0, 0, 0755, -, /usr/sbin/brctl)

	@$(call install_finish, bridge-utils)
	@$(call touch)

# vim: syntax=make

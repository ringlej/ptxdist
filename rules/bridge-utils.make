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
BRIDGE_UTILS_VERSION	:= 1.4
BRIDGE_UTILS		:= bridge-utils-$(BRIDGE_UTILS_VERSION)
BRIDGE_UTILS_SUFFIX	:= tar.gz
BRIDGE_UTILS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/bridge/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_SOURCE	:= $(SRCDIR)/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_DIR	:= $(BUILDDIR)/$(BRIDGE_UTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BRIDGE_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, BRIDGE_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BRIDGE_UTILS_PATH	:= PATH=$(CROSS_PATH)
BRIDGE_UTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BRIDGE_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-linux-headers=$(KERNEL_HEADERS_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bridge-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,   bridge-utils)
	@$(call install_fixup,  bridge-utils,PRIORITY,optional)
	@$(call install_fixup,  bridge-utils,SECTION,base)
	@$(call install_fixup,  bridge-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,  bridge-utils,DESCRIPTION,missing)

	@$(call install_copy,   bridge-utils, 0, 0, 0755, -, /usr/sbin/brctl)

	@$(call install_finish, bridge-utils)
	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_IPKG_UTILS) += host-ipkg-utils

#
# Paths and names
#
HOST_IPKG_UTILS_VERSION	:= 050831
HOST_IPKG_UTILS		:= ipkg-utils-$(HOST_IPKG_UTILS_VERSION)
HOST_IPKG_UTILS_SUFFIX	:= tar.gz
HOST_IPKG_UTILS_URL	:= http://www.handhelds.org/download/packages/ipkg-utils/$(HOST_IPKG_UTILS).$(HOST_IPKG_UTILS_SUFFIX)
HOST_IPKG_UTILS_SOURCE	:= $(SRCDIR)/$(HOST_IPKG_UTILS).$(HOST_IPKG_UTILS_SUFFIX)
HOST_IPKG_UTILS_DIR	:= $(HOST_BUILDDIR)/$(HOST_IPKG_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_IPKG_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_IPKG_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_IPKG_UTILS_CONF_TOOL := NO
HOST_IPKG_UTILS_MAKE_OPT := PREFIX=$(PTXCONF_SYSROOT_HOST) $(HOST_ENV_CC)
HOST_IPKG_UTILS_INSTALL_OPT := $(HOST_IPKG_UTILS_MAKE_OPT) install

# vim: syntax=make

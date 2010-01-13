# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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

HOST_IPKG_UTILS_PATH	:= PATH=$(HOST_PATH)
HOST_IPKG_UTILS_ENV 	:= $(HOST_ENV)
HOST_IPKG_UTILS_MAKEVARS := PREFIX=$(PTXCONF_SYSROOT_HOST)

$(STATEDIR)/host-ipkg-utils.prepare:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

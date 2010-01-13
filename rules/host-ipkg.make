# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_IPKG) += host-ipkg

#
# Paths and names
#

HOST_IPKG	= $(IPKG)
HOST_IPKG_DIR	= $(HOST_BUILDDIR)/$(HOST_IPKG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ipkg.get: $(STATEDIR)/ipkg.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ipkg.extract: $(STATEDIR)/ipkg.get
	@$(call targetinfo)
	@$(call clean, $(HOST_IPKG_DIR))
	@$(call extract, IPKG, $(HOST_BUILDDIR))
	@$(call patchin, IPKG, $(HOST_IPKG_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_IPKG_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_IPKG_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-shared

# vim: syntax=make

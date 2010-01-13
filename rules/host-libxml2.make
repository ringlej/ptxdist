# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXML2) += host-libxml2

#
# Paths and names
#
HOST_LIBXML2_DIR	= $(HOST_BUILDDIR)/$(LIBXML2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libxml2.get: $(STATEDIR)/libxml2.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libxml2.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBXML2_DIR))
	@$(call extract, LIBXML2, $(HOST_BUILDDIR))
	@$(call patchin, LIBXML2, $(HOST_LIBXML2_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBXML2_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXML2_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXML2_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_EXPAT) += host-expat

#
# Paths and names
#
HOST_EXPAT	= $(EXPAT)
HOST_EXPAT_DIR	= $(HOST_BUILDDIR)/$(HOST_EXPAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-expat.get: $(STATEDIR)/expat.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-expat.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_EXPAT_DIR))
	@$(call extract, EXPAT, $(HOST_BUILDDIR))
	@$(call patchin, EXPAT, $(HOST_EXPAT_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_EXPAT_PATH	:= PATH=$(HOST_PATH)
HOST_EXPAT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_EXPAT_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-expat_clean:
	rm -rf $(STATEDIR)/host-expat.*
	rm -rf $(HOST_EXPAT_DIR)

# vim: syntax=make

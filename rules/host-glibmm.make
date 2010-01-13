# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_GLIBMM) += host-glibmm

#
# Paths and names
#
HOST_GLIBMM_DIR	= $(HOST_BUILDDIR)/$(GLIBMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glibmm.get: $(STATEDIR)/glibmm.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLIBMM_PATH	:= PATH=$(HOST_PATH)
HOST_GLIBMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLIBMM_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

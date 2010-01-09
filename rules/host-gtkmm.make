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
HOST_PACKAGES-$(PTXCONF_HOST_GTKMM) += host-gtkmm

#
# Paths and names
#
HOST_GTKMM_DIR	= $(HOST_BUILDDIR)/$(GTKMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtkmm.get: $(STATEDIR)/gtkmm.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GTKMM_PATH	:= PATH=$(HOST_PATH)
HOST_GTKMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GTKMM_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gtkmm_clean:
	rm -rf $(STATEDIR)/host-gtkmm.*
	rm -rf $(HOST_GTKMM_DIR)

# vim: syntax=make

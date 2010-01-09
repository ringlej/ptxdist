# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel <r.schwebel@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_LIBGLADE) += host-libglade

#
# Paths and names
#
HOST_LIBGLADE_DIR	= $(HOST_BUILDDIR)/$(LIBGLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libglade.get: $(STATEDIR)/libglade.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBGLADE_PATH	:= PATH=$(HOST_PATH)
HOST_LIBGLADE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBGLADE_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libglade_clean:
	rm -rf $(STATEDIR)/host-libglade.*
	rm -rf $(HOST_LIBGLADE_DIR)

# vim: syntax=make

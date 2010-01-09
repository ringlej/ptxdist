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
HOST_PACKAGES-$(PTXCONF_HOST_CAIROMM) += host-cairomm

#
# Paths and names
#
HOST_CAIROMM_DIR	= $(HOST_BUILDDIR)/$(CAIROMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cairomm.get: $(STATEDIR)/cairomm.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CAIROMM_PATH	:= PATH=$(HOST_PATH)
HOST_CAIROMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CAIROMM_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-cairomm_clean:
	rm -rf $(STATEDIR)/host-cairomm.*
	rm -rf $(HOST_CAIROMM_DIR)

# vim: syntax=make

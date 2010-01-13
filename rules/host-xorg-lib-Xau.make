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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XAU) += host-xorg-lib-xau

#
# Paths and names
#
HOST_XORG_LIB_XAU_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-lib-xau.get: $(STATEDIR)/xorg-lib-xau.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_LIB_XAU_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XAU_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XAU_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

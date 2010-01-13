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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_KB) += host-xorg-proto-kb

#
# Paths and names
#
HOST_XORG_PROTO_KB_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_KB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-proto-kb.get: $(STATEDIR)/xorg-proto-kb.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_KB_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_KB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_KB_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

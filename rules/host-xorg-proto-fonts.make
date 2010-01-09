# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_FONTS) += host-xorg-proto-fonts

#
# Paths and names
#
HOST_XORG_PROTO_FONTS_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_FONTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-proto-fonts.get: $(STATEDIR)/xorg-proto-fonts.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_FONTS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_FONTS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_FONTS_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-fonts.*
	rm -rf $(HOST_XORG_PROTO_FONTS_DIR)

# vim: syntax=make

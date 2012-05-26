# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_SERVER) += host-xorg-server

#
# Paths and names
#
HOST_XORG_SERVER_DIR	= $(HOST_BUILDDIR)/$(XORG_SERVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-server.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-server.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-server.install:
	@$(call targetinfo)
	install -D -m 644 $(HOST_XORG_SERVER_DIR)/xorg-server.m4 \
		$(HOST_XORG_SERVER_PKGDIR)/share/aclocal/xorg-server.m4
	@$(call touch)

# vim: syntax=make

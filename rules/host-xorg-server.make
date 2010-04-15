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

#
# well, well, what can I say: HACK-warning
#
# this way we fool the patching not to patch us
# and the autogen_dep script, not to run autogen on us
#
HOST_XORG_SERVER	= host-$(XORG_SERVER)

ifdef PTXCONF_HOST_XORG_SERVER
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-xorg-server.install.post
endif

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
	@cd $(HOST_XORG_SERVER_DIR) && cp xorg-server.m4 $(PTXDIST_SYSROOT_HOST)/share/aclocal/
	@$(call touch)

# vim: syntax=make

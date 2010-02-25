# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
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

ifdef PTXCONF_HOST_XORG_SERVER
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-xorg-server.install
endif

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

#
# special extract stage without patchin, we don't need the patches and
# cannot autoreconf, because the autotools are not build yet
#
$(STATEDIR)/host-xorg-server.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_XORG_SERVER_DIR))
	@$(call extract, HOST_XORG_SERVER, $(HOST_BUILDDIR))
	@$(call touch)

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

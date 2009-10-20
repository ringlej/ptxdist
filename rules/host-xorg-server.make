# -*-makefile-*-
# $Id$
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
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-server.get: $(STATEDIR)/xorg-server.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-server.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_XORG_SERVER_DIR))
	@$(call extract, XORG_SERVER, $(HOST_BUILDDIR))
	@$(call patchin, XORG_SERVER, $(HOST_XORG_SERVER_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_SERVER_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_SERVER_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_SERVER_AUTOCONF	:= $(HOST_AUTOCONF)

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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-server_clean:
	rm -rf $(STATEDIR)/host-xorg-server.*
	rm -rf $(HOST_XORG_SERVER_DIR)

# vim: syntax=make

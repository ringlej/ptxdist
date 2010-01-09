# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2009 by Robert Schwebel
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
PACKAGES-$(PTXCONF_XORG_PROTO_DMX) += xorg-proto-dmx

#
# Paths and names
#
XORG_PROTO_DMX_VERSION	:= 2.3
XORG_PROTO_DMX		:= dmxproto-$(XORG_PROTO_DMX_VERSION)
XORG_PROTO_DMX_SUFFIX	:= tar.bz2
XORG_PROTO_DMX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX)
XORG_PROTO_DMX_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX)
XORG_PROTO_DMX_DIR	:= $(BUILDDIR)/$(XORG_PROTO_DMX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_DMX_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_DMX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_DMX_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_DMX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_DMX_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-dmx.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-dmx_clean:
	rm -rf $(STATEDIR)/xorg-proto-dmx.*
	rm -rf $(PKGDIR)/xorg-proto-dmx_*
	rm -rf $(XORG_PROTO_DMX_DIR)

# vim: syntax=make


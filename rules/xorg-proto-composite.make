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
PACKAGES-$(PTXCONF_XORG_PROTO_COMPOSITE) += xorg-proto-composite

#
# Paths and names
#
XORG_PROTO_COMPOSITE_VERSION 	:= 0.4.2
XORG_PROTO_COMPOSITE		:= compositeproto-$(XORG_PROTO_COMPOSITE_VERSION)
XORG_PROTO_COMPOSITE_SUFFIX	:= tar.bz2
XORG_PROTO_COMPOSITE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_COMPOSITE).$(XORG_PROTO_COMPOSITE_SUFFIX)
XORG_PROTO_COMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_COMPOSITE).$(XORG_PROTO_COMPOSITE_SUFFIX)
XORG_PROTO_COMPOSITE_DIR	:= $(BUILDDIR)/$(XORG_PROTO_COMPOSITE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_COMPOSITE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_COMPOSITE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_COMPOSITE_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_COMPOSITE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_COMPOSITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-composite.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


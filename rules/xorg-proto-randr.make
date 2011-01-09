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
PACKAGES-$(PTXCONF_XORG_PROTO_RANDR) += xorg-proto-randr

#
# Paths and names
#
XORG_PROTO_RANDR_VERSION:= 1.3.2
XORG_PROTO_RANDR	:= randrproto-$(XORG_PROTO_RANDR_VERSION)
XORG_PROTO_RANDR_SUFFIX	:= tar.bz2
XORG_PROTO_RANDR_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RANDR).$(XORG_PROTO_RANDR_SUFFIX)
XORG_PROTO_RANDR_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RANDR).$(XORG_PROTO_RANDR_SUFFIX)
XORG_PROTO_RANDR_DIR	:= $(BUILDDIR)/$(XORG_PROTO_RANDR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_RANDR_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_RANDR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_RANDR_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_RANDR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RANDR_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-randr.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


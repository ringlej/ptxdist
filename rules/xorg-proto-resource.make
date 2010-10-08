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
PACKAGES-$(PTXCONF_XORG_PROTO_RESOURCE) += xorg-proto-resource

#
# Paths and names
#
XORG_PROTO_RESOURCE_VERSION	:= 1.1.1
XORG_PROTO_RESOURCE_MD5		:= 8ff0525ae7502b48597b78d00bc22284
XORG_PROTO_RESOURCE		:= resourceproto-$(XORG_PROTO_RESOURCE_VERSION)
XORG_PROTO_RESOURCE_SUFFIX	:= tar.bz2
XORG_PROTO_RESOURCE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX)
XORG_PROTO_RESOURCE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX)
XORG_PROTO_RESOURCE_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RESOURCE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_RESOURCE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_RESOURCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_RESOURCE_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_RESOURCE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RESOURCE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-resource.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86DRI) += xorg-proto-xf86dri

#
# Paths and names
#
XORG_PROTO_XF86DRI_VERSION	:= 2.1.0
XORG_PROTO_XF86DRI_MD5		:= 309d552732666c3333d7dc63e80d042f
XORG_PROTO_XF86DRI		:= xf86driproto-$(XORG_PROTO_XF86DRI_VERSION)
XORG_PROTO_XF86DRI_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DRI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DRI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XF86DRI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XF86DRI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XF86DRI_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XF86DRI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86DRI_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xf86dri.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


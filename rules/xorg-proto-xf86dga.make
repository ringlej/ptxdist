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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86DGA) += xorg-proto-xf86dga

#
# Paths and names
#
XORG_PROTO_XF86DGA_VERSION	:= 2.1
XORG_PROTO_XF86DGA_MD5		:= a036dc2fcbf052ec10621fd48b68dbb1
XORG_PROTO_XF86DGA		:= xf86dgaproto-$(XORG_PROTO_XF86DGA_VERSION)
XORG_PROTO_XF86DGA_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DGA_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XF86DGA).$(XORG_PROTO_XF86DGA_SUFFIX))
XORG_PROTO_XF86DGA_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DGA).$(XORG_PROTO_XF86DGA_SUFFIX)
XORG_PROTO_XF86DGA_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DGA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XF86DGA_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XF86DGA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XF86DGA_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XF86DGA_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86DGA_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xf86dga.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


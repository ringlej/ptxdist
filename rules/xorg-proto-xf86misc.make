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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86MISC) += xorg-proto-xf86misc

#
# Paths and names
#
XORG_PROTO_XF86MISC_VERSION	:= 0.9.3
XORG_PROTO_XF86MISC_MD5		:= ca63bbb31cf5b7f37b2237e923ff257a
XORG_PROTO_XF86MISC		:= xf86miscproto-$(XORG_PROTO_XF86MISC_VERSION)
XORG_PROTO_XF86MISC_SUFFIX	:= tar.bz2
XORG_PROTO_XF86MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86MISC).$(XORG_PROTO_XF86MISC_SUFFIX)
XORG_PROTO_XF86MISC_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86MISC).$(XORG_PROTO_XF86MISC_SUFFIX)
XORG_PROTO_XF86MISC_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86MISC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XF86MISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XF86MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XF86MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XF86MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xf86misc.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


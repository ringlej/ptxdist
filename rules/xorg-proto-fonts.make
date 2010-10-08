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
PACKAGES-$(PTXCONF_XORG_PROTO_FONTS) += xorg-proto-fonts

#
# Paths and names
#
XORG_PROTO_FONTS_VERSION	:= 2.1.1
XORG_PROTO_FONTS_MD5		:= 37102ffcaa73f77d700acd6f7a25d8f0
XORG_PROTO_FONTS		:= fontsproto-$(XORG_PROTO_FONTS_VERSION)
XORG_PROTO_FONTS_SUFFIX		:= tar.bz2
XORG_PROTO_FONTS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_FONTS).$(XORG_PROTO_FONTS_SUFFIX)
XORG_PROTO_FONTS_SOURCE		:= $(SRCDIR)/$(XORG_PROTO_FONTS).$(XORG_PROTO_FONTS_SUFFIX)
XORG_PROTO_FONTS_DIR		:= $(BUILDDIR)/$(XORG_PROTO_FONTS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_FONTS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_FONTS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_FONTS_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_FONTS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_FONTS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-fonts.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


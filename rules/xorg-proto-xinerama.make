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
PACKAGES-$(PTXCONF_XORG_PROTO_XINERAMA) += xorg-proto-xinerama

#
# Paths and names
#
XORG_PROTO_XINERAMA_VERSION 	:= 1.2
XORG_PROTO_XINERAMA_MD5		:= a8aadcb281b9c11a91303e24cdea45f5
XORG_PROTO_XINERAMA		:= xineramaproto-$(XORG_PROTO_XINERAMA_VERSION)
XORG_PROTO_XINERAMA_SUFFIX	:= tar.bz2
XORG_PROTO_XINERAMA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XINERAMA).$(XORG_PROTO_XINERAMA_SUFFIX)
XORG_PROTO_XINERAMA_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XINERAMA).$(XORG_PROTO_XINERAMA_SUFFIX)
XORG_PROTO_XINERAMA_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XINERAMA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XINERAMA_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XINERAMA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XINERAMA_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XINERAMA_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XINERAMA_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xinerama.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


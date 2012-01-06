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
PACKAGES-$(PTXCONF_XORG_PROTO_RENDER) += xorg-proto-render

#
# Paths and names
#
XORG_PROTO_RENDER_VERSION	:= 0.11.1
XORG_PROTO_RENDER_MD5		:= a914ccc1de66ddeb4b611c6b0686e274
XORG_PROTO_RENDER		:= renderproto-$(XORG_PROTO_RENDER_VERSION)
XORG_PROTO_RENDER_SUFFIX	:= tar.bz2
XORG_PROTO_RENDER_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_RENDER).$(XORG_PROTO_RENDER_SUFFIX))
XORG_PROTO_RENDER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RENDER).$(XORG_PROTO_RENDER_SUFFIX)
XORG_PROTO_RENDER_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RENDER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_RENDER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_RENDER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_RENDER_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_RENDER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RENDER_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-render.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86BIGFONT) += xorg-proto-xf86bigfont

#
# Paths and names
#
XORG_PROTO_XF86BIGFONT_VERSION	:= 1.2.0
XORG_PROTO_XF86BIGFONT_MD5	:= 120e226ede5a4687b25dd357cc9b8efe
XORG_PROTO_XF86BIGFONT		:= xf86bigfontproto-$(XORG_PROTO_XF86BIGFONT_VERSION)
XORG_PROTO_XF86BIGFONT_SUFFIX	:= tar.bz2
XORG_PROTO_XF86BIGFONT_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XF86BIGFONT).$(XORG_PROTO_XF86BIGFONT_SUFFIX))
XORG_PROTO_XF86BIGFONT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86BIGFONT).$(XORG_PROTO_XF86BIGFONT_SUFFIX)
XORG_PROTO_XF86BIGFONT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XF86BIGFONT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XF86BIGFONT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XF86BIGFONT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XF86BIGFONT_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XF86BIGFONT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86BIGFONT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xf86bigfont.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


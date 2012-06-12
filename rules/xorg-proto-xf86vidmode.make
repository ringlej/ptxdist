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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86VIDMODE) += xorg-proto-xf86vidmode

#
# Paths and names
#
XORG_PROTO_XF86VIDMODE_VERSION	:= 2.3.1
XORG_PROTO_XF86VIDMODE_MD5	:= e793ecefeaecfeabd1aed6a01095174e
XORG_PROTO_XF86VIDMODE		:= xf86vidmodeproto-$(XORG_PROTO_XF86VIDMODE_VERSION)
XORG_PROTO_XF86VIDMODE_SUFFIX	:= tar.bz2
XORG_PROTO_XF86VIDMODE_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XF86VIDMODE).$(XORG_PROTO_XF86VIDMODE_SUFFIX))
XORG_PROTO_XF86VIDMODE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86VIDMODE).$(XORG_PROTO_XF86VIDMODE_SUFFIX)
XORG_PROTO_XF86VIDMODE_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XF86VIDMODE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_XF86VIDMODE_CONF_TOOL := autoconf

# vim: syntax=make


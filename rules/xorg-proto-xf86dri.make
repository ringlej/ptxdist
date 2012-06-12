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
XORG_PROTO_XF86DRI_VERSION	:= 2.1.1
XORG_PROTO_XF86DRI_MD5		:= 1d716d0dac3b664e5ee20c69d34bc10e
XORG_PROTO_XF86DRI		:= xf86driproto-$(XORG_PROTO_XF86DRI_VERSION)
XORG_PROTO_XF86DRI_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DRI_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX))
XORG_PROTO_XF86DRI_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DRI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_XF86DRI_CONF_TOOL := autoconf

# vim: syntax=make


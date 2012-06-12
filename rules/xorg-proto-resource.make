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
XORG_PROTO_RESOURCE_VERSION	:= 1.2.0
XORG_PROTO_RESOURCE_MD5		:= cfdb57dae221b71b2703f8e2980eaaf4
XORG_PROTO_RESOURCE		:= resourceproto-$(XORG_PROTO_RESOURCE_VERSION)
XORG_PROTO_RESOURCE_SUFFIX	:= tar.bz2
XORG_PROTO_RESOURCE_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX))
XORG_PROTO_RESOURCE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX)
XORG_PROTO_RESOURCE_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RESOURCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_RESOURCE_CONF_TOOL := autoconf

# vim: syntax=make


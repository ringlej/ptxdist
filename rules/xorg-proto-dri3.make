# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
# Copyright (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_DRI3) += xorg-proto-dri3

#
# Paths and names
#
XORG_PROTO_DRI3_VERSION	:= 1.0
XORG_PROTO_DRI3_MD5	:= a3d2cbe60a9ca1bf3aea6c93c817fee3
XORG_PROTO_DRI3		:= dri3proto-$(XORG_PROTO_DRI3_VERSION)
XORG_PROTO_DRI3_SUFFIX	:= tar.bz2
XORG_PROTO_DRI3_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_DRI3).$(XORG_PROTO_DRI3_SUFFIX))
XORG_PROTO_DRI3_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DRI3).$(XORG_PROTO_DRI3_SUFFIX)
XORG_PROTO_DRI3_DIR	:= $(BUILDDIR)/$(XORG_PROTO_DRI3)
XORG_PROTO_DRI3_LICENSE	:= MIT
XORG_PROTO_DRI3_LICENSE_FILES := \
	file://dri3proto.h;startline=2;endline=20;md5=2dd66dffa047e40483dd101640f3043b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_DRI3_CONF_TOOL := autoconf

# vim: syntax=make

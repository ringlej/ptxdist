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
PACKAGES-$(PTXCONF_XORG_PROTO_DRI2) += xorg-proto-dri2

#
# Paths and names
#
XORG_PROTO_DRI2_VERSION	:= 2.8
XORG_PROTO_DRI2_MD5	:= b2721d5d24c04d9980a0c6540cb5396a
XORG_PROTO_DRI2		:= dri2proto-$(XORG_PROTO_DRI2_VERSION)
XORG_PROTO_DRI2_SUFFIX	:= tar.bz2
XORG_PROTO_DRI2_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_DRI2).$(XORG_PROTO_DRI2_SUFFIX))
XORG_PROTO_DRI2_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DRI2).$(XORG_PROTO_DRI2_SUFFIX)
XORG_PROTO_DRI2_DIR	:= $(BUILDDIR)/$(XORG_PROTO_DRI2)
XORG_PROTO_DRI2_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_DRI2_CONF_TOOL := autoconf

# vim: syntax=make

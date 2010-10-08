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
PACKAGES-$(PTXCONF_DRI2PROTO) += dri2proto

#
# Paths and names
#
DRI2PROTO_VERSION	:= 2.3
DRI2PROTO_MD5		:= 3407b494d5e90d584c9af52aa8f9f028
DRI2PROTO		:= dri2proto-$(DRI2PROTO_VERSION)
DRI2PROTO_SUFFIX	:= tar.bz2
DRI2PROTO_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(DRI2PROTO).$(DRI2PROTO_SUFFIX)
DRI2PROTO_SOURCE	:= $(SRCDIR)/$(DRI2PROTO).$(DRI2PROTO_SUFFIX)
DRI2PROTO_DIR		:= $(BUILDDIR)/$(DRI2PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DRI2PROTO_SOURCE):
	@$(call targetinfo)
	@$(call get, DRI2PROTO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DRI2PROTO_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dri2proto.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

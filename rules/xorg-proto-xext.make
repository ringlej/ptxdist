# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_XEXT) += xorg-proto-xext

#
# Paths and names
#
XORG_PROTO_XEXT_VERSION := 7.1.2
XORG_PROTO_XEXT_MD5	:= 263ae968b223c23b2986603d84e5c30e
XORG_PROTO_XEXT		:= xextproto-$(XORG_PROTO_XEXT_VERSION)
XORG_PROTO_XEXT_SUFFIX	:= tar.bz2
XORG_PROTO_XEXT_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX))
XORG_PROTO_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX)
XORG_PROTO_XEXT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_XEXT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_XEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_XEXT_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_XEXT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XEXT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-xext.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


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
XORG_PROTO_XEXT_VERSION := 7.2.1
XORG_PROTO_XEXT_MD5	:= eaac343af094e6b608cf15cfba0f77c5
XORG_PROTO_XEXT		:= xextproto-$(XORG_PROTO_XEXT_VERSION)
XORG_PROTO_XEXT_SUFFIX	:= tar.bz2
XORG_PROTO_XEXT_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX))
XORG_PROTO_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX)
XORG_PROTO_XEXT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_XEXT_CONF_TOOL	:= autoconf
XORG_PROTO_XEXT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make


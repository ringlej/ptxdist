# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
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
PACKAGES-$(PTXCONF_XORG_PROTO_X) += xorg-proto-x

#
# Paths and names
#
XORG_PROTO_X_VERSION 	:= 7.0.20
XORG_PROTO_X_MD5	:= 65633168e5315c19defb4652cd3d83c1
XORG_PROTO_X		:= xproto-$(XORG_PROTO_X_VERSION)
XORG_PROTO_X_SUFFIX	:= tar.bz2
XORG_PROTO_X_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_X).$(XORG_PROTO_X_SUFFIX)
XORG_PROTO_X_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_X).$(XORG_PROTO_X_SUFFIX)
XORG_PROTO_X_DIR	:= $(BUILDDIR)/$(XORG_PROTO_X)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_X_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_X)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_X_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_X_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_X_AUTOCONF := $(CROSS_AUTOCONF_USR)

#
# this was valid for an x86 target. Check on other
# architectures and do not trust the autodetection
#
XORG_PROTO_X_AUTOCONF += \
	--enable-const-prototypes \
	--enable-function-prototypes \
	--enable-varargs-prototypes \
	--enable-nested-prototypes \
	--enable-wide-prototypes=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-x.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


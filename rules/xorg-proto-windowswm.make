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
PACKAGES-$(PTXCONF_XORG_PROTO_WINDOWSWM) += xorg-proto-windowswm

#
# Paths and names
#
XORG_PROTO_WINDOWSWM_VERSION 	:= 1.0.4
XORG_PROTO_WINDOWSWM_MD5	:= e74b2ff3172a6117f2a62b655ef99064
XORG_PROTO_WINDOWSWM		:= windowswmproto-$(XORG_PROTO_WINDOWSWM_VERSION)
XORG_PROTO_WINDOWSWM_SUFFIX	:= tar.bz2
XORG_PROTO_WINDOWSWM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_WINDOWSWM).$(XORG_PROTO_WINDOWSWM_SUFFIX)
XORG_PROTO_WINDOWSWM_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_WINDOWSWM).$(XORG_PROTO_WINDOWSWM_SUFFIX)
XORG_PROTO_WINDOWSWM_DIR	:= $(BUILDDIR)/$(XORG_PROTO_WINDOWSWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_WINDOWSWM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_WINDOWSWM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_WINDOWSWM_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_WINDOWSWM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_WINDOWSWM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-windowswm.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


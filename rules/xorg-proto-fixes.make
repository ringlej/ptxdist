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
PACKAGES-$(PTXCONF_XORG_PROTO_FIXES) += xorg-proto-fixes

#
# Paths and names
#
XORG_PROTO_FIXES_VERSION	:= 4.1.2
XORG_PROTO_FIXES_MD5		:= bdb58ecc313b509247036d5c11fa99df
XORG_PROTO_FIXES		:= fixesproto-$(XORG_PROTO_FIXES_VERSION)
XORG_PROTO_FIXES_SUFFIX		:= tar.bz2
XORG_PROTO_FIXES_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX)
XORG_PROTO_FIXES_SOURCE		:= $(SRCDIR)/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX)
XORG_PROTO_FIXES_DIR		:= $(BUILDDIR)/$(XORG_PROTO_FIXES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_FIXES_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_FIXES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_FIXES_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_FIXES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_FIXES_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-fixes.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


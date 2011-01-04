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
PACKAGES-$(PTXCONF_XORG_PROTO_SCRNSAVER) += xorg-proto-scrnsaver

#
# Paths and names
#
XORG_PROTO_SCRNSAVER_VERSION 	:= 1.2.1
XORG_PROTO_SCRNSAVER		:= scrnsaverproto-$(XORG_PROTO_SCRNSAVER_VERSION)
XORG_PROTO_SCRNSAVER_SUFFIX	:= tar.bz2
XORG_PROTO_SCRNSAVER_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX)
XORG_PROTO_SCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX)
XORG_PROTO_SCRNSAVER_DIR	:= $(BUILDDIR)/$(XORG_PROTO_SCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_SCRNSAVER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_SCRNSAVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_SCRNSAVER_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_SCRNSAVER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_SCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-scrnsaver.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make


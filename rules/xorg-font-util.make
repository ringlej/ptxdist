# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
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
PACKAGES-$(PTXCONF_XORG_FONT_UTIL) += xorg-font-util

#
# Paths and names
#
XORG_FONT_UTIL_VERSION	:= 1.1.1
XORG_FONT_UTIL		:= font-util-$(XORG_FONT_UTIL_VERSION)
XORG_FONT_UTIL_SUFFIX	:= tar.bz2
XORG_FONT_UTIL_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX)
XORG_FONT_UTIL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX)
XORG_FONT_UTIL_DIR	:= $(BUILDDIR)/$(XORG_FONT_UTIL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_UTIL_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_UTIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_UTIL_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_UTIL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_UTIL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-util.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

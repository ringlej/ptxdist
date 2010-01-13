# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
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
PACKAGES-$(PTXCONF_XORG_DATA_XBITMAPS) += xorg-data-xbitmaps

#
# Paths and names
#
XORG_DATA_XBITMAPS_VERSION	:= 1.1.0
XORG_DATA_XBITMAPS		:= xbitmaps-$(XORG_DATA_XBITMAPS_VERSION)
XORG_DATA_XBITMAPS_SUFFIX	:= tar.bz2
XORG_DATA_XBITMAPS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX)
XORG_DATA_XBITMAPS_SOURCE	:= $(SRCDIR)/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX)
XORG_DATA_XBITMAPS_DIR		:= $(BUILDDIR)/$(XORG_DATA_XBITMAPS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DATA_XBITMAPS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DATA_XBITMAPS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DATA_XBITMAPS_PATH	:= PATH=$(CROSS_PATH)
XORG_DATA_XBITMAPS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DATA_XBITMAPS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-data-xbitmaps.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

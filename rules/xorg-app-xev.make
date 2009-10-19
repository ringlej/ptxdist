# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XEV) += xorg-app-xev

#
# Paths and names
#
XORG_APP_XEV_VERSION	:= 1.0.4
XORG_APP_XEV		:= xev-$(XORG_APP_XEV_VERSION)
XORG_APP_XEV_SUFFIX	:= tar.bz2
XORG_APP_XEV_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XEV).$(XORG_APP_XEV_SUFFIX)
XORG_APP_XEV_SOURCE	:= $(SRCDIR)/$(XORG_APP_XEV).$(XORG_APP_XEV_SUFFIX)
XORG_APP_XEV_DIR	:= $(BUILDDIR)/$(XORG_APP_XEV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XEV_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XEV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XEV_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XEV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XEV_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xev.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-app-xev)
	@$(call install_fixup, xorg-app-xev,PACKAGE,xorg-app-xev)
	@$(call install_fixup, xorg-app-xev,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xev,VERSION,$(XORG_APP_XEV_VERSION))
	@$(call install_fixup, xorg-app-xev,SECTION,base)
	@$(call install_fixup, xorg-app-xev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-app-xev,DEPENDS,)
	@$(call install_fixup, xorg-app-xev,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xev, 0, 0, 0755, -, /usr/bin/xev)

	@$(call install_finish, xorg-app-xev)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xev_clean:
	rm -rf $(STATEDIR)/xorg-app-xev.*
	rm -rf $(PKGDIR)/xorg-app-xev_*
	rm -rf $(XORG_APP_XEV_DIR)

# vim: syntax=make

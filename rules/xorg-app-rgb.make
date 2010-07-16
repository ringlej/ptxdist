# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_RGB) += xorg-app-rgb

#
# Paths and names
#
XORG_APP_RGB_VERSION	:= 1.0.3
XORG_APP_RGB		:= rgb-$(XORG_APP_RGB_VERSION)
XORG_APP_RGB_SUFFIX	:= tar.bz2
XORG_APP_RGB_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_RGB).$(XORG_APP_RGB_SUFFIX)
XORG_APP_RGB_SOURCE	:= $(SRCDIR)/$(XORG_APP_RGB).$(XORG_APP_RGB_SUFFIX)
XORG_APP_RGB_DIR	:= $(BUILDDIR)/$(XORG_APP_RGB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_RGB_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_RGB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_RGB_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_RGB_ENV 	:= $(CROSS_ENV)

#
# autoconf
# FIXME: importance of switch
#   --with-rgb-db-type=(text|dbm|ndbm) rgb database type (default is text)
#
XORG_APP_RGB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-rgb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-rgb)
	@$(call install_fixup,xorg-app-rgb,PRIORITY,optional)
	@$(call install_fixup,xorg-app-rgb,SECTION,base)
	@$(call install_fixup,xorg-app-rgb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-app-rgb,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-rgb, 0, 0, 0644, -, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/rgb.txt, n)

	@$(call install_finish,xorg-app-rgb)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_MKFONTSCALE) += xorg-app-mkfontscale

#
# Paths and names
#
XORG_APP_MKFONTSCALE_VERSION	:= 1.0.8
XORG_APP_MKFONTSCALE		:= mkfontscale-$(XORG_APP_MKFONTSCALE_VERSION)
XORG_APP_MKFONTSCALE_SUFFIX	:= tar.bz2
XORG_APP_MKFONTSCALE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_MKFONTSCALE).$(XORG_APP_MKFONTSCALE_SUFFIX)
XORG_APP_MKFONTSCALE_SOURCE	:= $(SRCDIR)/$(XORG_APP_MKFONTSCALE).$(XORG_APP_MKFONTSCALE_SUFFIX)
XORG_APP_MKFONTSCALE_DIR	:= $(BUILDDIR)/$(XORG_APP_MKFONTSCALE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_MKFONTSCALE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_MKFONTSCALE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_MKFONTSCALE_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_MKFONTSCALE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_MKFONTSCALE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-mkfontscale.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-mkfontscale)
	@$(call install_fixup, xorg-app-mkfontscale,PRIORITY,optional)
	@$(call install_fixup, xorg-app-mkfontscale,SECTION,base)
	@$(call install_fixup, xorg-app-mkfontscale,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-mkfontscale,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-mkfontscale, 0, 0, 0755, -, \
		/usr/bin/mkfontscale)

	@$(call install_finish, xorg-app-mkfontscale)

	@$(call touch)

# vim: syntax=make

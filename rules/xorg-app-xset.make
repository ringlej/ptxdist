# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XSET) += xorg-app-xset

#
# Paths and names
#
XORG_APP_XSET_VERSION	:= 1.1.0
XORG_APP_XSET		:= xset-$(XORG_APP_XSET_VERSION)
XORG_APP_XSET_SUFFIX	:= tar.bz2
XORG_APP_XSET_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX)
XORG_APP_XSET_SOURCE	:= $(SRCDIR)/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX)
XORG_APP_XSET_DIR	:= $(BUILDDIR)/$(XORG_APP_XSET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XSET_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XSET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XSET_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XSET_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XSET_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xset.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xset)
	@$(call install_fixup,xorg-app-xset,PACKAGE,xorg-app-xset)
	@$(call install_fixup,xorg-app-xset,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xset,VERSION,$(XORG_APP_XSET_VERSION))
	@$(call install_fixup,xorg-app-xset,SECTION,base)
	@$(call install_fixup,xorg-app-xset,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-app-xset,DEPENDS,)
	@$(call install_fixup,xorg-app-xset,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xset, 0, 0, 0755, -, /usr/bin/xset)

	@$(call install_finish,xorg-app-xset)

	@$(call touch)

# vim: syntax=make

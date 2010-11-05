# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#               2010 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XPROP) += xorg-app-xprop

#
# Paths and names
#
XORG_APP_XPROP_VERSION	:= 1.2.0
XORG_APP_XPROP		:= xprop-$(XORG_APP_XPROP_VERSION)
XORG_APP_XPROP_SUFFIX	:= tar.bz2
XORG_APP_XPROP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XPROP).$(XORG_APP_XPROP_SUFFIX)
XORG_APP_XPROP_SOURCE	:= $(SRCDIR)/$(XORG_APP_XPROP).$(XORG_APP_XPROP_SUFFIX)
XORG_APP_XPROP_DIR	:= $(BUILDDIR)/$(XORG_APP_XPROP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XPROP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xprop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xprop)
	@$(call install_fixup, xorg-app-xprop,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xprop,SECTION,base)
	@$(call install_fixup, xorg-app-xprop,AUTHOR,"george.mccollister@gmail.com>")
	@$(call install_fixup, xorg-app-xprop,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xprop, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xprop)

	@$(call install_finish, xorg-app-xprop)

	@$(call touch)

# vim: syntax=make

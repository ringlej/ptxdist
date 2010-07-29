# -*-makefile-*-
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
PACKAGES-$(PTXCONF_XORG_APP_XRANDR) += xorg-app-xrandr

#
# Paths and names
#
XORG_APP_XRANDR_VERSION	:= 1.3.3
XORG_APP_XRANDR		:= xrandr-$(XORG_APP_XRANDR_VERSION)
XORG_APP_XRANDR_SUFFIX	:= tar.bz2
XORG_APP_XRANDR_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XRANDR).$(XORG_APP_XRANDR_SUFFIX)
XORG_APP_XRANDR_SOURCE	:= $(SRCDIR)/$(XORG_APP_XRANDR).$(XORG_APP_XRANDR_SUFFIX)
XORG_APP_XRANDR_DIR	:= $(BUILDDIR)/$(XORG_APP_XRANDR)
XORG_APP_XRANDR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XRANDR_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XRANDR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XRANDR_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XRANDR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XRANDR_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xrandr.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-app-xrandr)
	@$(call install_fixup, xorg-app-xrandr,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xrandr,SECTION,base)
	@$(call install_fixup, xorg-app-xrandr,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-app-xrandr,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xrandr, 0, 0, 0755, -, \
		/usr/bin/xrandr)
	@$(call install_copy, xorg-app-xrandr, 0, 0, 0755, -, \
		/usr/bin/xkeystone)

	@$(call install_finish, xorg-app-xrandr)

	@$(call touch)

# vim: syntax=make

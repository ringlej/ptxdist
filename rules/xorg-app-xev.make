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
PACKAGES-$(PTXCONF_XORG_APP_XEV) += xorg-app-xev

#
# Paths and names
#
XORG_APP_XEV_VERSION	:= 1.2.0
XORG_APP_XEV_MD5	:= 2727c72f3eba0c23f8f6b2e618d195a2
XORG_APP_XEV		:= xev-$(XORG_APP_XEV_VERSION)
XORG_APP_XEV_SUFFIX	:= tar.bz2
XORG_APP_XEV_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XEV).$(XORG_APP_XEV_SUFFIX))
XORG_APP_XEV_SOURCE	:= $(SRCDIR)/$(XORG_APP_XEV).$(XORG_APP_XEV_SUFFIX)
XORG_APP_XEV_DIR	:= $(BUILDDIR)/$(XORG_APP_XEV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XEV_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xev.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-app-xev)
	@$(call install_fixup, xorg-app-xev,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xev,SECTION,base)
	@$(call install_fixup, xorg-app-xev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-app-xev,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xev, 0, 0, 0755, -, /usr/bin/xev)

	@$(call install_finish, xorg-app-xev)

	@$(call touch)

# vim: syntax=make

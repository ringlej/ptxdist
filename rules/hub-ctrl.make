# -*-makefile-*-
#
# Copyright (C) 2014 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HUB_CTRL) += hub-ctrl

#
# Paths and names
#
HUB_CTRL_VERSION	:= 2014.07.0
HUB_CTRL_MD5		:= 6e00505d2888bca1646a1e388fcc1e0a
HUB_CTRL		:= hub-ctrl-$(HUB_CTRL_VERSION)
HUB_CTRL_SUFFIX		:= tar.bz2
HUB_CTRL_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HUB_CTRL).$(HUB_CTRL_SUFFIX)
HUB_CTRL_SOURCE		:= $(SRCDIR)/$(HUB_CTRL).$(HUB_CTRL_SUFFIX)
HUB_CTRL_DIR		:= $(BUILDDIR)/$(HUB_CTRL)
HUB_CTRL_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HUB_CTRL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hub-ctrl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hub-ctrl)
	@$(call install_fixup, hub-ctrl,PRIORITY,optional)
	@$(call install_fixup, hub-ctrl,SECTION,base)
	@$(call install_fixup, hub-ctrl,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, hub-ctrl,DESCRIPTION,missing)

	@$(call install_copy, hub-ctrl, 0, 0, 0755, -, /usr/bin/hub-ctrl)

	@$(call install_finish, hub-ctrl)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XHOST) += xorg-app-xhost

#
# Paths and names
#
XORG_APP_XHOST_VERSION	:= 1.0.5
XORG_APP_XHOST_MD5	:= a0fcd2cb6ddd9f378944cc6f4f83cd7c
XORG_APP_XHOST		:= xhost-$(XORG_APP_XHOST_VERSION)
XORG_APP_XHOST_SUFFIX	:= tar.bz2
XORG_APP_XHOST_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XHOST).$(XORG_APP_XHOST_SUFFIX))
XORG_APP_XHOST_SOURCE	:= $(SRCDIR)/$(XORG_APP_XHOST).$(XORG_APP_XHOST_SUFFIX)
XORG_APP_XHOST_DIR	:= $(BUILDDIR)/$(XORG_APP_XHOST)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XHOST_CONF_TOOL	:= autoconf
XORG_APP_XHOST_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR) \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_SECURE_RPC)-secure-rpc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xhost.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xhost)
	@$(call install_fixup, xorg-app-xhost,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xhost,SECTION,base)
	@$(call install_fixup, xorg-app-xhost,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xhost,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xhost, 0, 0, 0755, -, \
		 $(XORG_PREFIX)/bin/xhost)

	@$(call install_finish, xorg-app-xhost)

	@$(call touch)

# vim: syntax=make

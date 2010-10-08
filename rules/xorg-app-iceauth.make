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
PACKAGES-$(PTXCONF_XORG_APP_ICEAUTH) += xorg-app-iceauth

#
# Paths and names
#
XORG_APP_ICEAUTH_VERSION	:= 1.0.4
XORG_APP_ICEAUTH_MD5		:= bb2e4d2611047f7c5a1a82ec956a9de4
XORG_APP_ICEAUTH		:= iceauth-$(XORG_APP_ICEAUTH_VERSION)
XORG_APP_ICEAUTH_SUFFIX		:= tar.bz2
XORG_APP_ICEAUTH_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_ICEAUTH).$(XORG_APP_ICEAUTH_SUFFIX)
XORG_APP_ICEAUTH_SOURCE		:= $(SRCDIR)/$(XORG_APP_ICEAUTH).$(XORG_APP_ICEAUTH_SUFFIX)
XORG_APP_ICEAUTH_DIR		:= $(BUILDDIR)/$(XORG_APP_ICEAUTH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_ICEAUTH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-iceauth.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-iceauth)
	@$(call install_fixup, xorg-app-iceauth, PRIORITY, optional)
	@$(call install_fixup, xorg-app-iceauth, SECTION, base)
	@$(call install_fixup, xorg-app-iceauth, AUTHOR, "george.mccollister@gmail.com>")
	@$(call install_fixup, xorg-app-iceauth, DESCRIPTION, missing)

	@$(call install_copy, xorg-app-iceauth, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/iceauth)

	@$(call install_finish, xorg-app-iceauth)

	@$(call touch)

# vim: syntax=make

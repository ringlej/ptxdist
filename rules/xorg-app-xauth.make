# -*-makefile-*-
#
# Copyright (C) 2007 by cls@elaxys.com.br
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XAUTH) += xorg-app-xauth

#
# Paths and names
#
XORG_APP_XAUTH_VERSION	:= 1.0.7
XORG_APP_XAUTH_MD5	:= cbcbd8f2156a53b609800bec4c6b6c0e
XORG_APP_XAUTH		:= xauth-$(XORG_APP_XAUTH_VERSION)
XORG_APP_XAUTH_SUFFIX	:= tar.bz2
XORG_APP_XAUTH_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX))
XORG_APP_XAUTH_SOURCE	:= $(SRCDIR)/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX)
XORG_APP_XAUTH_DIR	:= $(BUILDDIR)/$(XORG_APP_XAUTH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XAUTH_CONF_TOOL	:= autoconf
XORG_APP_XAUTH_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xauth.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xauth)
	@$(call install_fixup, xorg-app-xauth,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xauth,SECTION,base)
	@$(call install_fixup, xorg-app-xauth,AUTHOR,"Claudio Leonel <cls@elaxys.com.br>")
	@$(call install_fixup, xorg-app-xauth,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xauth, 0, 0, 0755, -, /usr/bin/xauth)

	@$(call install_finish, xorg-app-xauth)

	@$(call touch)

# vim: syntax=make

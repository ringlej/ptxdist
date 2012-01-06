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
XORG_APP_XAUTH_VERSION	:= 1.0.5
XORG_APP_XAUTH_MD5	:= 46fc44e5e947d3720f3be5054044ff0e
XORG_APP_XAUTH		:= xauth-$(XORG_APP_XAUTH_VERSION)
XORG_APP_XAUTH_SUFFIX	:= tar.bz2
XORG_APP_XAUTH_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX))
XORG_APP_XAUTH_SOURCE	:= $(SRCDIR)/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX)
XORG_APP_XAUTH_DIR	:= $(BUILDDIR)/$(XORG_APP_XAUTH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XAUTH_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XAUTH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XAUTH_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XAUTH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XAUTH_AUTOCONF := \
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

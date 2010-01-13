# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XDM) += xorg-app-xdm

#
# Paths and names
#
XORG_APP_XDM_VERSION	:= 1.1.9
XORG_APP_XDM		:= xdm-$(XORG_APP_XDM_VERSION)
XORG_APP_XDM_SUFFIX	:= tar.bz2
XORG_APP_XDM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX)
XORG_APP_XDM_SOURCE	:= $(SRCDIR)/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX)
XORG_APP_XDM_DIR	:= $(BUILDDIR)/$(XORG_APP_XDM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XDM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XDM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XDM_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XDM_ENV 	:= $(CROSS_ENV)
XORG_APP_XDM_BINCONFIG_GLOB := ""

#
# autoconf
#
XORG_APP_XDM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR) \
	--disable-dependency-tracking \
	--with-random-device=$(XORG_APP_XDM_DEV_RANDOM) \
	--with-utmp-file=/var/run/utmp \
	--with-wtmp-file=/var/log/wtmp

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
XORG_APP_XDM_AUTOCONF += --enable-secure-rpc
else
XORG_APP_XDM_AUTOCONF += --disable-secure-rpc
endif

XORG_APP_XDM_AUTOCONF += --enable-xpm-logos	# Display xpm logos in greeter
XORG_APP_XDM_AUTOCONF += --disable-xprint	# FIXME XPrint support
XORG_APP_XDM_AUTOCONF += --enable-dynamic-greeter # Build greeter as dynamically loaded shared object
XORG_APP_XDM_AUTOCONF += --without-pam		# FXIME

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xdm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xdm)
	@$(call install_fixup, xorg-app-xdm,PACKAGE,xorg-app-xdm)
	@$(call install_fixup, xorg-app-xdm,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xdm,VERSION,$(XORG_APP_XDM_VERSION))
	@$(call install_fixup, xorg-app-xdm,SECTION,base)
	@$(call install_fixup, xorg-app-xdm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-app-xdm,DEPENDS,)
	@$(call install_fixup, xorg-app-xdm,DESCRIPTION,missing)

	@$(call install_finish, xorg-app-xdm)

	@$(call touch)

# vim: syntax=make

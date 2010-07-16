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
PACKAGES-$(PTXCONF_XORG_APP_SETXKBMAP) += xorg-app-setxkbmap

#
# Paths and names
#
XORG_APP_SETXKBMAP_VERSION	:= 1.1.0
XORG_APP_SETXKBMAP		:= setxkbmap-$(XORG_APP_SETXKBMAP_VERSION)
XORG_APP_SETXKBMAP_SUFFIX	:= tar.bz2
XORG_APP_SETXKBMAP_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app//$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX)
XORG_APP_SETXKBMAP_SOURCE	:= $(SRCDIR)/$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX)
XORG_APP_SETXKBMAP_DIR		:= $(BUILDDIR)/$(XORG_APP_SETXKBMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_SETXKBMAP_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_SETXKBMAP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_SETXKBMAP_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_SETXKBMAP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#

XORG_APP_SETXKBMAP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-setxkbmap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-setxkbmap)
	@$(call install_fixup, xorg-app-setxkbmap,PRIORITY,optional)
	@$(call install_fixup, xorg-app-setxkbmap,SECTION,base)
	@$(call install_fixup, xorg-app-setxkbmap,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-setxkbmap,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-setxkbmap,  0, 0, 0755, -, \
		/usr/bin/setxkbmap)

	@$(call install_finish, xorg-app-setxkbmap)

	@$(call touch)

# vim: syntax=make

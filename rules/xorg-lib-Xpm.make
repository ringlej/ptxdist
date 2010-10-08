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
PACKAGES-$(PTXCONF_XORG_LIB_XPM) += xorg-lib-xpm

#
# Paths and names
#
XORG_LIB_XPM_VERSION	:= 3.5.9
XORG_LIB_XPM_MD5	:= 2de3a1b9541f4b3a6f9d84b69d25530e
XORG_LIB_XPM		:= libXpm-$(XORG_LIB_XPM_VERSION)
XORG_LIB_XPM_SUFFIX	:= tar.bz2
XORG_LIB_XPM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX)
XORG_LIB_XPM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX)
XORG_LIB_XPM_DIR	:= $(BUILDDIR)/$(XORG_LIB_XPM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XPM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XPM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XPM_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XPM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xpm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xpm)
	@$(call install_fixup, xorg-lib-xpm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xpm,SECTION,base)
	@$(call install_fixup, xorg-lib-xpm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xpm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xpm, 0, 0, 0644, libXpm)

	@$(call install_finish, xorg-lib-xpm)

	@$(call touch)

# vim: syntax=make

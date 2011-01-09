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
PACKAGES-$(PTXCONF_XORG_LIB_XXF86DGA) += xorg-lib-xxf86dga

#
# Paths and names
#
XORG_LIB_XXF86DGA_VERSION	:= 1.1.2
XORG_LIB_XXF86DGA		:= libXxf86dga-$(XORG_LIB_XXF86DGA_VERSION)
XORG_LIB_XXF86DGA_SUFFIX	:= tar.bz2
XORG_LIB_XXF86DGA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XXF86DGA).$(XORG_LIB_XXF86DGA_SUFFIX)
XORG_LIB_XXF86DGA_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XXF86DGA).$(XORG_LIB_XXF86DGA_SUFFIX)
XORG_LIB_XXF86DGA_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86DGA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XXF86DGA_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XXF86DGA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XXF86DGA_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XXF86DGA_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XXF86DGA_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xxf86dga.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xxf86dga)
	@$(call install_fixup, xorg-lib-xxf86dga,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xxf86dga,SECTION,base)
	@$(call install_fixup, xorg-lib-xxf86dga,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xxf86dga,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xxf86dga, 0, 0, 0644, libXxf86dga)

	@$(call install_finish, xorg-lib-xxf86dga)

	@$(call touch)

# vim: syntax=make

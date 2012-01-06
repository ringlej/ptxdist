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
PACKAGES-$(PTXCONF_XORG_LIB_XXF86VM) += xorg-lib-xxf86vm

#
# Paths and names
#
XORG_LIB_XXF86VM_VERSION	:= 1.1.1
XORG_LIB_XXF86VM_MD5		:= 34dc3df888c164378da89a7deeb245a0
XORG_LIB_XXF86VM		:= libXxf86vm-$(XORG_LIB_XXF86VM_VERSION)
XORG_LIB_XXF86VM_SUFFIX		:= tar.bz2
XORG_LIB_XXF86VM_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX))
XORG_LIB_XXF86VM_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX)
XORG_LIB_XXF86VM_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86VM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XXF86VM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XXF86VM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XXF86VM_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XXF86VM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XXF86VM_AUTOCONF := $(CROSS_AUTOCONF_USR)
XORG_LIB_XXF86VM_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xxf86vm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xxf86vm)
	@$(call install_fixup, xorg-lib-xxf86vm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xxf86vm,SECTION,base)
	@$(call install_fixup, xorg-lib-xxf86vm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xxf86vm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xxf86vm, 0, 0, 0644, libXxf86vm)

	@$(call install_finish, xorg-lib-xxf86vm)

	@$(call touch)

# vim: syntax=make

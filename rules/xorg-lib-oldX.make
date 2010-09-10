# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_OLDX) += xorg-lib-oldx

#
# Paths and names
#
XORG_LIB_OLDX_VERSION	:= 1.0.1
XORG_LIB_OLDX		:= liboldX-$(XORG_LIB_OLDX_VERSION)
XORG_LIB_OLDX_SUFFIX	:= tar.bz2
XORG_LIB_OLDX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_DIR	:= $(BUILDDIR)/$(XORG_LIB_OLDX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_OLDX_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_OLDX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_OLDX_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_OLDX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_OLDX_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-oldx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-oldx)
	@$(call install_fixup, xorg-lib-oldx,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-oldx,SECTION,base)
	@$(call install_fixup, xorg-lib-oldx,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-oldx,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-oldx, 0, 0, 0644, liboldX)

	@$(call install_finish, xorg-lib-oldx)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XRES) += xorg-lib-xres

#
# Paths and names
#
XORG_LIB_XRES_VERSION	:= 1.0.5
XORG_LIB_XRES_MD5	:= d08f0b6df3f96c051637d37009f4e55a
XORG_LIB_XRES		:= libXres-$(XORG_LIB_XRES_VERSION)
XORG_LIB_XRES_SUFFIX	:= tar.bz2
XORG_LIB_XRES_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX))
XORG_LIB_XRES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XRES_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XRES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XRES_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XRES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRES_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XRES_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xres.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xres,SECTION,base)
	@$(call install_fixup, xorg-lib-xres,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xres,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xres, 0, 0, 0644, libXRes)

	@$(call install_finish, xorg-lib-xres)

	@$(call touch)

# vim: syntax=make

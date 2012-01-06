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
PACKAGES-$(PTXCONF_XORG_LIB_XEXT) += xorg-lib-xext

#
# Paths and names
#
XORG_LIB_XEXT_VERSION	:= 1.2.0
XORG_LIB_XEXT_MD5	:= 9bb236ff0193e9fc1c1fb504dd840331
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.bz2
XORG_LIB_XEXT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX))
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XEXT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XEXT_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XEXT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XEXT_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xext.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xext,SECTION,base)
	@$(call install_fixup, xorg-lib-xext,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xext,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xext, 0, 0, 0644, libXext)

	@$(call install_finish, xorg-lib-xext)

	@$(call touch)

# vim: syntax=make

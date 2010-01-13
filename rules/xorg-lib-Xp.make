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
PACKAGES-$(PTXCONF_XORG_LIB_XP) += xorg-lib-xp

#
# Paths and names
#
XORG_LIB_XP_VERSION	:= 1.0.0
XORG_LIB_XP		:= libXp-$(XORG_LIB_XP_VERSION)
XORG_LIB_XP_SUFFIX	:= tar.bz2
XORG_LIB_XP_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX)
XORG_LIB_XP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX)
XORG_LIB_XP_DIR		:= $(BUILDDIR)/$(XORG_LIB_XP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XP_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XP_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xp)
	@$(call install_fixup, xorg-lib-xp,PACKAGE,xorg-lib-xp)
	@$(call install_fixup, xorg-lib-xp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xp,VERSION,$(XORG_LIB_XP_VERSION))
	@$(call install_fixup, xorg-lib-xp,SECTION,base)
	@$(call install_fixup, xorg-lib-xp,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xp,DEPENDS,)
	@$(call install_fixup, xorg-lib-xp,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xp, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXp.so.6.2.0)

	@$(call install_link, xorg-lib-xp, \
		libXp.so.6.2.0, \
		$(XORG_LIBDIR)/libXp.so.6)

	@$(call install_link, xorg-lib-xp, \
		libXp.so.6.2.0, \
		$(XORG_LIBDIR)/libXp.so)

	@$(call install_finish, xorg-lib-xp)

	@$(call touch)

# vim: syntax=make

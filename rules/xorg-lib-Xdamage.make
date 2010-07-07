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
PACKAGES-$(PTXCONF_XORG_LIB_XDAMAGE) += xorg-lib-xdamage

#
# Paths and names
#
XORG_LIB_XDAMAGE_VERSION	:= 1.1.3
XORG_LIB_XDAMAGE		:= libXdamage-$(XORG_LIB_XDAMAGE_VERSION)
XORG_LIB_XDAMAGE_SUFFIX		:= tar.bz2
XORG_LIB_XDAMAGE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XDAMAGE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XDAMAGE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XDAMAGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XDAMAGE_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XDAMAGE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDAMAGE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xdamage.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-xdamage,PACKAGE,xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-xdamage,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdamage,VERSION,$(XORG_LIB_XDAMAGE_VERSION))
	@$(call install_fixup, xorg-lib-xdamage,SECTION,base)
	@$(call install_fixup, xorg-lib-xdamage,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdamage,DEPENDS,)
	@$(call install_fixup, xorg-lib-xdamage,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xdamage, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXdamage.so.1.1.0)

	@$(call install_link, xorg-lib-xdamage, \
		libXdamage.so.1.1.0, \
		$(XORG_LIBDIR)/libXdamage.so.1)

	@$(call install_link, xorg-lib-xdamage, \
		libXdamage.so.1.1.0, \
		$(XORG_LIBDIR)/libXdamage.so)

	@$(call install_finish, xorg-lib-xdamage)

	@$(call touch)

# vim: syntax=make

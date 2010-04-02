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
PACKAGES-$(PTXCONF_XORG_LIB_ICE) += xorg-lib-ice

#
# Paths and names
#
XORG_LIB_ICE_VERSION	:= 1.0.6
XORG_LIB_ICE		:= libICE-$(XORG_LIB_ICE_VERSION)
XORG_LIB_ICE_SUFFIX	:= tar.bz2
XORG_LIB_ICE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_DIR	:= $(BUILDDIR)/$(XORG_LIB_ICE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_ICE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_ICE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_ICE_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_ICE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_ICE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-ice.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PACKAGE,xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-ice,VERSION,$(XORG_LIB_ICE_VERSION))
	@$(call install_fixup, xorg-lib-ice,SECTION,base)
	@$(call install_fixup, xorg-lib-ice,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-ice,DEPENDS,)
	@$(call install_fixup, xorg-lib-ice,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-ice, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libICE.so.6.3.0)

	@$(call install_link, xorg-lib-ice, \
		libICE.so.6.3.0, \
		$(XORG_LIBDIR)/libICE.so.6)

	@$(call install_link, xorg-lib-ice, \
		libICE.so.6.3.0, \
		$(XORG_LIBDIR)/libICE.so)

	@$(call install_finish, xorg-lib-ice)

	@$(call touch)

# vim: syntax=make

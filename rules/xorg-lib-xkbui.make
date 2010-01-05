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
PACKAGES-$(PTXCONF_XORG_LIB_XKBUI) += xorg-lib-xkbui

#
# Paths and names
#
XORG_LIB_XKBUI_VERSION	:= 1.0.2
XORG_LIB_XKBUI		:= libxkbui-$(XORG_LIB_XKBUI_VERSION)
XORG_LIB_XKBUI_SUFFIX	:= tar.bz2
XORG_LIB_XKBUI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XKBUI).$(XORG_LIB_XKBUI_SUFFIX)
XORG_LIB_XKBUI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XKBUI).$(XORG_LIB_XKBUI_SUFFIX)
XORG_LIB_XKBUI_DIR	:= $(BUILDDIR)/$(XORG_LIB_XKBUI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XKBUI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XKBUI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XKBUI_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XKBUI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XKBUI_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xkbui.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xkbui)
	@$(call install_fixup, xorg-lib-xkbui,PACKAGE,xorg-lib-xkbui)
	@$(call install_fixup, xorg-lib-xkbui,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xkbui,VERSION,$(XORG_LIB_XKBUI_VERSION))
	@$(call install_fixup, xorg-lib-xkbui,SECTION,base)
	@$(call install_fixup, xorg-lib-xkbui,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xkbui,DEPENDS,)
	@$(call install_fixup, xorg-lib-xkbui,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xkbui, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libxkbui.so.1.0.0)

	@$(call install_link, xorg-lib-xkbui, \
		libxkbui.so.1.0.0, \
		$(XORG_LIBDIR)/libxkbui.so.1)

	@$(call install_link, xorg-lib-xkbui, \
		libxkbui.so.1.0.0, \
		$(XORG_LIBDIR)/libxkbui.so)

	@$(call install_finish, xorg-lib-xkbui)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xkbui_clean:
	rm -rf $(STATEDIR)/xorg-lib-xkbui.*
	rm -rf $(PKGDIR)/xorg-lib-xkbui_*
	rm -rf $(XORG_LIB_XKBUI_DIR)

# vim: syntax=make

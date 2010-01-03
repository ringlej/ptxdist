# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
XORG_LIB_XPM_VERSION	:= 3.5.8
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

xorg-lib-xpm_prepare: $(STATEDIR)/xorg-lib-xpm.prepare

XORG_LIB_XPM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XPM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xpm.targetinstall: $(xorg-lib-xpm_targetinstall_deps_default)
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xpm)
	@$(call install_fixup, xorg-lib-xpm,PACKAGE,xorg-lib-xpm)
	@$(call install_fixup, xorg-lib-xpm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xpm,VERSION,$(XORG_LIB_XPM_VERSION))
	@$(call install_fixup, xorg-lib-xpm,SECTION,base)
	@$(call install_fixup, xorg-lib-xpm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xpm,DEPENDS,)
	@$(call install_fixup, xorg-lib-xpm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xpm, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXpm.so.4.11.0)

	@$(call install_link, xorg-lib-xpm, \
		libXpm.so.4.11.0, \
		$(XORG_LIBDIR)/libXpm.so.4)

	@$(call install_link, xorg-lib-xpm, \
		libXpm.so.4.11.0, \
		$(XORG_LIBDIR)/libXpm.so)

	@$(call install_finish, xorg-lib-xpm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xpm_clean:
	rm -rf $(STATEDIR)/xorg-lib-xpm.*
	rm -rf $(PKGDIR)/xorg-lib-xpm_*
	rm -rf $(XORG_LIB_XPM_DIR)

# vim: syntax=make

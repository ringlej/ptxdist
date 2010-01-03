# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XSETROOT) += xorg-app-xsetroot

#
# Paths and names
#
XORG_APP_XSETROOT_VERSION	:= 1.0.3
XORG_APP_XSETROOT		:= xsetroot-$(XORG_APP_XSETROOT_VERSION)
XORG_APP_XSETROOT_SUFFIX	:= tar.bz2
XORG_APP_XSETROOT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XSETROOT).$(XORG_APP_XSETROOT_SUFFIX)
XORG_APP_XSETROOT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XSETROOT).$(XORG_APP_XSETROOT_SUFFIX)
XORG_APP_XSETROOT_DIR		:= $(BUILDDIR)/$(XORG_APP_XSETROOT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XSETROOT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XSETROOT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XSETROOT_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XSETROOT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XSETROOT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xsetroot.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xsetroot)
	@$(call install_fixup,xorg-app-xsetroot,PACKAGE,xorg-app-xsetroot)
	@$(call install_fixup,xorg-app-xsetroot,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xsetroot,VERSION,$(XORG_APP_XSETROOT_VERSION))
	@$(call install_fixup,xorg-app-xsetroot,SECTION,base)
	@$(call install_fixup,xorg-app-xsetroot,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-app-xsetroot,DEPENDS,)
	@$(call install_fixup,xorg-app-xsetroot,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xsetroot, 0, 0, 0755, -, \
		$(XORG_BINDIR)/xsetroot)

	@$(call install_finish,xorg-app-xsetroot)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xsetroot_clean:
	rm -rf $(STATEDIR)/xorg-app-xsetroot.*
	rm -rf $(PKGDIR)/xorg-app-xsetroot_*
	rm -rf $(XORG_APP_XSETROOT_DIR)

# vim: syntax=make

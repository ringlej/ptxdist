# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XVMC) += xorg-lib-xvmc

#
# Paths and names
#
XORG_LIB_XVMC_VERSION	:= 1.0.5
XORG_LIB_XVMC		:= libXvMC-$(XORG_LIB_XVMC_VERSION)
XORG_LIB_XVMC_SUFFIX	:= tar.bz2
XORG_LIB_XVMC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX)
XORG_LIB_XVMC_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX)
XORG_LIB_XVMC_DIR	:= $(BUILDDIR)/$(XORG_LIB_XVMC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XVMC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XVMC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XVMC_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XVMC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XVMC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xvmc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xvmc)
	@$(call install_fixup, xorg-lib-xvmc,PACKAGE,xorg-lib-xvmc)
	@$(call install_fixup, xorg-lib-xvmc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xvmc,VERSION,$(XORG_LIB_XVMC_VERSION))
	@$(call install_fixup, xorg-lib-xvmc,SECTION,base)
	@$(call install_fixup, xorg-lib-xvmc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xvmc,DEPENDS,)
	@$(call install_fixup, xorg-lib-xvmc,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xvmc, 0, 0, 0644, -, \
		/usr/lib/libXvMC.so.1.0.0)
	@$(call install_link, xorg-lib-xvmc, \
		libXvMC.so.1.0.0, /usr/lib/libXvMC.so.1)
	@$(call install_link, xorg-lib-xvmc, \
		libXvMC.so.1.0.0, /usr/lib/libXvMC.so)

	@$(call install_copy, xorg-lib-xvmc, 0, 0, 0644, -, \
		/usr/lib/libXvMCW.so.1.0.0)
	@$(call install_link, xorg-lib-xvmc, \
		libXvMCW.so.1.0.0, /usr/lib/libXvMCW.so.1)
	@$(call install_link, xorg-lib-xvmc, \
		libXvMCW.so.1.0.0, /usr/lib/libXvMCW.so)

	@$(call install_finish, xorg-lib-xvmc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xvmc_clean:
	rm -rf $(STATEDIR)/xorg-lib-xvmc.*
	rm -rf $(PKGDIR)/xorg-lib-xvmc_*
	rm -rf $(XORG_LIB_XVMC_DIR)

# vim: syntax=make

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
XORG_LIB_XVMC_VERSION	:= 1.0.6
XORG_LIB_XVMC_MD5	:= bfc7524646f890dfc30dea1d676004a3
XORG_LIB_XVMC		:= libXvMC-$(XORG_LIB_XVMC_VERSION)
XORG_LIB_XVMC_SUFFIX	:= tar.bz2
XORG_LIB_XVMC_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX))
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
	@$(call install_fixup, xorg-lib-xvmc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xvmc,SECTION,base)
	@$(call install_fixup, xorg-lib-xvmc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xvmc,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xvmc, 0, 0, 0644, libXvMC)
	@$(call install_lib, xorg-lib-xvmc, 0, 0, 0644, libXvMCW)

	@$(call install_finish, xorg-lib-xvmc)

	@$(call touch)

# vim: syntax=make

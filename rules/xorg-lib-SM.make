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
PACKAGES-$(PTXCONF_XORG_LIB_SM) += xorg-lib-sm

#
# Paths and names
#
XORG_LIB_SM_VERSION	:= 1.1.1
XORG_LIB_SM		:= libSM-$(XORG_LIB_SM_VERSION)
XORG_LIB_SM_SUFFIX	:= tar.bz2
XORG_LIB_SM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_DIR		:= $(BUILDDIR)/$(XORG_LIB_SM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_SM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_SM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_SM_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_SM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_SM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--with-libuuid=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-sm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-sm,SECTION,base)
	@$(call install_fixup, xorg-lib-sm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-sm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-sm, 0, 0, 0644, libSM)

	@$(call install_finish, xorg-lib-sm)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_APP_XKBCOMP) += xorg-app-xkbcomp

#
# Paths and names
#
XORG_APP_XKBCOMP_VERSION	:= 1.1.1
XORG_APP_XKBCOMP		:= xkbcomp-$(XORG_APP_XKBCOMP_VERSION)
XORG_APP_XKBCOMP_SUFFIX		:= tar.bz2
XORG_APP_XKBCOMP_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app//$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_SOURCE		:= $(SRCDIR)/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_DIR		:= $(BUILDDIR)/$(XORG_APP_XKBCOMP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XKBCOMP_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XKBCOMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XKBCOMP_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XKBCOMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#

XORG_APP_XKBCOMP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xkbcomp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PACKAGE,xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xkbcomp,VERSION,$(XORG_APP_XKBCOMP_VERSION))
	@$(call install_fixup, xorg-app-xkbcomp,SECTION,base)
	@$(call install_fixup, xorg-app-xkbcomp,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-xkbcomp,DEPENDS,)
	@$(call install_fixup, xorg-app-xkbcomp,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xkbcomp,  0, 0, 0755, -, \
		/usr/bin/xkbcomp)

	@$(call install_finish, xorg-app-xkbcomp)

	@$(call touch)

# vim: syntax=make

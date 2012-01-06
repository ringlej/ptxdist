# -*-makefile-*-
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
XORG_APP_XSETROOT_VERSION	:= 1.1.0
XORG_APP_XSETROOT_MD5		:= b78a2da4cf128775031a5a3422fc0b78
XORG_APP_XSETROOT		:= xsetroot-$(XORG_APP_XSETROOT_VERSION)
XORG_APP_XSETROOT_SUFFIX	:= tar.bz2
XORG_APP_XSETROOT_URL		:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XSETROOT).$(XORG_APP_XSETROOT_SUFFIX))
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

XORG_APP_XSETROOT_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XSETROOT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XSETROOT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xsetroot.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xsetroot)
	@$(call install_fixup, xorg-app-xsetroot,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xsetroot,SECTION,base)
	@$(call install_fixup, xorg-app-xsetroot,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xsetroot,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xsetroot, 0, 0, 0755, -, \
		$(XORG_BINDIR)/xsetroot)

	@$(call install_finish, xorg-app-xsetroot)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XSCRNSAVER) += xorg-lib-xscrnsaver

#
# Paths and names
#
XORG_LIB_XSCRNSAVER_VERSION	:= 1.2.1
XORG_LIB_XSCRNSAVER_MD5		:= 898794bf6812fc9be9bf1bb7aa4d2b08
XORG_LIB_XSCRNSAVER		:= libXScrnSaver-$(XORG_LIB_XSCRNSAVER_VERSION)
XORG_LIB_XSCRNSAVER_SUFFIX	:= tar.bz2
XORG_LIB_XSCRNSAVER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XSCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XSCRNSAVER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XSCRNSAVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XSCRNSAVER_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XSCRNSAVER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XSCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xscrnsaver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xscrnsaver,SECTION,base)
	@$(call install_fixup, xorg-lib-xscrnsaver,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xscrnsaver,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xscrnsaver, 0, 0, 0644, libXss)

	@$(call install_finish, xorg-lib-xscrnsaver)

	@$(call touch)

# vim: syntax=make

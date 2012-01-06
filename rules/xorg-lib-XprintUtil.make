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
PACKAGES-$(PTXCONF_XORG_LIB_XPRINTUTIL) += xorg-lib-xprintutil

#
# Paths and names
#
XORG_LIB_XPRINTUTIL_VERSION	:= 1.0.1
XORG_LIB_XPRINTUTIL_MD5		:= 22584f1aab1deba253949b562d1f0f45
XORG_LIB_XPRINTUTIL		:= libXprintUtil-$(XORG_LIB_XPRINTUTIL_VERSION)
XORG_LIB_XPRINTUTIL_SUFFIX	:= tar.bz2
XORG_LIB_XPRINTUTIL_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XPRINTUTIL).$(XORG_LIB_XPRINTUTIL_SUFFIX))
XORG_LIB_XPRINTUTIL_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPRINTUTIL).$(XORG_LIB_XPRINTUTIL_SUFFIX)
XORG_LIB_XPRINTUTIL_DIR		:= $(BUILDDIR)/$(XORG_LIB_XPRINTUTIL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XPRINTUTIL_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XPRINTUTIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XPRINTUTIL_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XPRINTUTIL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPRINTUTIL_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xprintutil.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xprintutil)
	@$(call install_fixup, xorg-lib-xprintutil,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xprintutil,SECTION,base)
	@$(call install_fixup, xorg-lib-xprintutil,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xprintutil,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xprintutil, 0, 0, 0644, libXprintUtil)

	@$(call install_finish, xorg-lib-xprintutil)

	@$(call touch)

# vim: syntax=make

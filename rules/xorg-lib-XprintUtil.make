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
PACKAGES-$(PTXCONF_XORG_LIB_XPRINTUTIL) += xorg-lib-xprintutil

#
# Paths and names
#
XORG_LIB_XPRINTUTIL_VERSION	:= 1.0.1
XORG_LIB_XPRINTUTIL		:= libXprintUtil-$(XORG_LIB_XPRINTUTIL_VERSION)
XORG_LIB_XPRINTUTIL_SUFFIX	:= tar.bz2
XORG_LIB_XPRINTUTIL_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XPRINTUTIL).$(XORG_LIB_XPRINTUTIL_SUFFIX)
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

XORG_LIB_XPRINTUTIL_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XPRINTUTIL_ENV 	:=  $(CROSS_ENV)

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
	@$(call install_fixup, xorg-lib-xprintutil,PACKAGE,xorg-lib-xprintutil)
	@$(call install_fixup, xorg-lib-xprintutil,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xprintutil,VERSION,$(XORG_LIB_XPRINTUTIL_VERSION))
	@$(call install_fixup, xorg-lib-xprintutil,SECTION,base)
	@$(call install_fixup, xorg-lib-xprintutil,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xprintutil,DEPENDS,)
	@$(call install_fixup, xorg-lib-xprintutil,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xprintutil, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXprintUtil.so.1.0.0)

	@$(call install_link, xorg-lib-xprintutil, \
		libXprintUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintUtil.so.1)

	@$(call install_link, xorg-lib-xprintutil, \
		libXprintUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintUtil.so)

	@$(call install_finish, xorg-lib-xprintutil)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_clean:
	rm -rf $(STATEDIR)/xorg-lib-xprintutil.*
	rm -rf $(PKGDIR)/xorg-lib-xprintutil_*
	rm -rf $(XORG_LIB_XPRINTUTIL_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XV) += xorg-lib-xv

#
# Paths and names
#
XORG_LIB_XV_VERSION	:= 1.0.5
XORG_LIB_XV		:= libXv-$(XORG_LIB_XV_VERSION)
XORG_LIB_XV_SUFFIX	:= tar.bz2
XORG_LIB_XV_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_DIR		:= $(BUILDDIR)/$(XORG_LIB_XV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XV_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XV_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xv)
	@$(call install_fixup, xorg-lib-xv,PACKAGE,xorg-lib-xv)
	@$(call install_fixup, xorg-lib-xv,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xv,VERSION,$(XORG_LIB_XV_VERSION))
	@$(call install_fixup, xorg-lib-xv,SECTION,base)
	@$(call install_fixup, xorg-lib-xv,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xv,DEPENDS,)
	@$(call install_fixup, xorg-lib-xv,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xv, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXv.so.1.0.0)

	@$(call install_link, xorg-lib-xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so.1)

	@$(call install_link, xorg-lib-xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so)

	@$(call install_finish, xorg-lib-xv)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xv_clean:
	rm -rf $(STATEDIR)/xorg-lib-xv.*
	rm -rf $(PKGDIR)/xorg-lib-xv_*
	rm -rf $(XORG_LIB_XV_DIR)

# vim: syntax=make

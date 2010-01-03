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
PACKAGES-$(PTXCONF_XORG_LIB_XEXT) += xorg-lib-xext

#
# Paths and names
#
XORG_LIB_XEXT_VERSION	:= 1.1.1
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.bz2
XORG_LIB_XEXT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XEXT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xext_prepare: $(STATEDIR)/xorg-lib-xext.prepare

XORG_LIB_XEXT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XEXT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XEXT_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xext.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PACKAGE,xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xext,VERSION,$(XORG_LIB_XEXT_VERSION))
	@$(call install_fixup, xorg-lib-xext,SECTION,base)
	@$(call install_fixup, xorg-lib-xext,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xext,DEPENDS,)
	@$(call install_fixup, xorg-lib-xext,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xext, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXext.so.6.4.0)

	@$(call install_link, xorg-lib-xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so.6)

	@$(call install_link, xorg-lib-xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so)

	@$(call install_finish, xorg-lib-xext)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xext_clean:
	rm -rf $(STATEDIR)/xorg-lib-xext.*
	rm -rf $(PKGDIR)/xorg-lib-xext_*
	rm -rf $(XORG_LIB_XEXT_DIR)

# vim: syntax=make

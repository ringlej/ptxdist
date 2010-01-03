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
PACKAGES-$(PTXCONF_XORG_LIB_XCURSOR) += xorg-lib-xcursor

#
# Paths and names
#
XORG_LIB_XCURSOR_VERSION	:= 1.1.10
XORG_LIB_XCURSOR		:= libXcursor-$(XORG_LIB_XCURSOR_VERSION)
XORG_LIB_XCURSOR_SUFFIX		:= tar.bz2
XORG_LIB_XCURSOR_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCURSOR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XCURSOR_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XCURSOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XCURSOR_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCURSOR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCURSOR_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xcursor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-xcursor,PACKAGE,xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-xcursor,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xcursor,VERSION,$(XORG_LIB_XCURSOR_VERSION))
	@$(call install_fixup, xorg-lib-xcursor,SECTION,base)
	@$(call install_fixup, xorg-lib-xcursor,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xcursor,DEPENDS,)
	@$(call install_fixup, xorg-lib-xcursor,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xcursor, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXcursor.so.1.0.2)

	@$(call install_link, xorg-lib-xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so.1)

	@$(call install_link, xorg-lib-xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so)

	@$(call install_finish, xorg-lib-xcursor)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xcursor_clean:
	rm -rf $(STATEDIR)/xorg-lib-xcursor.*
	rm -rf $(PKGDIR)/xorg-lib-xcursor_*
	rm -rf $(XORG_LIB_XCURSOR_DIR)

# vim: syntax=make

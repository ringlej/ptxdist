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
PACKAGES-$(PTXCONF_XORG_LIB_FONTENC) += xorg-lib-fontenc

#
# Paths and names
#
XORG_LIB_FONTENC_VERSION	:= 1.0.5
XORG_LIB_FONTENC		:= libfontenc-$(XORG_LIB_FONTENC_VERSION)
XORG_LIB_FONTENC_SUFFIX		:= tar.bz2
XORG_LIB_FONTENC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX)
XORG_LIB_FONTENC_SOURCE		:= $(SRCDIR)/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX)
XORG_LIB_FONTENC_DIR		:= $(BUILDDIR)/$(XORG_LIB_FONTENC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_FONTENC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_FONTENC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_FONTENC_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_FONTENC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_FONTENC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-fontenc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-fontenc)
	@$(call install_fixup, xorg-lib-fontenc,PACKAGE,xorg-lib-fontenc)
	@$(call install_fixup, xorg-lib-fontenc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fontenc,VERSION,$(XORG_LIB_FONTENC_VERSION))
	@$(call install_fixup, xorg-lib-fontenc,SECTION,base)
	@$(call install_fixup, xorg-lib-fontenc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fontenc,DEPENDS,)
	@$(call install_fixup, xorg-lib-fontenc,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-fontenc, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libfontenc.so.1.0.0)

	@$(call install_link, xorg-lib-fontenc, \
		libfontenc.so.1.0.0, \
		$(XORG_LIBDIR)/libfontenc.so.1)

	@$(call install_link, xorg-lib-fontenc, \
		libfontenc.so.1.0.0, \
		$(XORG_LIBDIR)/libfontenc.so)

	@$(call install_finish, xorg-lib-fontenc)

	@$(call touch)

# vim: syntax=make

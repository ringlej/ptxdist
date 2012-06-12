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
XORG_LIB_FONTENC_VERSION	:= 1.1.1
XORG_LIB_FONTENC_MD5		:= a2a861f142c3b4367f14fc14239fc1f7
XORG_LIB_FONTENC		:= libfontenc-$(XORG_LIB_FONTENC_VERSION)
XORG_LIB_FONTENC_SUFFIX		:= tar.bz2
XORG_LIB_FONTENC_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX))
XORG_LIB_FONTENC_SOURCE		:= $(SRCDIR)/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX)
XORG_LIB_FONTENC_DIR		:= $(BUILDDIR)/$(XORG_LIB_FONTENC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_FONTENC_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-fontenc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-fontenc)
	@$(call install_fixup, xorg-lib-fontenc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fontenc,SECTION,base)
	@$(call install_fixup, xorg-lib-fontenc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fontenc,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-fontenc, 0, 0, 0644, libfontenc)

	@$(call install_finish, xorg-lib-fontenc)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XFONT) += xorg-lib-xfont

#
# Paths and names
#
XORG_LIB_XFONT_VERSION	:= 1.4.5
XORG_LIB_XFONT_MD5	:= 6851da5dae0a6cf5f7c9b9e2b05dd3b4
XORG_LIB_XFONT		:= libXfont-$(XORG_LIB_XFONT_VERSION)
XORG_LIB_XFONT_SUFFIX	:= tar.bz2
XORG_LIB_XFONT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX))
XORG_LIB_XFONT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX)
XORG_LIB_XFONT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFONT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XFONT_CONF_TOOL	:= autoconf
XORG_LIB_XFONT_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-devel-docs \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_FREETYPE)-freetype \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_BUILTIN_FONTS)-builtins \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_PCF_FONTS)-pcfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_BDF_FONTS)-bdfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_SNF_FONTS)-snfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT_FONTSERVER)-fc \
	$(XORG_OPTIONS_TRANS) \
	--without-xmlto \
	--without-fop \
	--without-bzip2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xfont.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xfont)
	@$(call install_fixup, xorg-lib-xfont,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfont,SECTION,base)
	@$(call install_fixup, xorg-lib-xfont,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfont,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xfont, 0, 0, 0644, libXfont)

	@$(call install_finish, xorg-lib-xfont)

	@$(call touch)

# vim: syntax=make

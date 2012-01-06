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
XORG_LIB_XFONT_VERSION	:= 1.4.3
XORG_LIB_XFONT_MD5	:= 6fb689cfe13d8d9460f4abb5bd88588d
XORG_LIB_XFONT		:= libXfont-$(XORG_LIB_XFONT_VERSION)
XORG_LIB_XFONT_SUFFIX	:= tar.bz2
XORG_LIB_XFONT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX))
XORG_LIB_XFONT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX)
XORG_LIB_XFONT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFONT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XFONT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XFONT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XFONT_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XFONT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFONT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--without-xmlto

#
# Use the global switch here to support freetype when
# its present in the system
#
ifdef PTXCONF_XORG_LIB_XFONT_FREETYPE
XORG_LIB_XFONT_AUTOCONF	+= --enable-freetype
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-freetype
endif

ifdef PTXCONF_XORG_LIB_XFONT_FONTSERVER
XORG_LIB_XFONT_AUTOCONF	+= --enable-fc
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-fc
endif

ifdef PTXCONF_XORG_LIB_XFONT_PCF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-pcfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-pcfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_BDF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-bdfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-bdfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_SNF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-snfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-snfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_BUILTIN_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-builtins
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-builtins
endif

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

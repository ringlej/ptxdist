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
PACKAGES-$(PTXCONF_XORG_LIB_XFONT) += xorg-lib-xfont

#
# Paths and names
#
XORG_LIB_XFONT_VERSION	:= 1.4.1
XORG_LIB_XFONT		:= libXfont-$(XORG_LIB_XFONT_VERSION)
XORG_LIB_XFONT_SUFFIX	:= tar.bz2
XORG_LIB_XFONT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX)
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

xorg-lib-xfont_prepare: $(STATEDIR)/xorg-lib-xfont.prepare

XORG_LIB_XFONT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFONT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFONT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS)

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

ifdef PTXCONF_XORG_LIB_XFONT_TYPE1_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-type1
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-type1
endif

ifdef PTXCONF_XORG_LIB_XFONT_CID_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-cid
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-cid
endif

ifdef PTXCONF_XORG_LIB_XFONT_SPEEDO_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-speedo
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-speedo
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

xorg-lib-xfont_targetinstall: $(STATEDIR)/xorg-lib-xfont.targetinstall

$(STATEDIR)/xorg-lib-xfont.targetinstall: $(xorg-lib-xfont_targetinstall_deps_default)
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xfont)
	@$(call install_fixup, xorg-lib-xfont,PACKAGE,xorg-lib-xfont)
	@$(call install_fixup, xorg-lib-xfont,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfont,VERSION,$(XORG_LIB_XFONT_VERSION))
	@$(call install_fixup, xorg-lib-xfont,SECTION,base)
	@$(call install_fixup, xorg-lib-xfont,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfont,DEPENDS,)
	@$(call install_fixup, xorg-lib-xfont,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xfont, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXfont.so.1.4.1)

	@$(call install_link, xorg-lib-xfont, \
		libXfont.so.1.4.1, \
		$(XORG_LIBDIR)/libXfont.so.1)

	@$(call install_link, xorg-lib-xfont, \
		libXfont.so.1.4.1, \
		$(XORG_LIBDIR)/libXfont.so)

	@$(call install_finish, xorg-lib-xfont)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xfont_clean:
	rm -rf $(STATEDIR)/xorg-lib-xfont.*
	rm -rf $(PKGDIR)/xorg-lib-xfont_*
	rm -rf $(XORG_LIB_XFONT_DIR)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2003-2009 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.29.4
PANGO_MD5	:= a5ee785f4f31d6bdd8625a09ea3f8b4b
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.bz2
PANGO_URL	:= http://ftp.gnome.org/pub/GNOME/sources/pango/1.29/$(PANGO).$(PANGO_SUFFIX)
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PANGO_PATH	:= PATH=$(CROSS_PATH)
PANGO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PANGO_MODULES-$(PTXCONF_PANGO_BASIC)	+= basic-fc,basic-win32,basic-x,basic-atsui
PANGO_MODULES-$(PTXCONF_PANGO_ARABIC)	+= arabic-fc
PANGO_MODULES-$(PTXCONF_PANGO_HANGUL)	+= hangul-fc
PANGO_MODULES-$(PTXCONF_PANGO_HEBREW)	+= hebrew-fc
PANGO_MODULES-$(PTXCONF_PANGO_INDIC)	+= indic-fc,indic-lang
PANGO_MODULES-$(PTXCONF_PANGO_KHMER)	+= khmer-fc
PANGO_MODULES-$(PTXCONF_PANGO_SYRIAC)	+= syriac-fc
PANGO_MODULES-$(PTXCONF_PANGO_THAI)	+= thai-fc
PANGO_MODULES-$(PTXCONF_PANGO_TIBETAN)	+= tibetan-fc

PANGO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--x-includes=$(XORG_PREFIX)/include \
	--x-libraries=$(XORG_LIBDIR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--disable-doc-cross-references \
	--enable-explicit-deps=no \
	--$(call ptx/wwo, PTXCONF_PANGO_TARGET_X11)-x \
	--with-included-modules=$(subst $(space),$(comma),$(PANGO_MODULES-y)) \
	--without-dynamic-modules

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pango.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pango)
	@$(call install_fixup, pango,PRIORITY,optional)
	@$(call install_fixup, pango,SECTION,base)
	@$(call install_fixup, pango,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pango,DESCRIPTION,missing)

	@$(call install_lib, pango, 0, 0, 0644, libpango-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangoft2-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangocairo-1.0)

	@$(call install_finish, pango)

	@$(call touch)

# vim: syntax=make

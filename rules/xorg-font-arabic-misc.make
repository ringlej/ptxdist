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
PACKAGES-$(PTXCONF_XORG_FONT_ARABIC_MISC) += xorg-font-arabic-misc

#
# Paths and names
#
XORG_FONT_ARABIC_MISC_VERSION	:= 1.0.1
XORG_FONT_ARABIC_MISC		:= font-arabic-misc-$(XORG_FONT_ARABIC_MISC_VERSION)
XORG_FONT_ARABIC_MISC_SUFFIX	:= tar.bz2
XORG_FONT_ARABIC_MISC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_ARABIC_MISC).$(XORG_FONT_ARABIC_MISC_SUFFIX)
XORG_FONT_ARABIC_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ARABIC_MISC).$(XORG_FONT_ARABIC_MISC_SUFFIX)
XORG_FONT_ARABIC_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_ARABIC_MISC)

ifdef PTXCONF_XORG_FONT_ARABIC_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-arabic-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_get: $(STATEDIR)/xorg-font-arabic-misc.get

$(STATEDIR)/xorg-font-arabic-misc.get: $(xorg-font-arabic-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_ARABIC_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_ARABIC_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_extract: $(STATEDIR)/xorg-font-arabic-misc.extract

$(STATEDIR)/xorg-font-arabic-misc.extract: $(xorg-font-arabic-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ARABIC_MISC_DIR))
	@$(call extract, XORG_FONT_ARABIC_MISC)
	@$(call patchin, XORG_FONT_ARABIC_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_prepare: $(STATEDIR)/xorg-font-arabic-misc.prepare

XORG_FONT_ARABIC_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_ARABIC_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ARABIC_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

$(STATEDIR)/xorg-font-arabic-misc.prepare: $(xorg-font-arabic-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ARABIC_MISC_DIR)/config.cache)
	cd $(XORG_FONT_ARABIC_MISC_DIR) && \
		$(XORG_FONT_ARABIC_MISC_PATH) $(XORG_FONT_ARABIC_MISC_ENV) \
		./configure $(XORG_FONT_ARABIC_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_compile: $(STATEDIR)/xorg-font-arabic-misc.compile

$(STATEDIR)/xorg-font-arabic-misc.compile: $(xorg-font-arabic-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_ARABIC_MISC_DIR) && $(XORG_FONT_ARABIC_MISC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_install: $(STATEDIR)/xorg-font-arabic-misc.install

$(STATEDIR)/xorg-font-arabic-misc.install: $(xorg-font-arabic-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_targetinstall: $(STATEDIR)/xorg-font-arabic-misc.targetinstall

$(STATEDIR)/xorg-font-arabic-misc.targetinstall: $(xorg-font-arabic-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_ARABIC_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-arabic-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-arabic-misc.*
	rm -rf $(PKGDIR)/xorg-font-arabic-misc_*
	rm -rf $(XORG_FONT_ARABIC_MISC_DIR)

# vim: syntax=make

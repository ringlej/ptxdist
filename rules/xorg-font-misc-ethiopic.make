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
PACKAGES-$(PTXCONF_XORG_FONT_MISC_ETHIOPIC) += xorg-font-misc-ethiopic

#
# Paths and names
#
XORG_FONT_MISC_ETHIOPIC_VERSION	:= 1.0.1
XORG_FONT_MISC_ETHIOPIC		:= font-misc-ethiopic-$(XORG_FONT_MISC_ETHIOPIC_VERSION)
XORG_FONT_MISC_ETHIOPIC_SUFFIX	:= tar.bz2
XORG_FONT_MISC_ETHIOPIC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_MISC_ETHIOPIC).$(XORG_FONT_MISC_ETHIOPIC_SUFFIX)
XORG_FONT_MISC_ETHIOPIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MISC_ETHIOPIC).$(XORG_FONT_MISC_ETHIOPIC_SUFFIX)
XORG_FONT_MISC_ETHIOPIC_DIR	:= $(BUILDDIR)/$(XORG_FONT_MISC_ETHIOPIC)

ifdef PTXCONF_XORG_FONT_MISC_ETHIOPIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-misc-ethiopic.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_get: $(STATEDIR)/xorg-font-misc-ethiopic.get

$(STATEDIR)/xorg-font-misc-ethiopic.get: $(xorg-font-misc-ethiopic_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_MISC_ETHIOPIC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_MISC_ETHIOPIC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_extract: $(STATEDIR)/xorg-font-misc-ethiopic.extract

$(STATEDIR)/xorg-font-misc-ethiopic.extract: $(xorg-font-misc-ethiopic_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_ETHIOPIC_DIR))
	@$(call extract, XORG_FONT_MISC_ETHIOPIC)
	@$(call patchin, XORG_FONT_MISC_ETHIOPIC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_prepare: $(STATEDIR)/xorg-font-misc-ethiopic.prepare

XORG_FONT_MISC_ETHIOPIC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_MISC_ETHIOPIC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_ETHIOPIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-ttf-fontdir=$(XORG_FONTDIR)/truetype \
	--with-otf-fontdir=$(XORG_FONTDIR)/opentype

$(STATEDIR)/xorg-font-misc-ethiopic.prepare: $(xorg-font-misc-ethiopic_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_ETHIOPIC_DIR)/config.cache)
	cd $(XORG_FONT_MISC_ETHIOPIC_DIR) && \
		$(XORG_FONT_MISC_ETHIOPIC_PATH) $(XORG_FONT_MISC_ETHIOPIC_ENV) \
		./configure $(XORG_FONT_MISC_ETHIOPIC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_compile: $(STATEDIR)/xorg-font-misc-ethiopic.compile

$(STATEDIR)/xorg-font-misc-ethiopic.compile: $(xorg-font-misc-ethiopic_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_MISC_ETHIOPIC_DIR) && $(XORG_FONT_MISC_ETHIOPIC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_install: $(STATEDIR)/xorg-font-misc-ethiopic.install

$(STATEDIR)/xorg-font-misc-ethiopic.install: $(xorg-font-misc-ethiopic_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_targetinstall: $(STATEDIR)/xorg-font-misc-ethiopic.targetinstall

$(STATEDIR)/xorg-font-misc-ethiopic.targetinstall: $(xorg-font-misc-ethiopic_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype
	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/opentype

	@find $(XORG_FONT_MISC_ETHIOPIC_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@find $(XORG_FONT_MISC_ETHIOPIC_DIR) \
		-name "*.otf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/opentype; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-misc-ethiopic_clean:
	rm -rf $(STATEDIR)/xorg-font-misc-ethiopic.*
	rm -rf $(PKGDIR)/xorg-font-misc-ethiopic_*
	rm -rf $(XORG_FONT_MISC_ETHIOPIC_DIR)

# vim: syntax=make

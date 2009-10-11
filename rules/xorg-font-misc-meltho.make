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
PACKAGES-$(PTXCONF_XORG_FONT_MISC_MELTHO) += xorg-font-misc-meltho

#
# Paths and names
#
XORG_FONT_MISC_MELTHO_VERSION	:= 1.0.1
XORG_FONT_MISC_MELTHO		:= font-misc-meltho-$(XORG_FONT_MISC_MELTHO_VERSION)
XORG_FONT_MISC_MELTHO_SUFFIX	:= tar.bz2
XORG_FONT_MISC_MELTHO_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_MISC_MELTHO).$(XORG_FONT_MISC_MELTHO_SUFFIX)
XORG_FONT_MISC_MELTHO_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MISC_MELTHO).$(XORG_FONT_MISC_MELTHO_SUFFIX)
XORG_FONT_MISC_MELTHO_DIR	:= $(BUILDDIR)/$(XORG_FONT_MISC_MELTHO)

ifdef PTXCONF_XORG_FONT_MISC_MELTHO
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-misc-meltho.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_get: $(STATEDIR)/xorg-font-misc-meltho.get

$(STATEDIR)/xorg-font-misc-meltho.get: $(xorg-font-misc-meltho_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_MISC_MELTHO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_MISC_MELTHO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_extract: $(STATEDIR)/xorg-font-misc-meltho.extract

$(STATEDIR)/xorg-font-misc-meltho.extract: $(xorg-font-misc-meltho_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_MELTHO_DIR))
	@$(call extract, XORG_FONT_MISC_MELTHO)
	@$(call patchin, XORG_FONT_MISC_MELTHO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_prepare: $(STATEDIR)/xorg-font-misc-meltho.prepare

XORG_FONT_MISC_MELTHO_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_MISC_MELTHO_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_MELTHO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/opentype

$(STATEDIR)/xorg-font-misc-meltho.prepare: $(xorg-font-misc-meltho_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MISC_MELTHO_DIR)/config.cache)
	cd $(XORG_FONT_MISC_MELTHO_DIR) && \
		$(XORG_FONT_MISC_MELTHO_PATH) $(XORG_FONT_MISC_MELTHO_ENV) \
		./configure $(XORG_FONT_MISC_MELTHO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_compile: $(STATEDIR)/xorg-font-misc-meltho.compile

$(STATEDIR)/xorg-font-misc-meltho.compile: $(xorg-font-misc-meltho_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_MISC_MELTHO_DIR) && $(XORG_FONT_MISC_MELTHO_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_install: $(STATEDIR)/xorg-font-misc-meltho.install

$(STATEDIR)/xorg-font-misc-meltho.install: $(xorg-font-misc-meltho_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_targetinstall: $(STATEDIR)/xorg-font-misc-meltho.targetinstall

$(STATEDIR)/xorg-font-misc-meltho.targetinstall: $(xorg-font-misc-meltho_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/opentype

	@find $(XORG_FONT_MISC_MELTHO_DIR) \
		-name "*.otf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/opentype; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-misc-meltho_clean:
	rm -rf $(STATEDIR)/xorg-font-misc-meltho.*
	rm -rf $(PKGDIR)/xorg-font-misc-meltho_*
	rm -rf $(XORG_FONT_MISC_MELTHO_DIR)

# vim: syntax=make

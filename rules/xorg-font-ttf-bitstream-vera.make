# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_BITSTREAM_VERA) += xorg-font-ttf-bitstream-vera

#
# Paths and names
#
XORG_FONT_TTF_BITSTREAM_VERA_VERSION	:= 1.10
XORG_FONT_TTF_BITSTREAM_VERA		:= ttf-bitstream-vera-$(XORG_FONT_TTF_BITSTREAM_VERA_VERSION)
XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX	:= tar.bz2
XORG_FONT_TTF_BITSTREAM_VERA_URL	:= http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/$(XORG_FONT_TTF_BITSTREAM_VERA_VERSION)/$(XORG_FONT_TTF_BITSTREAM_VERA).$(XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX)
XORG_FONT_TTF_BITSTREAM_VERA_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_BITSTREAM_VERA).$(XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX)
XORG_FONT_TTF_BITSTREAM_VERA_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_BITSTREAM_VERA)

ifdef PTXCONF_XORG_FONT_TTF_BITSTREAM_VERA
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-bitstream-vera.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_get: $(STATEDIR)/xorg-font-ttf-bitstream-vera.get

$(STATEDIR)/xorg-font-ttf-bitstream-vera.get: $(xorg-font-ttf-bitstream-vera_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_TTF_BITSTREAM_VERA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_TTF_BITSTREAM_VERA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_extract: $(STATEDIR)/xorg-font-ttf-bitstream-vera.extract

$(STATEDIR)/xorg-font-ttf-bitstream-vera.extract: $(xorg-font-ttf-bitstream-vera_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_TTF_BITSTREAM_VERA_DIR))
	@$(call extract, XORG_FONT_TTF_BITSTREAM_VERA)
	@$(call patchin, XORG_FONT_TTF_BITSTREAM_VERA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_prepare: $(STATEDIR)/xorg-font-ttf-bitstream-vera.prepare

$(STATEDIR)/xorg-font-ttf-bitstream-vera.prepare: $(xorg-font-ttf-bitstream-vera_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_compile: $(STATEDIR)/xorg-font-ttf-bitstream-vera.compile

$(STATEDIR)/xorg-font-ttf-bitstream-vera.compile: $(xorg-font-ttf-bitstream-vera_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_install: $(STATEDIR)/xorg-font-ttf-bitstream-vera.install

$(STATEDIR)/xorg-font-ttf-bitstream-vera.install: $(xorg-font-ttf-bitstream-vera_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_targetinstall: $(STATEDIR)/xorg-font-ttf-bitstream-vera.targetinstall

$(STATEDIR)/xorg-font-ttf-bitstream-vera.targetinstall: $(xorg-font-ttf-bitstream-vera_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_BITSTREAM_VERA_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-ttf-bitstream-vera_clean:
	rm -rf $(STATEDIR)/xorg-font-ttf-bitstream-vera.*
	rm -rf $(PKGDIR)/xorg-font-ttf-bitstream-vera_*
	rm -rf $(XORG_FONT_TTF_BITSTREAM_VERA_DIR)

# vim: syntax=make

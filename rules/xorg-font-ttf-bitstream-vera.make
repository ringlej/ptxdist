# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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

$(XORG_FONT_TTF_BITSTREAM_VERA_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_TTF_BITSTREAM_VERA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-bitstream-vera.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-bitstream-vera.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-bitstream-vera.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-bitstream-vera.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_BITSTREAM_VERA_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

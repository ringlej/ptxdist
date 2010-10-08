# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
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
PACKAGES-$(PTXCONF_XORG_FONT_MISC_ETHIOPIC) += xorg-font-misc-ethiopic

#
# Paths and names
#
XORG_FONT_MISC_ETHIOPIC_VERSION	:= 1.0.3
XORG_FONT_MISC_ETHIOPIC_MD5	:= 6306c808f7d7e7d660dfb3859f9091d2
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

$(XORG_FONT_MISC_ETHIOPIC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_MISC_ETHIOPIC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_MISC_ETHIOPIC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_MISC_ETHIOPIC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_ETHIOPIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-ttf-fontdir=$(XORG_FONTDIR)/truetype \
	--with-otf-fontdir=$(XORG_FONTDIR)/opentype

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-ethiopic.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-ethiopic.targetinstall:
	@$(call targetinfo)

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

	@$(call touch)

# vim: syntax=make

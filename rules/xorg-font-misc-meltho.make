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
PACKAGES-$(PTXCONF_XORG_FONT_MISC_MELTHO) += xorg-font-misc-meltho

#
# Paths and names
#
XORG_FONT_MISC_MELTHO_VERSION	:= 1.0.3
XORG_FONT_MISC_MELTHO_MD5	:= e3e7b0fda650adc7eb6964ff3c486b1c
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

$(XORG_FONT_MISC_MELTHO_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_MISC_MELTHO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_MISC_MELTHO_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_MISC_MELTHO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_MELTHO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/opentype

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-meltho.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-meltho.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/opentype

	@find $(XORG_FONT_MISC_MELTHO_DIR) \
		-name "*.otf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/opentype; \
	done

	@$(call touch)

# vim: syntax=make

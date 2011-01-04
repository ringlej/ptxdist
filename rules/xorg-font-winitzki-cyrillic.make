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
PACKAGES-$(PTXCONF_XORG_FONT_WINITZKI_CYRILLIC) += xorg-font-winitzki-cyrillic

#
# Paths and names
#
XORG_FONT_WINITZKI_CYRILLIC_VERSION	:= 1.0.3
XORG_FONT_WINITZKI_CYRILLIC		:= font-winitzki-cyrillic-$(XORG_FONT_WINITZKI_CYRILLIC_VERSION)
XORG_FONT_WINITZKI_CYRILLIC_SUFFIX	:= tar.bz2
XORG_FONT_WINITZKI_CYRILLIC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_WINITZKI_CYRILLIC).$(XORG_FONT_WINITZKI_CYRILLIC_SUFFIX)
XORG_FONT_WINITZKI_CYRILLIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_WINITZKI_CYRILLIC).$(XORG_FONT_WINITZKI_CYRILLIC_SUFFIX)
XORG_FONT_WINITZKI_CYRILLIC_DIR		:= $(BUILDDIR)/$(XORG_FONT_WINITZKI_CYRILLIC)

ifdef PTXCONF_XORG_FONT_WINITZKI_CYRILLIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-winitzki-cyrillic.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_WINITZKI_CYRILLIC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_WINITZKI_CYRILLIC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_WINITZKI_CYRILLIC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_WINITZKI_CYRILLIC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_WINITZKI_CYRILLIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/cyrillic


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-winitzki-cyrillic.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-winitzki-cyrillic.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/cyrillic

	@find $(XORG_FONT_WINITZKI_CYRILLIC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/cyrillic; \
	done

	@$(call touch)

# vim: syntax=make

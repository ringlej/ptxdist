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
PACKAGES-$(PTXCONF_XORG_FONT_ADOBE_75DPI) += xorg-font-adobe-75dpi

#
# Paths and names
#
XORG_FONT_ADOBE_75DPI_VERSION	:= 1.0.3
XORG_FONT_ADOBE_75DPI_MD5	:= 6c9f26c92393c0756f3e8d614713495b
XORG_FONT_ADOBE_75DPI		:= font-adobe-75dpi-$(XORG_FONT_ADOBE_75DPI_VERSION)
XORG_FONT_ADOBE_75DPI_SUFFIX	:= tar.bz2
XORG_FONT_ADOBE_75DPI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_ADOBE_75DPI).$(XORG_FONT_ADOBE_75DPI_SUFFIX)
XORG_FONT_ADOBE_75DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ADOBE_75DPI).$(XORG_FONT_ADOBE_75DPI_SUFFIX)
XORG_FONT_ADOBE_75DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ADOBE_75DPI)

ifdef PTXCONF_XORG_FONT_ADOBE_75DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-adobe-75dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_ADOBE_75DPI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_ADOBE_75DPI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ADOBE_75DPI_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_ADOBE_75DPI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ADOBE_75DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/75dpi

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-75dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-75dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/75dpi

	@cd $(XORG_FONT_ADOBE_75DPI_DIR); \
	find . -name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/75dpi; \
	done


ifdef PTXCONF_XORG_FONT_ADOBE_75DPI_TRANS
	@cd $(XORG_FONT_ADOBE_75DPI_DIR); \
	find . -name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/75dpi; \
	done
endif

	@$(call touch)

# vim: syntax=make

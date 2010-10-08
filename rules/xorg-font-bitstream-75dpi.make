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
PACKAGES-$(PTXCONF_XORG_FONT_BITSTREAM_75DPI) += xorg-font-bitstream-75dpi

#
# Paths and names
#
XORG_FONT_BITSTREAM_75DPI_VERSION	:= 1.0.3
XORG_FONT_BITSTREAM_75DPI_MD5		:= d7c0588c26fac055c0dd683fdd65ac34
XORG_FONT_BITSTREAM_75DPI		:= font-bitstream-75dpi-$(XORG_FONT_BITSTREAM_75DPI_VERSION)
XORG_FONT_BITSTREAM_75DPI_SUFFIX	:= tar.bz2
XORG_FONT_BITSTREAM_75DPI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BITSTREAM_75DPI).$(XORG_FONT_BITSTREAM_75DPI_SUFFIX)
XORG_FONT_BITSTREAM_75DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BITSTREAM_75DPI).$(XORG_FONT_BITSTREAM_75DPI_SUFFIX)
XORG_FONT_BITSTREAM_75DPI_DIR		:= $(BUILDDIR)/$(XORG_FONT_BITSTREAM_75DPI)

ifdef PTXCONF_XORG_FONT_BITSTREAM_75DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bitstream-75dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_BITSTREAM_75DPI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_BITSTREAM_75DPI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_BITSTREAM_75DPI_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_BITSTREAM_75DPI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BITSTREAM_75DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/75dpi


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-75dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-75dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/75dpi

	@find $(XORG_FONT_BITSTREAM_75DPI_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/75dpi; \
	done

	@$(call touch)

# vim: syntax=make

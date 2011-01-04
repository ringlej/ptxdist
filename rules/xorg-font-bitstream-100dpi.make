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
PACKAGES-$(PTXCONF_XORG_FONT_BITSTREAM_100DPI) += xorg-font-bitstream-100dpi

#
# Paths and names
#
XORG_FONT_BITSTREAM_100DPI_VERSION	:= 1.0.3
XORG_FONT_BITSTREAM_100DPI		:= font-bitstream-100dpi-$(XORG_FONT_BITSTREAM_100DPI_VERSION)
XORG_FONT_BITSTREAM_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_BITSTREAM_100DPI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BITSTREAM_100DPI).$(XORG_FONT_BITSTREAM_100DPI_SUFFIX)
XORG_FONT_BITSTREAM_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BITSTREAM_100DPI).$(XORG_FONT_BITSTREAM_100DPI_SUFFIX)
XORG_FONT_BITSTREAM_100DPI_DIR		:= $(BUILDDIR)/$(XORG_FONT_BITSTREAM_100DPI)

ifdef PTXCONF_XORG_FONT_BITSTREAM_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bitstream-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_BITSTREAM_100DPI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_BITSTREAM_100DPI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_BITSTREAM_100DPI_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_BITSTREAM_100DPI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BITSTREAM_100DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-100dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-100dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@find $(XORG_FONT_BITSTREAM_100DPI_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

	@$(call touch)

# vim: syntax=make

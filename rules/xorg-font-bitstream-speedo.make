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
PACKAGES-$(PTXCONF_XORG_FONT_BITSTREAM_SPEEDO) += xorg-font-bitstream-speedo

#
# Paths and names
#
XORG_FONT_BITSTREAM_SPEEDO_VERSION	:= 1.0.2
XORG_FONT_BITSTREAM_SPEEDO_MD5		:= 13f6f107be164cfbf6be40d35ecf0c0f
XORG_FONT_BITSTREAM_SPEEDO		:= font-bitstream-speedo-$(XORG_FONT_BITSTREAM_SPEEDO_VERSION)
XORG_FONT_BITSTREAM_SPEEDO_SUFFIX	:= tar.bz2
XORG_FONT_BITSTREAM_SPEEDO_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BITSTREAM_SPEEDO).$(XORG_FONT_BITSTREAM_SPEEDO_SUFFIX)
XORG_FONT_BITSTREAM_SPEEDO_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BITSTREAM_SPEEDO).$(XORG_FONT_BITSTREAM_SPEEDO_SUFFIX)
XORG_FONT_BITSTREAM_SPEEDO_DIR		:= $(BUILDDIR)/$(XORG_FONT_BITSTREAM_SPEEDO)

ifdef PTXCONF_XORG_FONT_BITSTREAM_SPEEDO
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bitstream-speedo.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_BITSTREAM_SPEEDO_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_BITSTREAM_SPEEDO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_BITSTREAM_SPEEDO_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_BITSTREAM_SPEEDO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BITSTREAM_SPEEDO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/Speedo

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-speedo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bitstream-speedo.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/Speedo

	@find $(XORG_FONT_BITSTREAM_SPEEDO_DIR) \
		-name "*.spd" \
		-o -name "fonts.scale" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/Speedo; \
	done

	@$(call touch)

# vim: syntax=make

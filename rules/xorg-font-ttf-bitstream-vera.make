# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2018 by Florian Bäuerle <florian.baeuerle@allegion.com>
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
XORG_FONT_TTF_BITSTREAM_VERA_MD5	:= bb22bd5b4675f5dbe17c6963d8c00ed6
XORG_FONT_TTF_BITSTREAM_VERA		:= ttf-bitstream-vera-$(XORG_FONT_TTF_BITSTREAM_VERA_VERSION)
XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX	:= tar.bz2
XORG_FONT_TTF_BITSTREAM_VERA_URL	:= http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/$(XORG_FONT_TTF_BITSTREAM_VERA_VERSION)/$(XORG_FONT_TTF_BITSTREAM_VERA).$(XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX)
XORG_FONT_TTF_BITSTREAM_VERA_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_BITSTREAM_VERA).$(XORG_FONT_TTF_BITSTREAM_VERA_SUFFIX)
XORG_FONT_TTF_BITSTREAM_VERA_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_BITSTREAM_VERA)
XORG_FONT_TTF_BITSTREAM_VERA_LICENSE	:= Bitstream-Vera
XORG_FONT_TTF_BITSTREAM_VERA_LICENSE_FILES := \
	file://COPYRIGHT.TXT;md5=27d7484b1e18d0ee4ce538644a3f04be

XORG_FONT_TTF_BITSTREAM_VERA_CONF_TOOL	:= NO
XORG_FONT_TTF_BITSTREAM_VERA_FONTDIR	:= $(XORG_FONTDIR)/truetype/bitstream-vera

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
	@$(call world/install-fonts,XORG_FONT_TTF_BITSTREAM_VERA,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-bitstream-vera.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-bitstream-vera)
	@$(call install_fixup, xorg-font-ttf-bitstream-vera,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-bitstream-vera,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-bitstream-vera,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-ttf-bitstream-vera,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-bitstream-vera, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-bitstream-vera)
	@$(call touch)

# vim: syntax=make

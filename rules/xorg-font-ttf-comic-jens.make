# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_COMIC_JENS) += xorg-font-ttf-comic-jens

#
# Paths and names
#
XORG_FONT_TTF_COMIC_JENS_VERSION	:= 2.0
XORG_FONT_TTF_COMIC_JENS_MD5		:= 21ab5b4a9360b58959ad30e757aa2ada
XORG_FONT_TTF_COMIC_JENS		:= comic-jens
XORG_FONT_TTF_COMIC_JENS_SUFFIX		:= zip
XORG_FONT_TTF_COMIC_JENS_URL		:= http://www.kutilek.de/download/$(XORG_FONT_TTF_COMIC_JENS).$(XORG_FONT_TTF_COMIC_JENS_SUFFIX)
XORG_FONT_TTF_COMIC_JENS_SOURCE		:= $(SRCDIR)/$(XORG_FONT_TTF_COMIC_JENS).$(XORG_FONT_TTF_COMIC_JENS_SUFFIX)
XORG_FONT_TTF_COMIC_JENS_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_COMIC_JENS)
XORG_FONT_TTF_COMIC_JENS_LICENSE	:= CC-BY-ND-3.0
XORG_FONT_TTF_COMIC_JENS_LICENSE_FILES	:= \
	file://Licence.txt;md5=dccc90a479b3a0b508cac38314a04334

ifdef PTXCONF_XORG_FONT_TTF_COMIC_JENS
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-comic-jens.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_COMIC_JENS_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-comic-jens.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-comic-jens.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-comic-jens.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_COMIC_JENS_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

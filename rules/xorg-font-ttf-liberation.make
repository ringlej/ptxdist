# -*-makefile-*-
#
# Copyright (C) 2015 by Philipp Zabel <p.zabel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LIBERATION) += xorg-font-ttf-liberation

#
# Paths and names
#
XORG_FONT_TTF_LIBERATION_VERSION	:= 2.00.1
XORG_FONT_TTF_LIBERATION_MD5		:= 5c781723a0d9ed6188960defba8e91cf
XORG_FONT_TTF_LIBERATION		:= liberation-fonts-ttf-$(XORG_FONT_TTF_LIBERATION_VERSION)
XORG_FONT_TTF_LIBERATION_SUFFIX		:= tar.gz
XORG_FONT_TTF_LIBERATION_URL		:= https://releases.pagure.org/liberation-fonts/$(XORG_FONT_TTF_LIBERATION).$(XORG_FONT_TTF_LIBERATION_SUFFIX)
XORG_FONT_TTF_LIBERATION_SOURCE		:= $(SRCDIR)/$(XORG_FONT_TTF_LIBERATION).$(XORG_FONT_TTF_LIBERATION_SUFFIX)
XORG_FONT_TTF_LIBERATION_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LIBERATION)
XORG_FONT_TTF_LIBERATION_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LIBERATION_LICENSE_FILES	:= \
	file://LICENSE;md5=f96db970a9a46c5369142b99f530366b

ifdef PTXCONF_XORG_FONT_TTF_LIBERATION
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-liberation.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-liberation.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-liberation.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-liberation.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-liberation.targetinstall:
	@$(call targetinfo)

	mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	find $(XORG_FONT_TTF_LIBERATION_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

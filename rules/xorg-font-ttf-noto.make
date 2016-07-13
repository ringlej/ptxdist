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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_NOTO) += xorg-font-ttf-noto

#
# Paths and names
#
XORG_FONT_TTF_NOTO_VERSION	:= 69424ef5945c50168aea6a1a508fcffad8c16e79
XORG_FONT_TTF_NOTO_MD5		:= a1a07323cb8aed17a9029dd1aa14471b
XORG_FONT_TTF_NOTO		:= xorg-font-ttf-noto-$(XORG_FONT_TTF_NOTO_VERSION)
XORG_FONT_TTF_NOTO_SUFFIX	:= tar.gz
XORG_FONT_TTF_NOTO_URL		:= https://github.com/googlei18n/noto-fonts.git;tag=$(XORG_FONT_TTF_NOTO_VERSION)
XORG_FONT_TTF_NOTO_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_NOTO).$(XORG_FONT_TTF_NOTO_SUFFIX)
XORG_FONT_TTF_NOTO_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_NOTO)
XORG_FONT_TTF_NOTO_LICENSE	:= OFL-1.1

ifdef PTXCONF_XORG_FONT_TTF_NOTO
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-noto.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_NOTO_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-noto.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-noto.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-noto.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_NOTO_DIR)/{unhinted,hinted} \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

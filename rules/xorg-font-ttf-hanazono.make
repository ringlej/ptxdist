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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_HANAZONO) += xorg-font-ttf-hanazono

#
# Paths and names
#
XORG_FONT_TTF_HANAZONO_VERSION		:= 20141012
XORG_FONT_TTF_HANAZONO_MD5		:= b7733ecc1a2ebf62cbe840b9ebffb05c
XORG_FONT_TTF_HANAZONO			:= hanazono-$(XORG_FONT_TTF_HANAZONO_VERSION)
XORG_FONT_TTF_HANAZONO_SUFFIX		:= zip
XORG_FONT_TTF_HANAZONO_URL		:= http://osdn.jp/frs/redir.php?m=osdn&f=%2Fhanazono-font%2F62072%2F$(XORG_FONT_TTF_HANAZONO).$(XORG_FONT_TTF_HANAZONO_SUFFIX)
XORG_FONT_TTF_HANAZONO_SOURCE		:= $(SRCDIR)/$(XORG_FONT_TTF_HANAZONO).$(XORG_FONT_TTF_HANAZONO_SUFFIX)
XORG_FONT_TTF_HANAZONO_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_HANAZONO)
XORG_FONT_TTF_HANAZONO_STRIP_LEVEL	:= 0
XORG_FONT_TTF_HANAZONO_LICENSE		:= OFL-1.1

ifdef PTXCONF_XORG_FONT_TTF_HANAZONO
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-hanazono.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_HANAZONO_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-hanazono.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-hanazono.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-hanazono.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_HANAZONO_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

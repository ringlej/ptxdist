# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_GUJARATI) += xorg-font-ttf-lohit-gujarati

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_GUJARATI_VERSION	:= 2.92.2
XORG_FONT_TTF_LOHIT_GUJARATI_MD5	:= a2a5c30c0b1a68d59ead3cf26ce88d0b
XORG_FONT_TTF_LOHIT_GUJARATI		:= lohit-gujarati-ttf-$(XORG_FONT_TTF_LOHIT_GUJARATI_VERSION)
XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_GUJARATI_URL	:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_GUJARATI).$(XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX)
XORG_FONT_TTF_LOHIT_GUJARATI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_GUJARATI).$(XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX)
XORG_FONT_TTF_LOHIT_GUJARATI_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_GUJARATI)
XORG_FONT_TTF_LOHIT_GUJARATI_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_GUJARATI_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

XORG_FONT_TTF_LOHIT_GUJARATI_CONF_TOOL	:= NO
XORG_FONT_TTF_LOHIT_GUJARATI_FONTDIR	:= $(XORG_FONTDIR)/truetype/lohit-gujarati

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_LOHIT_GUJARATI,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_LOHIT_GUJARATI_PKGDIR)/etc/fonts/conf.d
	@install -m 644 $(XORG_FONT_TTF_LOHIT_GUJARATI_DIR)/66-lohit-gujarati.conf \
		$(XORG_FONT_TTF_LOHIT_GUJARATI_PKGDIR)/etc/fonts/conf.d
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-lohit-gujarati)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-lohit-gujarati, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-lohit-gujarati, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-lohit-gujarati)
	@$(call touch)

# vim: syntax=make

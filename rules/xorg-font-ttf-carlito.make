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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_CARLITO) += xorg-font-ttf-carlito

#
# Paths and names
#
XORG_FONT_TTF_CARLITO_VERSION	:= 20130920
XORG_FONT_TTF_CARLITO_MD5	:= c74b7223abe75949b4af367942d96c7a
XORG_FONT_TTF_CARLITO		:= crosextrafonts-carlito-$(XORG_FONT_TTF_CARLITO_VERSION)
XORG_FONT_TTF_CARLITO_SUFFIX	:= tar.gz
XORG_FONT_TTF_CARLITO_URL	:= http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/$(XORG_FONT_TTF_CARLITO).$(XORG_FONT_TTF_CARLITO_SUFFIX)
XORG_FONT_TTF_CARLITO_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_CARLITO).$(XORG_FONT_TTF_CARLITO_SUFFIX)
XORG_FONT_TTF_CARLITO_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_CARLITO)
XORG_FONT_TTF_CARLITO_LICENSE	:= OFL-1.1

XORG_FONT_TTF_CARLITO_CONF_TOOL	:= NO
XORG_FONT_TTF_CARLITO_FONTDIR	:= $(XORG_FONTDIR)/truetype/carlito

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_CARLITO,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-carlito)
	@$(call install_fixup, xorg-font-ttf-carlito,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-carlito,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-carlito,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-carlito,DESCRIPTION,missing)

	@$(call install_alternative, xorg-font-ttf-carlito, 0, 0, 644, \
		/etc/fonts/conf.d/30-0-google-crosextra-carlito-fontconfig.conf)
	@$(call install_alternative, xorg-font-ttf-carlito, 0, 0, 644, \
		/etc/fonts/conf.d/62-google-crosextra-carlito-fontconfig.conf)

	@$(call install_tree, xorg-font-ttf-carlito, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-carlito)
	@$(call touch)

# vim: syntax=make

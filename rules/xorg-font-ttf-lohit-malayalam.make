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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_MALAYALAM) += xorg-font-ttf-lohit-malayalam

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_MALAYALAM_VERSION	:= 2.92.0
XORG_FONT_TTF_LOHIT_MALAYALAM_MD5	:= 81fd6a485f2cb3ca5119b6ad58fc63fe
XORG_FONT_TTF_LOHIT_MALAYALAM		:= lohit-malayalam-ttf-$(XORG_FONT_TTF_LOHIT_MALAYALAM_VERSION)
XORG_FONT_TTF_LOHIT_MALAYALAM_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_MALAYALAM_URL	:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_MALAYALAM).$(XORG_FONT_TTF_LOHIT_MALAYALAM_SUFFIX)
XORG_FONT_TTF_LOHIT_MALAYALAM_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_MALAYALAM).$(XORG_FONT_TTF_LOHIT_MALAYALAM_SUFFIX)
XORG_FONT_TTF_LOHIT_MALAYALAM_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_MALAYALAM)
XORG_FONT_TTF_LOHIT_MALAYALAM_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_MALAYALAM_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

XORG_FONT_TTF_LOHIT_MALAYALAM_CONF_TOOL	:= NO
XORG_FONT_TTF_LOHIT_MALAYALAM_FONTDIR	:= $(XORG_FONTDIR)/truetype/lohit-malayalam

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-malayalam.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-malayalam.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_LOHIT_MALAYALAM,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_LOHIT_MALAYALAM_PKGDIR)/etc/fonts/conf.d
	@install -m 644 $(XORG_FONT_TTF_LOHIT_MALAYALAM_DIR)/67-lohit-malayalam.conf \
		$(XORG_FONT_TTF_LOHIT_MALAYALAM_PKGDIR)/etc/fonts/conf.d
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-malayalam.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-lohit-malayalam)
	@$(call install_fixup, xorg-font-ttf-lohit-malayalam,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-malayalam,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-malayalam,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-malayalam,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-lohit-malayalam, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-lohit-malayalam, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-lohit-malayalam)
	@$(call touch)

# vim: syntax=make

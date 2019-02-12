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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_TELUGU) += xorg-font-ttf-lohit-telugu

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_TELUGU_VERSION	:= 2.5.4
XORG_FONT_TTF_LOHIT_TELUGU_MD5		:= 0d9ec6fd82ad4a6951f5e40600c76181
XORG_FONT_TTF_LOHIT_TELUGU		:= lohit-telugu-ttf-$(XORG_FONT_TTF_LOHIT_TELUGU_VERSION)
XORG_FONT_TTF_LOHIT_TELUGU_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_TELUGU_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_TELUGU).$(XORG_FONT_TTF_LOHIT_TELUGU_SUFFIX)
XORG_FONT_TTF_LOHIT_TELUGU_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_TELUGU).$(XORG_FONT_TTF_LOHIT_TELUGU_SUFFIX)
XORG_FONT_TTF_LOHIT_TELUGU_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_TELUGU)
XORG_FONT_TTF_LOHIT_TELUGU_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_TELUGU_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

XORG_FONT_TTF_LOHIT_TELUGU_CONF_TOOL	:= NO
XORG_FONT_TTF_LOHIT_TELUGU_FONTDIR	:= $(XORG_FONTDIR)/truetype/lohit-telugu

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-telugu.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-telugu.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_LOHIT_TELUGU,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_LOHIT_TELUGU_PKGDIR)/etc/fonts/conf.d
	@install -m 644 $(XORG_FONT_TTF_LOHIT_TELUGU_DIR)/66-lohit-telugu.conf \
		$(XORG_FONT_TTF_LOHIT_TELUGU_PKGDIR)/etc/fonts/conf.d
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-telugu.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-lohit-telugu)
	@$(call install_fixup, xorg-font-ttf-lohit-telugu,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-telugu,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-telugu,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-telugu,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-lohit-telugu, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-lohit-telugu, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-lohit-telugu)
	@$(call touch)

# vim: syntax=make

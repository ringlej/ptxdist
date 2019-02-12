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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_PUNJABI) += xorg-font-ttf-lohit-punjabi

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_PUNJABI_VERSION	:= 2.5.3
XORG_FONT_TTF_LOHIT_PUNJABI_MD5		:= deab8c052af328248e8f619178ff890d
XORG_FONT_TTF_LOHIT_PUNJABI		:= lohit-punjabi-ttf-$(XORG_FONT_TTF_LOHIT_PUNJABI_VERSION)
XORG_FONT_TTF_LOHIT_PUNJABI_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_PUNJABI_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_PUNJABI).$(XORG_FONT_TTF_LOHIT_PUNJABI_SUFFIX)
XORG_FONT_TTF_LOHIT_PUNJABI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_PUNJABI).$(XORG_FONT_TTF_LOHIT_PUNJABI_SUFFIX)
XORG_FONT_TTF_LOHIT_PUNJABI_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_PUNJABI)
XORG_FONT_TTF_LOHIT_PUNJABI_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_PUNJABI_LICENSE_FILES := \
	file://OFL.txt;md5=e56537d157e0ee370c0d8468da33e245

XORG_FONT_TTF_LOHIT_PUNJABI_CONF_TOOL	:= NO
XORG_FONT_TTF_LOHIT_PUNJABI_FONTDIR	:= $(XORG_FONTDIR)/truetype/lohit-punjabi

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-punjabi.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-punjabi.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_LOHIT_PUNJABI,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_LOHIT_PUNJABI_PKGDIR)/etc/fonts/conf.d
	@install -m 644 $(XORG_FONT_TTF_LOHIT_PUNJABI_DIR)/66-lohit-punjabi.conf \
		$(XORG_FONT_TTF_LOHIT_PUNJABI_PKGDIR)/etc/fonts/conf.d
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-punjabi.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-lohit-punjabi)
	@$(call install_fixup, xorg-font-ttf-lohit-punjabi,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-punjabi,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-punjabi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-punjabi,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-lohit-punjabi, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-lohit-punjabi, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-lohit-punjabi)
	@$(call touch)

# vim: syntax=make

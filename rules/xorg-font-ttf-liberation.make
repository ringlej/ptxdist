# -*-makefile-*-
#
# Copyright (C) 2015 by Philipp Zabel <p.zabel@pengutronix.de>
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

XORG_FONT_TTF_LIBERATION_CONF_TOOL	:= NO
XORG_FONT_TTF_LIBERATION_FONTDIR	:= $(XORG_FONTDIR)/truetype/liberation

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
	@$(call world/install-fonts,XORG_FONT_TTF_LIBERATION,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-liberation.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-liberation)
	@$(call install_fixup, xorg-font-ttf-liberation,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-liberation,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-liberation,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-ttf-liberation,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-liberation, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-liberation)
	@$(call touch)

# vim: syntax=make

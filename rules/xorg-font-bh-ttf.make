# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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
PACKAGES-$(PTXCONF_XORG_FONT_BH_TTF) += xorg-font-bh-ttf

#
# Paths and names
#
XORG_FONT_BH_TTF_VERSION	:= 1.0.3
XORG_FONT_BH_TTF_MD5		:= e8ca58ea0d3726b94fe9f2c17344be60
XORG_FONT_BH_TTF		:= font-bh-ttf-$(XORG_FONT_BH_TTF_VERSION)
XORG_FONT_BH_TTF_SUFFIX		:= tar.bz2
XORG_FONT_BH_TTF_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_BH_TTF).$(XORG_FONT_BH_TTF_SUFFIX))
XORG_FONT_BH_TTF_SOURCE		:= $(SRCDIR)/$(XORG_FONT_BH_TTF).$(XORG_FONT_BH_TTF_SUFFIX)
XORG_FONT_BH_TTF_DIR		:= $(BUILDDIR)/$(XORG_FONT_BH_TTF)
XORG_FONT_BH_TTF_LICENSE	:= Luxi

XORG_FONT_BH_TTF_CONF_TOOL	:= NO
XORG_FONT_BH_TTF_FONTDIR	:= $(XORG_FONTDIR)/truetype/bh

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bh-ttf.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bh-ttf.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_BH_TTF,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-bh-ttf.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-bh-ttf)
	@$(call install_fixup, xorg-font-bh-ttf,PRIORITY,optional)
	@$(call install_fixup, xorg-font-bh-ttf,SECTION,base)
	@$(call install_fixup, xorg-font-bh-ttf,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-bh-ttf,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-bh-ttf, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-bh-ttf)
	@$(call touch)

# vim: syntax=make

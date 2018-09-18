# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
# 		2018 by Florian Bäuerle <florian.baeuerle@allegion.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_VLGOTHIC) += xorg-font-ttf-vlgothic

#
# Paths and names
#
XORG_FONT_TTF_VLGOTHIC_VERSION	:= 20141206
XORG_FONT_TTF_VLGOTHIC_MD5	:= bb7fadb2dff09a4fb6a11dc9dfdc0c36
XORG_FONT_TTF_VLGOTHIC		:= VLGothic-$(XORG_FONT_TTF_VLGOTHIC_VERSION)
XORG_FONT_TTF_VLGOTHIC_SUFFIX	:= tar.xz
XORG_FONT_TTF_VLGOTHIC_URL	:= http://osdn.jp/frs/redir.php?m=iij&f=%2Fvlgothic%2F62375%2F$(XORG_FONT_TTF_VLGOTHIC).$(XORG_FONT_TTF_VLGOTHIC_SUFFIX)
XORG_FONT_TTF_VLGOTHIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_VLGOTHIC).$(XORG_FONT_TTF_VLGOTHIC_SUFFIX)
XORG_FONT_TTF_VLGOTHIC_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_VLGOTHIC)
XORG_FONT_TTF_VLGOTHIC_LICENSE	:= public_domain AND mplus AND BSD-3-Clause
XORG_FONT_TTF_VLGOTHIC_LICENSE_FILES := \
	file://LICENSE;md5=d2da3d6412686a977e837cae4988b624 \
	file://LICENSE_E.mplus;md5=1c4767416f20215f1e61b970f2117db9 \
	file://LICENSE.en;md5=66ecd0fd7e4da6246fa30317c7b66755 \
	file://LICENSE_J.mplus;md5=0ec236dad673c87025379b1dc91ad7bd \
	file://README.sazanami;encoding=euc-jp;md5=97d739900be6e852830f55aa3c07d4a0

XORG_FONT_TTF_VLGOTHIC_CONF_TOOL	:= NO
XORG_FONT_TTF_VLGOTHIC_FONTDIR		:= $(XORG_FONTDIR)/truetype/vlgothic

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_VLGOTHIC,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-vlgothic)
	@$(call install_fixup, xorg-font-ttf-vlgothic,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-vlgothic,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-vlgothic,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-ttf-vlgothic,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-vlgothic, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-vlgothic)
	@$(call touch)

# vim: syntax=make

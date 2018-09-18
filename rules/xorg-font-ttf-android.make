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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_ANDROID) += xorg-font-ttf-android

#
# Paths and names
#
XORG_FONT_TTF_ANDROID_VERSION		:= 4.4.4r2
XORG_FONT_TTF_ANDROID_MD5		:= 351432aab0853958b28daebf28f8a988
XORG_FONT_TTF_ANDROID			:= fonts-android_$(XORG_FONT_TTF_ANDROID_VERSION)
XORG_FONT_TTF_ANDROID_SUFFIX		:= orig.tar.xz
XORG_FONT_TTF_ANDROID_URL		:= http://snapshot.debian.org/archive/debian/20140920T101110Z/pool/main/f/fonts-android/$(XORG_FONT_TTF_ANDROID).$(XORG_FONT_TTF_ANDROID_SUFFIX)
XORG_FONT_TTF_ANDROID_SOURCE		:= $(SRCDIR)/$(XORG_FONT_TTF_ANDROID).$(XORG_FONT_TTF_ANDROID_SUFFIX)
XORG_FONT_TTF_ANDROID_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_ANDROID)
XORG_FONT_TTF_ANDROID_STRIP_LEVEL	:= 0
XORG_FONT_TTF_ANDROID_LICENSE		:= Apache-2.0
XORG_FONT_TTF_ANDROID_LICENSE_FILES	:= \
	file://NOTICE;md5=9645f39e9db895a4aa6e02cb57294595

XORG_FONT_TTF_ANDROID_CONF_TOOL		:= NO
XORG_FONT_TTF_ANDROID_FONTDIR		:= $(XORG_FONTDIR)/truetype/android

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-android.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-android.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_ANDROID,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-android.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-android)
	@$(call install_fixup, xorg-font-ttf-android,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-android,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-android,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-ttf-android,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-android, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-android)
	@$(call touch)

# vim: syntax=make

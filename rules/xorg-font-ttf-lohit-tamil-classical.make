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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL) += xorg-font-ttf-lohit-tamil-classical

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_VERSION	:= 2.5.3
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_MD5		:= 8042f874e86a87623adaea4780f03b29
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL		:= lohit-tamil-classical-ttf-$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_VERSION)
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL).$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_SUFFIX)
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL).$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_SUFFIX)
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL)
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_LICENSE_FILES := \
	file://OFL.txt;md5=e56537d157e0ee370c0d8468da33e245

XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_CONF_TOOL	:= NO
XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_FONTDIR	:= $(XORG_FONTDIR)/truetype/lohit-tamil-classical

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil-classical.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil-classical.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_PKGDIR)/etc/fonts/conf.d
	@install -m 644 $(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_DIR)/66-lohit-tamil-classical.conf \
		$(XORG_FONT_TTF_LOHIT_TAMIL_CLASSICAL_PKGDIR)/etc/fonts/conf.d
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil-classical.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-lohit-tamil-classical)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil-classical,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil-classical,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil-classical,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-tamil-classical,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-lohit-tamil-classical, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-lohit-tamil-classical, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-lohit-tamil-classical)
	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_DEVANAGARI) += xorg-font-ttf-lohit-devanagari

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_DEVANAGARI_VERSION	:= 2.95.2
XORG_FONT_TTF_LOHIT_DEVANAGARI_MD5	:= 270adeaad6758d8e94cc6217d7db5596
XORG_FONT_TTF_LOHIT_DEVANAGARI		:= lohit-devanagari-ttf-$(XORG_FONT_TTF_LOHIT_DEVANAGARI_VERSION)
XORG_FONT_TTF_LOHIT_DEVANAGARI_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_DEVANAGARI_URL	:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_DEVANAGARI).$(XORG_FONT_TTF_LOHIT_DEVANAGARI_SUFFIX)
XORG_FONT_TTF_LOHIT_DEVANAGARI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_DEVANAGARI).$(XORG_FONT_TTF_LOHIT_DEVANAGARI_SUFFIX)
XORG_FONT_TTF_LOHIT_DEVANAGARI_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_DEVANAGARI)
XORG_FONT_TTF_LOHIT_DEVANAGARI_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_DEVANAGARI_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_DEVANAGARI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-devanagari.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_DEVANAGARI_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-devanagari.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-devanagari.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-devanagari.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_DEVANAGARI_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-devanagari)
	@$(call install_fixup, xorg-font-ttf-lohit-devanagari,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-devanagari,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-devanagari,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-devanagari,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-devanagari, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_DEVANAGARI_DIR)/66-lohit-devanagari.conf, \
		/etc/fonts/conf.d/66-lohit-devanagari.conf)

	@$(call install_finish, xorg-font-ttf-lohit-devanagari)
	@$(call touch)

# vim: syntax=make

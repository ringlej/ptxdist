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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_GUJARATI) += xorg-font-ttf-lohit-gujarati

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_GUJARATI_VERSION	:= 2.92.2
XORG_FONT_TTF_LOHIT_GUJARATI_MD5	:= a2a5c30c0b1a68d59ead3cf26ce88d0b
XORG_FONT_TTF_LOHIT_GUJARATI		:= lohit-gujarati-ttf-$(XORG_FONT_TTF_LOHIT_GUJARATI_VERSION)
XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_GUJARATI_URL	:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_GUJARATI).$(XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX)
XORG_FONT_TTF_LOHIT_GUJARATI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_GUJARATI).$(XORG_FONT_TTF_LOHIT_GUJARATI_SUFFIX)
XORG_FONT_TTF_LOHIT_GUJARATI_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_GUJARATI)
XORG_FONT_TTF_LOHIT_GUJARATI_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_GUJARATI_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_GUJARATI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-gujarati.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_GUJARATI_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-gujarati.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_GUJARATI_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-gujarati)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-gujarati,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-gujarati, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_GUJARATI_DIR)/66-lohit-gujarati.conf, \
		/etc/fonts/conf.d/66-lohit-gujarati.conf)

	@$(call install_finish, xorg-font-ttf-lohit-gujarati)
	@$(call touch)

# vim: syntax=make

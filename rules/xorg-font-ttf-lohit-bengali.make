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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_BENGALI) += xorg-font-ttf-lohit-bengali

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_BENGALI_VERSION	:= 2.91.3
XORG_FONT_TTF_LOHIT_BENGALI_MD5		:= 5231064d0d3ecb16e1e0d7622463b681
XORG_FONT_TTF_LOHIT_BENGALI		:= lohit-bengali-ttf-$(XORG_FONT_TTF_LOHIT_BENGALI_VERSION)
XORG_FONT_TTF_LOHIT_BENGALI_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_BENGALI_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_BENGALI).$(XORG_FONT_TTF_LOHIT_BENGALI_SUFFIX)
XORG_FONT_TTF_LOHIT_BENGALI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_BENGALI).$(XORG_FONT_TTF_LOHIT_BENGALI_SUFFIX)
XORG_FONT_TTF_LOHIT_BENGALI_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_BENGALI)
XORG_FONT_TTF_LOHIT_BENGALI_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_BENGALI_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_BENGALI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-bengali.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_BENGALI_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-bengali.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-bengali.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-bengali.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_BENGALI_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-bengali)
	@$(call install_fixup, xorg-font-ttf-lohit-bengali,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-bengali,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-bengali,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-bengali,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-bengali, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_BENGALI_DIR)/66-lohit-bengali.conf, \
		/etc/fonts/conf.d/66-lohit-bengali.conf)

	@$(call install_finish, xorg-font-ttf-lohit-bengali)
	@$(call touch)

# vim: syntax=make

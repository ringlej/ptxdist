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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_TAMIL) += xorg-font-ttf-lohit-tamil

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_TAMIL_VERSION	:= 2.91.1
XORG_FONT_TTF_LOHIT_TAMIL_MD5		:= a05d725b19716879e81b9913735cf883
XORG_FONT_TTF_LOHIT_TAMIL		:= lohit-tamil-ttf-$(XORG_FONT_TTF_LOHIT_TAMIL_VERSION)
XORG_FONT_TTF_LOHIT_TAMIL_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_TAMIL_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_TAMIL).$(XORG_FONT_TTF_LOHIT_TAMIL_SUFFIX)
XORG_FONT_TTF_LOHIT_TAMIL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_TAMIL).$(XORG_FONT_TTF_LOHIT_TAMIL_SUFFIX)
XORG_FONT_TTF_LOHIT_TAMIL_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_TAMIL)
XORG_FONT_TTF_LOHIT_TAMIL_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_TAMIL_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_TAMIL
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-tamil.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_TAMIL_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-tamil.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_TAMIL_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-tamil)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-tamil,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-tamil,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-tamil, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_TAMIL_DIR)/66-lohit-tamil.conf, \
		/etc/fonts/conf.d/66-lohit-tamil.conf)

	@$(call install_finish, xorg-font-ttf-lohit-tamil)
	@$(call touch)

# vim: syntax=make

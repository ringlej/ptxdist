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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_ORIYA) += xorg-font-ttf-lohit-oriya

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_ORIYA_VERSION	:= 2.5.4.1
XORG_FONT_TTF_LOHIT_ORIYA_MD5		:= e79cd61631e2e8f70372a44859bc8d9b
XORG_FONT_TTF_LOHIT_ORIYA		:= lohit-oriya-ttf-$(XORG_FONT_TTF_LOHIT_ORIYA_VERSION)
XORG_FONT_TTF_LOHIT_ORIYA_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_ORIYA_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_ORIYA).$(XORG_FONT_TTF_LOHIT_ORIYA_SUFFIX)
XORG_FONT_TTF_LOHIT_ORIYA_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_ORIYA).$(XORG_FONT_TTF_LOHIT_ORIYA_SUFFIX)
XORG_FONT_TTF_LOHIT_ORIYA_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_ORIYA)
XORG_FONT_TTF_LOHIT_ORIYA_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_ORIYA_LICENSE_FILES := \
	file://OFL.txt;md5=e56537d157e0ee370c0d8468da33e245

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_ORIYA
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-oriya.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_ORIYA_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-oriya.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-oriya.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-oriya.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_ORIYA_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-oriya)
	@$(call install_fixup, xorg-font-ttf-lohit-oriya,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-oriya,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-oriya,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-oriya,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-oriya, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_ORIYA_DIR)/66-lohit-oriya.conf, \
		/etc/fonts/conf.d/66-lohit-oriya.conf)

	@$(call install_finish, xorg-font-ttf-lohit-oriya)
	@$(call touch)

# vim: syntax=make

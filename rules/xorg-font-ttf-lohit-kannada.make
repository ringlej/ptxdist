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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_KANNADA) += xorg-font-ttf-lohit-kannada

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_KANNADA_VERSION	:= 2.5.3
XORG_FONT_TTF_LOHIT_KANNADA_MD5		:= f38bec5fe7d0d850fd2cb4760f4e47ed
XORG_FONT_TTF_LOHIT_KANNADA		:= lohit-kannada-ttf-$(XORG_FONT_TTF_LOHIT_KANNADA_VERSION)
XORG_FONT_TTF_LOHIT_KANNADA_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_KANNADA_URL		:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_KANNADA).$(XORG_FONT_TTF_LOHIT_KANNADA_SUFFIX)
XORG_FONT_TTF_LOHIT_KANNADA_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_KANNADA).$(XORG_FONT_TTF_LOHIT_KANNADA_SUFFIX)
XORG_FONT_TTF_LOHIT_KANNADA_DIR		:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_KANNADA)
XORG_FONT_TTF_LOHIT_KANNADA_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_KANNADA_LICENSE_FILES := \
	file://OFL.txt;md5=e56537d157e0ee370c0d8468da33e245

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_KANNADA
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-kannada.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_KANNADA_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-kannada.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-kannada.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-kannada.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_KANNADA_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-kannada)
	@$(call install_fixup, xorg-font-ttf-lohit-kannada,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-kannada,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-kannada,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-kannada,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-kannada, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_KANNADA_DIR)/66-lohit-kannada.conf, \
		/etc/fonts/conf.d/66-lohit-kannada.conf)

	@$(call install_finish, xorg-font-ttf-lohit-kannada)
	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_LOHIT_ASSAMESE) += xorg-font-ttf-lohit-assamese

#
# Paths and names
#
XORG_FONT_TTF_LOHIT_ASSAMESE_VERSION	:= 2.91.3
XORG_FONT_TTF_LOHIT_ASSAMESE_MD5	:= 450392cdcc01373aa31b1493bafa9935
XORG_FONT_TTF_LOHIT_ASSAMESE		:= lohit-assamese-ttf-$(XORG_FONT_TTF_LOHIT_ASSAMESE_VERSION)
XORG_FONT_TTF_LOHIT_ASSAMESE_SUFFIX	:= tar.gz
XORG_FONT_TTF_LOHIT_ASSAMESE_URL	:= https://releases.pagure.org/lohit/$(XORG_FONT_TTF_LOHIT_ASSAMESE).$(XORG_FONT_TTF_LOHIT_ASSAMESE_SUFFIX)
XORG_FONT_TTF_LOHIT_ASSAMESE_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_LOHIT_ASSAMESE).$(XORG_FONT_TTF_LOHIT_ASSAMESE_SUFFIX)
XORG_FONT_TTF_LOHIT_ASSAMESE_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_LOHIT_ASSAMESE)
XORG_FONT_TTF_LOHIT_ASSAMESE_LICENSE	:= OFL-1.1
XORG_FONT_TTF_LOHIT_ASSAMESE_LICENSE_FILES := \
	file://OFL.txt;md5=7dfa0a236dc535ad2d2548e6170c4402

ifdef PTXCONF_XORG_FONT_TTF_LOHIT_ASSAMESE
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-lohit-assamese.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_TTF_LOHIT_ASSAMESE_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-assamese.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-assamese.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-lohit-assamese.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_LOHIT_ASSAMESE_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-lohit-assamese)
	@$(call install_fixup, xorg-font-ttf-lohit-assamese,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-lohit-assamese,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-lohit-assamese,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-lohit-assamese,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-ttf-lohit-assamese, 0, 0, 644, \
		$(XORG_FONT_TTF_LOHIT_ASSAMESE_DIR)/66-lohit-assamese.conf, \
		/etc/fonts/conf.d/66-lohit-assamese.conf)

	@$(call install_finish, xorg-font-ttf-lohit-assamese)
	@$(call touch)

# vim: syntax=make

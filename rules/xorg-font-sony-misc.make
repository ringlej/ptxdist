# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_SONY_MISC) += xorg-font-sony-misc

#
# Paths and names
#
XORG_FONT_SONY_MISC_VERSION	:= 1.0.3
XORG_FONT_SONY_MISC_MD5		:= beef61a9b0762aba8af7b736bb961f86
XORG_FONT_SONY_MISC		:= font-sony-misc-$(XORG_FONT_SONY_MISC_VERSION)
XORG_FONT_SONY_MISC_SUFFIX	:= tar.bz2
XORG_FONT_SONY_MISC_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_SONY_MISC).$(XORG_FONT_SONY_MISC_SUFFIX))
XORG_FONT_SONY_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_SONY_MISC).$(XORG_FONT_SONY_MISC_SUFFIX)
XORG_FONT_SONY_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_SONY_MISC)

ifdef PTXCONF_XORG_FONT_SONY_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-sony-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_SONY_MISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_SONY_MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_SONY_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_SONY_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_SONY_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-sony-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-sony-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_SONY_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_FONT_DEC_MISC) += xorg-font-dec-misc

#
# Paths and names
#
XORG_FONT_DEC_MISC_VERSION	:= 1.0.3
XORG_FONT_DEC_MISC_MD5		:= 6e7c5108f1b16d7a1c7b2c9760edd6e5
XORG_FONT_DEC_MISC		:= font-dec-misc-$(XORG_FONT_DEC_MISC_VERSION)
XORG_FONT_DEC_MISC_SUFFIX	:= tar.bz2
XORG_FONT_DEC_MISC_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_DEC_MISC).$(XORG_FONT_DEC_MISC_SUFFIX))
XORG_FONT_DEC_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_DEC_MISC).$(XORG_FONT_DEC_MISC_SUFFIX)
XORG_FONT_DEC_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_DEC_MISC)

ifdef PTXCONF_XORG_FONT_DEC_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-dec-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_DEC_MISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_DEC_MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_DEC_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_DEC_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_DEC_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-dec-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-dec-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_DEC_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch)

# vim: syntax=make

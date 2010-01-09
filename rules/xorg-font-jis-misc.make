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
PACKAGES-$(PTXCONF_XORG_FONT_JIS_MISC) += xorg-font-jis-misc

#
# Paths and names
#
XORG_FONT_JIS_MISC_VERSION	:= 1.0.1
XORG_FONT_JIS_MISC		:= font-jis-misc-$(XORG_FONT_JIS_MISC_VERSION)
XORG_FONT_JIS_MISC_SUFFIX	:= tar.bz2
XORG_FONT_JIS_MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_JIS_MISC).$(XORG_FONT_JIS_MISC_SUFFIX)
XORG_FONT_JIS_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_JIS_MISC).$(XORG_FONT_JIS_MISC_SUFFIX)
XORG_FONT_JIS_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_JIS_MISC)

ifdef PTXCONF_XORG_FONT_JIS_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-jis-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_JIS_MISC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_JIS_MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_JIS_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_JIS_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_JIS_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-jis-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-jis-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_JIS_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-jis-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-jis-misc.*
	rm -rf $(PKGDIR)/xorg-font-jis-misc_*
	rm -rf $(XORG_FONT_JIS_MISC_DIR)

# vim: syntax=make

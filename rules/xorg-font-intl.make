# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_INTL) += xorg-font-intl

#
# Paths and names
#
XORG_FONT_INTL_VERSION	:= 1.2.1
XORG_FONT_INTL_MD5	:= d77e9c4ec066a985687e5c67992677e4
XORG_FONT_INTL		:= intlfonts-$(XORG_FONT_INTL_VERSION)
XORG_FONT_INTL_SUFFIX	:= tar.gz
XORG_FONT_INTL_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/intlfonts/$(XORG_FONT_INTL).$(XORG_FONT_INTL_SUFFIX)
XORG_FONT_INTL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_INTL).$(XORG_FONT_INTL_SUFFIX)
XORG_FONT_INTL_DIR	:= $(BUILDDIR)/$(XORG_FONT_INTL)

ifdef PTXCONF_XORG_FONT_INTL
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-intl.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_INTL_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_INTL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_INTL_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_INTL_ENV 	:= $(CROSS_ENV)
XORG_FONT_INTL_MAKEVARS := \
	SUBDIRS= \
	SUBDIRS_X= \
	SUBDIRS_BIG=

ifdef PTXCONF_XORG_FONT_INTL_CHIN
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Chinese SUBDIRS_X+=Chinese.X
endif

ifdef PTXCONF_XORG_FONT_INTL_CHIN_BIG
XORG_FONT_INTL_MAKEVARS += SUBDIRS_BIG+=Chinese.BIG
endif

ifdef PTXCONF_XORG_FONT_INTL_JAP
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Japanese SUBDIRS_X+=Japanese.X
endif

ifdef PTXCONF_XORG_FONT_INTL_JAP_BIG
XORG_FONT_INTL_MAKEVARS += SUBDIRS_BIG+=Japanese.BIG
endif

ifdef PTXCONF_XORG_FONT_INTL_ASIAN
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Asian
endif

#
# autoconf
#
XORG_FONT_INTL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-compress \
	--with-fontdir=$(XORG_FONT_INTL_PKGDIR)$(XORG_FONTDIR)/misc \
	--without-bdf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-intl.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

# FIXME: font.alias handling
# FIXME: what about truetype and type1

	@find $(XORG_FONT_INTL_PKGDIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done


	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin rol
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
PACKAGES-$(PTXCONF_XORG_FONT_IBM_TYPE1) += xorg-font-ibm-type1

#
# Paths and names
#
XORG_FONT_IBM_TYPE1_VERSION	:= 1.0.3
XORG_FONT_IBM_TYPE1_MD5		:= bfb2593d2102585f45daa960f43cb3c4
XORG_FONT_IBM_TYPE1		:= font-ibm-type1-$(XORG_FONT_IBM_TYPE1_VERSION)
XORG_FONT_IBM_TYPE1_SUFFIX	:= tar.bz2
XORG_FONT_IBM_TYPE1_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_IBM_TYPE1).$(XORG_FONT_IBM_TYPE1_SUFFIX)
XORG_FONT_IBM_TYPE1_SOURCE	:= $(SRCDIR)/$(XORG_FONT_IBM_TYPE1).$(XORG_FONT_IBM_TYPE1_SUFFIX)
XORG_FONT_IBM_TYPE1_DIR		:= $(BUILDDIR)/$(XORG_FONT_IBM_TYPE1)

ifdef PTXCONF_XORG_FONT_IBM_TYPE1
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ibm-type1.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_IBM_TYPE1_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_IBM_TYPE1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_IBM_TYPE1_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_IBM_TYPE1_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_IBM_TYPE1_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/Type1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ibm-type1.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ibm-type1.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/Type1

	@find $(XORG_FONT_IBM_TYPE1_DIR) \
		-name "*.afm" \
		-o -name "*.pfa" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/Type1; \
	done

	@$(call touch)

# vim: syntax=make

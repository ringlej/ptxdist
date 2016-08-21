# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ARPHIC_UKAI) += xorg-font-arphic-ukai

#
# Paths and names
#
XORG_FONT_ARPHIC_UKAI_VERSION	:= 0.2.20080216.1
XORG_FONT_ARPHIC_UKAI_MD5	:= 4d3beb55db000bfedd18c9c7d6e631d8
XORG_FONT_ARPHIC_UKAI		:= ttf-arphic-ukai_$(XORG_FONT_ARPHIC_UKAI_VERSION)
XORG_FONT_ARPHIC_UKAI_SUFFIX	:= tar.gz
XORG_FONT_ARPHIC_UKAI_URL	:= http://snapshot.debian.org/archive/debian/20080516T000000Z/pool/main/t/ttf-arphic-ukai/$(XORG_FONT_ARPHIC_UKAI).orig.$(XORG_FONT_ARPHIC_UKAI_SUFFIX)
XORG_FONT_ARPHIC_UKAI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ARPHIC_UKAI).orig.$(XORG_FONT_ARPHIC_UKAI_SUFFIX)
XORG_FONT_ARPHIC_UKAI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ARPHIC_UKAI)
XORG_FONT_ARPHIC_UKAI_STRIP_LEVEL := 0
XORG_FONT_ARPHIC_UKAI_LICENSE	:= ARPHIC
XORG_FONT_ARPHIC_UKAI_LICENSE_FILES := \
	file://license/english/ARPHICPL.TXT;md5=4555ed88e9a72fc9562af379d07c3350

ifdef PTXCONF_XORG_FONT_ARPHIC_UKAI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-arphic-ukai.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ARPHIC_UKAI_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-ukai.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-ukai.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-ukai.targetinstall:
	@$(call targetinfo)

	@find $(XORG_FONT_ARPHIC_UKAI_DIR) \
		-name "*.ttc" | \
		while read file; do \
		install -D -v -m 644 $${file} \
			$(XORG_FONTS_DIR_INSTALL)/truetype/$$(basename $${file}); \
	done

	@$(call touch)

# vim: syntax=make

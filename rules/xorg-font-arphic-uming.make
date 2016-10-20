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
PACKAGES-$(PTXCONF_XORG_FONT_ARPHIC_UMING) += xorg-font-arphic-uming

#
# Paths and names
#
XORG_FONT_ARPHIC_UMING_VERSION	:= 0.2.20080216.1
XORG_FONT_ARPHIC_UMING_MD5	:= d219fcaf953f3eb1889399955a00379f
XORG_FONT_ARPHIC_UMING		:= ttf-arphic-uming_$(XORG_FONT_ARPHIC_UMING_VERSION)
XORG_FONT_ARPHIC_UMING_SUFFIX	:= tar.gz
XORG_FONT_ARPHIC_UMING_URL	:= http://snapshot.debian.org/archive/debian/20080516T000000Z/pool/main/t/ttf-arphic-uming/$(XORG_FONT_ARPHIC_UMING).orig.$(XORG_FONT_ARPHIC_UMING_SUFFIX)
XORG_FONT_ARPHIC_UMING_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ARPHIC_UMING).orig.$(XORG_FONT_ARPHIC_UMING_SUFFIX)
XORG_FONT_ARPHIC_UMING_DIR	:= $(BUILDDIR)/$(XORG_FONT_ARPHIC_UMING)
XORG_FONT_ARPHIC_UMING_STRIP_LEVEL := 0
XORG_FONT_ARPHIC_UMING_LICENSE	:= ARPHIC
XORG_FONT_ARPHIC_UMING_LICENSE_FILES := \
	file://license/english/ARPHICPL.TXT;md5=4555ed88e9a72fc9562af379d07c3350

ifdef PTXCONF_XORG_FONT_ARPHIC_UMING
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-arphic-uming.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ARPHIC_UMING_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-uming.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-uming.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-uming.targetinstall:
	@$(call targetinfo)

	@find $(XORG_FONT_ARPHIC_UMING_DIR) \
		-name "*.ttc" | \
		while read file; do \
		install -D -v -m 644 $${file} \
			$(XORG_FONTS_DIR_INSTALL)/truetype/$$(basename $${file}); \
	done

	@$(call touch)

# vim: syntax=make

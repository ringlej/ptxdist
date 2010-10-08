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
XORG_FONT_ARPHIC_UMING_URL	:= http://de.archive.ubuntu.com/ubuntu/pool/main/t/ttf-arphic-uming/$(XORG_FONT_ARPHIC_UMING).orig.$(XORG_FONT_ARPHIC_UMING_SUFFIX)
XORG_FONT_ARPHIC_UMING_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ARPHIC_UMING).orig.$(XORG_FONT_ARPHIC_UMING_SUFFIX)
XORG_FONT_ARPHIC_UMING_DIR	:= $(BUILDDIR)/$(XORG_FONT_ARPHIC_UMING)

ifdef PTXCONF_XORG_FONT_ARPHIC_UMING
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-arphic-uming.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_ARPHIC_UMING_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_ARPHIC_UMING)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-uming.extract:
	@$(call targetinfo)
	@$(call clean, $(XORG_FONT_ARPHIC_UMING_DIR))
	@mkdir -p $(XORG_FONT_ARPHIC_UMING_DIR)
	@$(call extract, XORG_FONT_ARPHIC_UMING, $(XORG_FONT_ARPHIC_UMING_DIR))
	@$(call patchin, XORG_FONT_ARPHIC_UMING, $(XORG_FONT_ARPHIC_UMING_DIR))
	@$(call touch)

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

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_ARPHIC_UMING_DIR) \
		-name "*.ttc" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

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
XORG_FONT_ARPHIC_UKAI		:= ttf-arphic-ukai_$(XORG_FONT_ARPHIC_UKAI_VERSION)
XORG_FONT_ARPHIC_UKAI_SUFFIX	:= tar.gz
XORG_FONT_ARPHIC_UKAI_URL	:= http://de.archive.ubuntu.com/ubuntu/pool/main/t/ttf-arphic-ukai/$(XORG_FONT_ARPHIC_UKAI).orig.$(XORG_FONT_ARPHIC_UKAI_SUFFIX)
XORG_FONT_ARPHIC_UKAI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ARPHIC_UKAI).orig.$(XORG_FONT_ARPHIC_UKAI_SUFFIX)
XORG_FONT_ARPHIC_UKAI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ARPHIC_UKAI)

ifdef PTXCONF_XORG_FONT_ARPHIC_UKAI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-arphic-ukai.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_ARPHIC_UKAI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_ARPHIC_UKAI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-arphic-ukai.extract:
	@$(call targetinfo)
	@$(call clean, $(XORG_FONT_ARPHIC_UKAI_DIR))
	@mkdir -p $(XORG_FONT_ARPHIC_UKAI_DIR)
	@$(call extract, XORG_FONT_ARPHIC_UKAI, $(XORG_FONT_ARPHIC_UKAI_DIR))
	@$(call patchin, XORG_FONT_ARPHIC_UKAI, $(XORG_FONT_ARPHIC_UKAI_DIR))
	@$(call touch)

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

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_ARPHIC_UKAI_DIR) \
		-name "*.ttc" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch)

# vim: syntax=make

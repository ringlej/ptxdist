# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ENCODINGS) += xorg-font-encodings

#
# Paths and names
#
XORG_FONT_ENCODINGS_VERSION	:= 1.0.3
XORG_FONT_ENCODINGS		:= encodings-$(XORG_FONT_ENCODINGS_VERSION)
XORG_FONT_ENCODINGS_SUFFIX	:= tar.bz2
XORG_FONT_ENCODINGS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX)
XORG_FONT_ENCODINGS_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX)
XORG_FONT_ENCODINGS_DIR		:= $(BUILDDIR)/$(XORG_FONT_ENCODINGS)

ifdef PTXCONF_XORG_FONT_ENCODINGS
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-encodings.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_ENCODINGS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_ENCODINGS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-encodings_prepare: $(STATEDIR)/xorg-font-encodings.prepare

XORG_FONT_ENCODINGS_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_ENCODINGS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ENCODINGS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-encodingsdir=$(XORG_FONTDIR)/encodings

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-encodings_targetinstall: $(STATEDIR)/xorg-font-encodings.targetinstall

$(STATEDIR)/xorg-font-encodings.targetinstall: $(xorg-font-encodings_targetinstall_deps_default)
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/encodings

# FIXME: handle encodings/large

	@find $(XORG_FONT_ENCODINGS_DIR) \
		-maxdepth 1 \
		-name "*.enc.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/encodings; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-encodings_clean:
	rm -rf $(STATEDIR)/xorg-font-encodings.*
	rm -rf $(PKGDIR)/xorg-font-encodings_*
	rm -rf $(XORG_FONT_ENCODINGS_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_FONT_BH_TTF) += xorg-font-bh-ttf

#
# Paths and names
#
XORG_FONT_BH_TTF_VERSION	:= 1.0.1
XORG_FONT_BH_TTF		:= font-bh-ttf-$(XORG_FONT_BH_TTF_VERSION)
XORG_FONT_BH_TTF_SUFFIX		:= tar.bz2
XORG_FONT_BH_TTF_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BH_TTF).$(XORG_FONT_BH_TTF_SUFFIX)
XORG_FONT_BH_TTF_SOURCE		:= $(SRCDIR)/$(XORG_FONT_BH_TTF).$(XORG_FONT_BH_TTF_SUFFIX)
XORG_FONT_BH_TTF_DIR		:= $(BUILDDIR)/$(XORG_FONT_BH_TTF)

ifdef PTXCONF_XORG_FONT_BH_TTF
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bh-ttf.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_get: $(STATEDIR)/xorg-font-bh-ttf.get

$(STATEDIR)/xorg-font-bh-ttf.get: $(xorg-font-bh-ttf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_BH_TTF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_BH_TTF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_extract: $(STATEDIR)/xorg-font-bh-ttf.extract

$(STATEDIR)/xorg-font-bh-ttf.extract: $(xorg-font-bh-ttf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_TTF_DIR))
	@$(call extract, XORG_FONT_BH_TTF)
	@$(call patchin, XORG_FONT_BH_TTF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_prepare: $(STATEDIR)/xorg-font-bh-ttf.prepare

XORG_FONT_BH_TTF_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_BH_TTF_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BH_TTF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/truetype

$(STATEDIR)/xorg-font-bh-ttf.prepare: $(xorg-font-bh-ttf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_TTF_DIR)/config.cache)
	cd $(XORG_FONT_BH_TTF_DIR) && \
		$(XORG_FONT_BH_TTF_PATH) $(XORG_FONT_BH_TTF_ENV) \
		./configure $(XORG_FONT_BH_TTF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_compile: $(STATEDIR)/xorg-font-bh-ttf.compile

$(STATEDIR)/xorg-font-bh-ttf.compile: $(xorg-font-bh-ttf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_BH_TTF_DIR) && $(XORG_FONT_BH_TTF_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_install: $(STATEDIR)/xorg-font-bh-ttf.install

$(STATEDIR)/xorg-font-bh-ttf.install: $(xorg-font-bh-ttf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_targetinstall: $(STATEDIR)/xorg-font-bh-ttf.targetinstall

$(STATEDIR)/xorg-font-bh-ttf.targetinstall: $(xorg-font-bh-ttf_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_BH_TTF_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-bh-ttf_clean:
	rm -rf $(STATEDIR)/xorg-font-bh-ttf.*
	rm -rf $(PKGDIR)/xorg-font-bh-ttf_*
	rm -rf $(XORG_FONT_BH_TTF_DIR)

# vim: syntax=make

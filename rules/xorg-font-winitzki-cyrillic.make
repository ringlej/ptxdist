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
PACKAGES-$(PTXCONF_XORG_FONT_WINITZKI_CYRILLIC) += xorg-font-winitzki-cyrillic

#
# Paths and names
#
XORG_FONT_WINITZKI_CYRILLIC_VERSION	:= 1.0.1
XORG_FONT_WINITZKI_CYRILLIC		:= font-winitzki-cyrillic-$(XORG_FONT_WINITZKI_CYRILLIC_VERSION)
XORG_FONT_WINITZKI_CYRILLIC_SUFFIX	:= tar.bz2
XORG_FONT_WINITZKI_CYRILLIC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_WINITZKI_CYRILLIC).$(XORG_FONT_WINITZKI_CYRILLIC_SUFFIX)
XORG_FONT_WINITZKI_CYRILLIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_WINITZKI_CYRILLIC).$(XORG_FONT_WINITZKI_CYRILLIC_SUFFIX)
XORG_FONT_WINITZKI_CYRILLIC_DIR		:= $(BUILDDIR)/$(XORG_FONT_WINITZKI_CYRILLIC)

ifdef PTXCONF_XORG_FONT_WINITZKI_CYRILLIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-winitzki-cyrillic.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_get: $(STATEDIR)/xorg-font-winitzki-cyrillic.get

$(STATEDIR)/xorg-font-winitzki-cyrillic.get: $(xorg-font-winitzki-cyrillic_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_WINITZKI_CYRILLIC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_WINITZKI_CYRILLIC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_extract: $(STATEDIR)/xorg-font-winitzki-cyrillic.extract

$(STATEDIR)/xorg-font-winitzki-cyrillic.extract: $(xorg-font-winitzki-cyrillic_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_WINITZKI_CYRILLIC_DIR))
	@$(call extract, XORG_FONT_WINITZKI_CYRILLIC)
	@$(call patchin, XORG_FONT_WINITZKI_CYRILLIC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_prepare: $(STATEDIR)/xorg-font-winitzki-cyrillic.prepare

XORG_FONT_WINITZKI_CYRILLIC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_WINITZKI_CYRILLIC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_WINITZKI_CYRILLIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/cyrillic


$(STATEDIR)/xorg-font-winitzki-cyrillic.prepare: $(xorg-font-winitzki-cyrillic_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_WINITZKI_CYRILLIC_DIR)/config.cache)
	cd $(XORG_FONT_WINITZKI_CYRILLIC_DIR) && \
		$(XORG_FONT_WINITZKI_CYRILLIC_PATH) $(XORG_FONT_WINITZKI_CYRILLIC_ENV) \
		./configure $(XORG_FONT_WINITZKI_CYRILLIC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_compile: $(STATEDIR)/xorg-font-winitzki-cyrillic.compile

$(STATEDIR)/xorg-font-winitzki-cyrillic.compile: $(xorg-font-winitzki-cyrillic_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_WINITZKI_CYRILLIC_DIR) && $(XORG_FONT_WINITZKI_CYRILLIC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_install: $(STATEDIR)/xorg-font-winitzki-cyrillic.install

$(STATEDIR)/xorg-font-winitzki-cyrillic.install: $(xorg-font-winitzki-cyrillic_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_targetinstall: $(STATEDIR)/xorg-font-winitzki-cyrillic.targetinstall

$(STATEDIR)/xorg-font-winitzki-cyrillic.targetinstall: $(xorg-font-winitzki-cyrillic_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/cyrillic

	@find $(XORG_FONT_WINITZKI_CYRILLIC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/cyrillic; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-winitzki-cyrillic_clean:
	rm -rf $(STATEDIR)/xorg-font-winitzki-cyrillic.*
	rm -rf $(PKGDIR)/xorg-font-winitzki-cyrillic_*
	rm -rf $(XORG_FONT_WINITZKI_CYRILLIC_DIR)

# vim: syntax=make

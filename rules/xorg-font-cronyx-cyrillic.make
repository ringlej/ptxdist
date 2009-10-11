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
PACKAGES-$(PTXCONF_XORG_FONT_CRONYX_CYRILLIC) += xorg-font-cronyx-cyrillic

#
# Paths and names
#
XORG_FONT_CRONYX_CYRILLIC_VERSION	:= 1.0.1
XORG_FONT_CRONYX_CYRILLIC		:= font-cronyx-cyrillic-$(XORG_FONT_CRONYX_CYRILLIC_VERSION)
XORG_FONT_CRONYX_CYRILLIC_SUFFIX	:= tar.bz2
XORG_FONT_CRONYX_CYRILLIC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_CRONYX_CYRILLIC).$(XORG_FONT_CRONYX_CYRILLIC_SUFFIX)
XORG_FONT_CRONYX_CYRILLIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_CRONYX_CYRILLIC).$(XORG_FONT_CRONYX_CYRILLIC_SUFFIX)
XORG_FONT_CRONYX_CYRILLIC_DIR		:= $(BUILDDIR)/$(XORG_FONT_CRONYX_CYRILLIC)

ifdef PTXCONF_XORG_FONT_CRONYX_CYRILLIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-cronyx-cyrillic.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_get: $(STATEDIR)/xorg-font-cronyx-cyrillic.get

$(STATEDIR)/xorg-font-cronyx-cyrillic.get: $(xorg-font-cronyx-cyrillic_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_CRONYX_CYRILLIC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_CRONYX_CYRILLIC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_extract: $(STATEDIR)/xorg-font-cronyx-cyrillic.extract

$(STATEDIR)/xorg-font-cronyx-cyrillic.extract: $(xorg-font-cronyx-cyrillic_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_CRONYX_CYRILLIC_DIR))
	@$(call extract, XORG_FONT_CRONYX_CYRILLIC)
	@$(call patchin, XORG_FONT_CRONYX_CYRILLIC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_prepare: $(STATEDIR)/xorg-font-cronyx-cyrillic.prepare

XORG_FONT_CRONYX_CYRILLIC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_CRONYX_CYRILLIC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_CRONYX_CYRILLIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/cyrillic

$(STATEDIR)/xorg-font-cronyx-cyrillic.prepare: $(xorg-font-cronyx-cyrillic_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_CRONYX_CYRILLIC_DIR)/config.cache)
	cd $(XORG_FONT_CRONYX_CYRILLIC_DIR) && \
		$(XORG_FONT_CRONYX_CYRILLIC_PATH) $(XORG_FONT_CRONYX_CYRILLIC_ENV) \
		./configure $(XORG_FONT_CRONYX_CYRILLIC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_compile: $(STATEDIR)/xorg-font-cronyx-cyrillic.compile

$(STATEDIR)/xorg-font-cronyx-cyrillic.compile: $(xorg-font-cronyx-cyrillic_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_CRONYX_CYRILLIC_DIR) && $(XORG_FONT_CRONYX_CYRILLIC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_install: $(STATEDIR)/xorg-font-cronyx-cyrillic.install

$(STATEDIR)/xorg-font-cronyx-cyrillic.install: $(xorg-font-cronyx-cyrillic_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_targetinstall: $(STATEDIR)/xorg-font-cronyx-cyrillic.targetinstall

$(STATEDIR)/xorg-font-cronyx-cyrillic.targetinstall: $(xorg-font-cronyx-cyrillic_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/cyrillic

	@find $(XORG_FONT_CRONYX_CYRILLIC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/cyrillic; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-cronyx-cyrillic_clean:
	rm -rf $(STATEDIR)/xorg-font-cronyx-cyrillic.*
	rm -rf $(PKGDIR)/xorg-font-cronyx-cyrillic_*
	rm -rf $(XORG_FONT_CRONYX_CYRILLIC_DIR)

# vim: syntax=make

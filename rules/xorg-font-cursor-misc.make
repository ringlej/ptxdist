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
PACKAGES-$(PTXCONF_XORG_FONT_CURSOR_MISC) += xorg-font-cursor-misc

#
# Paths and names
#
XORG_FONT_CURSOR_MISC_VERSION	:= 1.0.1
XORG_FONT_CURSOR_MISC		:= font-cursor-misc-$(XORG_FONT_CURSOR_MISC_VERSION)
XORG_FONT_CURSOR_MISC_SUFFIX	:= tar.bz2
XORG_FONT_CURSOR_MISC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_CURSOR_MISC).$(XORG_FONT_CURSOR_MISC_SUFFIX)
XORG_FONT_CURSOR_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_CURSOR_MISC).$(XORG_FONT_CURSOR_MISC_SUFFIX)
XORG_FONT_CURSOR_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_CURSOR_MISC)

ifdef PTXCONF_XORG_FONT_CURSOR_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-cursor-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_get: $(STATEDIR)/xorg-font-cursor-misc.get

$(STATEDIR)/xorg-font-cursor-misc.get: $(xorg-font-cursor-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_CURSOR_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_CURSOR_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_extract: $(STATEDIR)/xorg-font-cursor-misc.extract

$(STATEDIR)/xorg-font-cursor-misc.extract: $(xorg-font-cursor-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_CURSOR_MISC_DIR))
	@$(call extract, XORG_FONT_CURSOR_MISC)
	@$(call patchin, XORG_FONT_CURSOR_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_prepare: $(STATEDIR)/xorg-font-cursor-misc.prepare

XORG_FONT_CURSOR_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_CURSOR_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_CURSOR_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

$(STATEDIR)/xorg-font-cursor-misc.prepare: $(xorg-font-cursor-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_CURSOR_MISC_DIR)/config.cache)
	cd $(XORG_FONT_CURSOR_MISC_DIR) && \
		$(XORG_FONT_CURSOR_MISC_PATH) $(XORG_FONT_CURSOR_MISC_ENV) \
		./configure $(XORG_FONT_CURSOR_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_compile: $(STATEDIR)/xorg-font-cursor-misc.compile

$(STATEDIR)/xorg-font-cursor-misc.compile: $(xorg-font-cursor-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_CURSOR_MISC_DIR) && $(XORG_FONT_CURSOR_MISC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_install: $(STATEDIR)/xorg-font-cursor-misc.install

$(STATEDIR)/xorg-font-cursor-misc.install: $(xorg-font-cursor-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_targetinstall: $(STATEDIR)/xorg-font-cursor-misc.targetinstall

$(STATEDIR)/xorg-font-cursor-misc.targetinstall: $(xorg-font-cursor-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_CURSOR_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-cursor-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-cursor-misc.*
	rm -rf $(PKGDIR)/xorg-font-cursor-misc_*
	rm -rf $(XORG_FONT_CURSOR_MISC_DIR)

# vim: syntax=make

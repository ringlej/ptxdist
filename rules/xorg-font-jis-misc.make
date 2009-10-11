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
PACKAGES-$(PTXCONF_XORG_FONT_JIS_MISC) += xorg-font-jis-misc

#
# Paths and names
#
XORG_FONT_JIS_MISC_VERSION	:= 1.0.1
XORG_FONT_JIS_MISC		:= font-jis-misc-$(XORG_FONT_JIS_MISC_VERSION)
XORG_FONT_JIS_MISC_SUFFIX	:= tar.bz2
XORG_FONT_JIS_MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_JIS_MISC).$(XORG_FONT_JIS_MISC_SUFFIX)
XORG_FONT_JIS_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_JIS_MISC).$(XORG_FONT_JIS_MISC_SUFFIX)
XORG_FONT_JIS_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_JIS_MISC)

ifdef PTXCONF_XORG_FONT_JIS_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-jis-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-jis-misc_get: $(STATEDIR)/xorg-font-jis-misc.get

$(STATEDIR)/xorg-font-jis-misc.get: $(xorg-font-jis-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_JIS_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_JIS_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-jis-misc_extract: $(STATEDIR)/xorg-font-jis-misc.extract

$(STATEDIR)/xorg-font-jis-misc.extract: $(xorg-font-jis-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_JIS_MISC_DIR))
	@$(call extract, XORG_FONT_JIS_MISC)
	@$(call patchin, XORG_FONT_JIS_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-jis-misc_prepare: $(STATEDIR)/xorg-font-jis-misc.prepare

XORG_FONT_JIS_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_JIS_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_JIS_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

$(STATEDIR)/xorg-font-jis-misc.prepare: $(xorg-font-jis-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_JIS_MISC_DIR)/config.cache)
	cd $(XORG_FONT_JIS_MISC_DIR) && \
		$(XORG_FONT_JIS_MISC_PATH) $(XORG_FONT_JIS_MISC_ENV) \
		./configure $(XORG_FONT_JIS_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-jis-misc_compile: $(STATEDIR)/xorg-font-jis-misc.compile

$(STATEDIR)/xorg-font-jis-misc.compile: $(xorg-font-jis-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_JIS_MISC_DIR) && $(XORG_FONT_JIS_MISC_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-jis-misc_install: $(STATEDIR)/xorg-font-jis-misc.install

$(STATEDIR)/xorg-font-jis-misc.install: $(xorg-font-jis-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-jis-misc_targetinstall: $(STATEDIR)/xorg-font-jis-misc.targetinstall

$(STATEDIR)/xorg-font-jis-misc.targetinstall: $(xorg-font-jis-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_JIS_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-jis-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-jis-misc.*
	rm -rf $(PKGDIR)/xorg-font-jis-misc_*
	rm -rf $(XORG_FONT_JIS_MISC_DIR)

# vim: syntax=make

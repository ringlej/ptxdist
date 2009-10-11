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
PACKAGES-$(PTXCONF_XORG_FONT_MICRO_MISC) += xorg-font-micro-misc

#
# Paths and names
#
XORG_FONT_MICRO_MISC_VERSION	:= 1.0.1
XORG_FONT_MICRO_MISC		:= font-micro-misc-$(XORG_FONT_MICRO_MISC_VERSION)
XORG_FONT_MICRO_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MICRO_MISC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font//$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX)
XORG_FONT_MICRO_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX)
XORG_FONT_MICRO_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_MICRO_MISC)

ifdef PTXCONF_XORG_FONT_MICRO_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-micro-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-micro-misc_get: $(STATEDIR)/xorg-font-micro-misc.get

$(STATEDIR)/xorg-font-micro-misc.get: $(xorg-font-micro-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_MICRO_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_MICRO_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-micro-misc_extract: $(STATEDIR)/xorg-font-micro-misc.extract

$(STATEDIR)/xorg-font-micro-misc.extract: $(xorg-font-micro-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MICRO_MISC_DIR))
	@$(call extract, XORG_FONT_MICRO_MISC)
	@$(call patchin, XORG_FONT_MICRO_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-micro-misc_prepare: $(STATEDIR)/xorg-font-micro-misc.prepare

XORG_FONT_MICRO_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_MICRO_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MICRO_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

$(STATEDIR)/xorg-font-micro-misc.prepare: $(xorg-font-micro-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_MICRO_MISC_DIR)/config.cache)
	cd $(XORG_FONT_MICRO_MISC_DIR) && \
		$(XORG_FONT_MICRO_MISC_PATH) $(XORG_FONT_MICRO_MISC_ENV) \
		./configure $(XORG_FONT_MICRO_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-micro-misc_compile: $(STATEDIR)/xorg-font-micro-misc.compile

$(STATEDIR)/xorg-font-micro-misc.compile: $(xorg-font-micro-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_MICRO_MISC_DIR) && $(XORG_FONT_MICRO_MISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-micro-misc_install: $(STATEDIR)/xorg-font-micro-misc.install

$(STATEDIR)/xorg-font-micro-misc.install: $(xorg-font-micro-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-micro-misc_targetinstall: $(STATEDIR)/xorg-font-micro-misc.targetinstall

$(STATEDIR)/xorg-font-micro-misc.targetinstall: $(xorg-font-micro-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@find $(XORG_FONT_MICRO_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-micro-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-micro-misc.*
	rm -rf $(PKGDIR)/xorg-font-micro-misc_*
	rm -rf $(XORG_FONT_MICRO_MISC_DIR)

# vim: syntax=make

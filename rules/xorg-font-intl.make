# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_INTL) += xorg-font-intl

#
# Paths and names
#
XORG_FONT_INTL_VERSION	:= 1.2.1
XORG_FONT_INTL		:= intlfonts-$(XORG_FONT_INTL_VERSION)
XORG_FONT_INTL_SUFFIX	:= tar.gz
XORG_FONT_INTL_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/intlfonts/$(XORG_FONT_INTL).$(XORG_FONT_INTL_SUFFIX)
XORG_FONT_INTL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_INTL).$(XORG_FONT_INTL_SUFFIX)
XORG_FONT_INTL_DIR	:= $(BUILDDIR)/$(XORG_FONT_INTL)

ifdef PTXCONF_XORG_FONT_INTL
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-intl.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-intl_get: $(STATEDIR)/xorg-font-intl.get

$(STATEDIR)/xorg-font-intl.get: $(xorg-font-intl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_INTL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_INTL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-intl_extract: $(STATEDIR)/xorg-font-intl.extract

$(STATEDIR)/xorg-font-intl.extract: $(xorg-font-intl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_INTL_DIR))
	@$(call extract, XORG_FONT_INTL)
	@$(call patchin, XORG_FONT_INTL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-intl_prepare: $(STATEDIR)/xorg-font-intl.prepare

XORG_FONT_INTL_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_INTL_ENV 	:= $(CROSS_ENV)
XORG_FONT_INTL_MAKEVARS := \
	SUBDIRS= \
	SUBDIRS_X= \
	SUBDIRS_BIG=

ifdef PTXCONF_XORG_FONT_INTL_CHIN
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Chinese SUBDIRS_X+=Chinese.X
endif

ifdef PTXCONF_XORG_FONT_INTL_CHIN_BIG
XORG_FONT_INTL_MAKEVARS += SUBDIRS_BIG+=Chinese.BIG 
endif

ifdef PTXCONF_XORG_FONT_INTL_JAP
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Japanese SUBDIRS_X+=Japanese.X
endif

ifdef PTXCONF_XORG_FONT_INTL_JAP_BIG
XORG_FONT_INTL_MAKEVARS += SUBDIRS_BIG+=Japanese.BIG
endif

ifdef PTXCONF_XORG_FONT_INTL_ASIAN
XORG_FONT_INTL_MAKEVARS += SUBDIRS+=Asian
endif

#
# autoconf
#
XORG_FONT_INTL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-compress \
	--with-fontdir=$(XORG_FONT_INTL_DIR)/install \
	--without-bdf

$(STATEDIR)/xorg-font-intl.prepare: $(xorg-font-intl_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_INTL_DIR)/config.cache)
	cd $(XORG_FONT_INTL_DIR) && \
		$(XORG_FONT_INTL_PATH) $(XORG_FONT_INTL_ENV) \
		./configure $(XORG_FONT_INTL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-intl_compile: $(STATEDIR)/xorg-font-intl.compile

$(STATEDIR)/xorg-font-intl.compile: $(xorg-font-intl_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_INTL_DIR) && $(XORG_FONT_INTL_PATH) $(MAKE) $(XORG_FONT_INTL_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-intl_install: $(STATEDIR)/xorg-font-intl.install

$(STATEDIR)/xorg-font-intl.install: $(xorg-font-intl_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_FONT_INTL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-intl_targetinstall: $(STATEDIR)/xorg-font-intl.targetinstall

$(STATEDIR)/xorg-font-intl.targetinstall: $(xorg-font-intl_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

# FIXME: font.alias handling
# FIXME: what about truetype and type1

	@find $(XORG_FONT_INTL_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done


	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-intl_clean:
	rm -rf $(STATEDIR)/xorg-font-intl.*
	rm -rf $(PKGDIR)/xorg-font-intl_*
	rm -rf $(XORG_FONT_INTL_DIR)

# vim: syntax=make

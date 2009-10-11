# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_MKFONTSCALE) += xorg-app-mkfontscale

#
# Paths and names
#
XORG_APP_MKFONTSCALE_VERSION	:= 1.0.7
XORG_APP_MKFONTSCALE		:= mkfontscale-$(XORG_APP_MKFONTSCALE_VERSION)
XORG_APP_MKFONTSCALE_SUFFIX	:= tar.bz2
XORG_APP_MKFONTSCALE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_MKFONTSCALE).$(XORG_APP_MKFONTSCALE_SUFFIX)
XORG_APP_MKFONTSCALE_SOURCE	:= $(SRCDIR)/$(XORG_APP_MKFONTSCALE).$(XORG_APP_MKFONTSCALE_SUFFIX)
XORG_APP_MKFONTSCALE_DIR	:= $(BUILDDIR)/$(XORG_APP_MKFONTSCALE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_get: $(STATEDIR)/xorg-app-mkfontscale.get

$(STATEDIR)/xorg-app-mkfontscale.get: $(xorg-app-mkfontscale_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_MKFONTSCALE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_MKFONTSCALE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_extract: $(STATEDIR)/xorg-app-mkfontscale.extract

$(STATEDIR)/xorg-app-mkfontscale.extract: $(xorg-app-mkfontscale_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_MKFONTSCALE_DIR))
	@$(call extract, XORG_APP_MKFONTSCALE)
	@$(call patchin, XORG_APP_MKFONTSCALE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_prepare: $(STATEDIR)/xorg-app-mkfontscale.prepare

XORG_APP_MKFONTSCALE_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_MKFONTSCALE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_MKFONTSCALE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-mkfontscale.prepare: $(xorg-app-mkfontscale_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_MKFONTSCALE_DIR)/config.cache)
	cd $(XORG_APP_MKFONTSCALE_DIR) && \
		$(XORG_APP_MKFONTSCALE_PATH) $(XORG_APP_MKFONTSCALE_ENV) \
		./configure $(XORG_APP_MKFONTSCALE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_compile: $(STATEDIR)/xorg-app-mkfontscale.compile

$(STATEDIR)/xorg-app-mkfontscale.compile: $(xorg-app-mkfontscale_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_MKFONTSCALE_DIR) && $(XORG_APP_MKFONTSCALE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_install: $(STATEDIR)/xorg-app-mkfontscale.install

$(STATEDIR)/xorg-app-mkfontscale.install: $(xorg-app-mkfontscale_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_MKFONTSCALE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_targetinstall: $(STATEDIR)/xorg-app-mkfontscale.targetinstall

$(STATEDIR)/xorg-app-mkfontscale.targetinstall: $(xorg-app-mkfontscale_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-mkfontscale)
	@$(call install_fixup, xorg-app-mkfontscale,PACKAGE,xorg-app-mkfontscale)
	@$(call install_fixup, xorg-app-mkfontscale,PRIORITY,optional)
	@$(call install_fixup, xorg-app-mkfontscale,VERSION,$(XORG_APP_MKFONTSCALE_VERSION))
	@$(call install_fixup, xorg-app-mkfontscale,SECTION,base)
	@$(call install_fixup, xorg-app-mkfontscale,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-app-mkfontscale,DEPENDS,)
	@$(call install_fixup, xorg-app-mkfontscale,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-mkfontscale, 0, 0, 0755, \
		$(XORG_APP_MKFONTSCALE_DIR)/mkfontscale, \
		/usr/bin/mkfontscale)

	@$(call install_finish, xorg-app-mkfontscale)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-mkfontscale_clean:
	rm -rf $(STATEDIR)/xorg-app-mkfontscale.*
	rm -rf $(PKGDIR)/xorg-app-mkfontscale_*
	rm -rf $(XORG_APP_MKFONTSCALE_DIR)

# vim: syntax=make

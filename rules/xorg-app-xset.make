# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
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
PACKAGES-$(PTXCONF_XORG_APP_XSET) += xorg-app-xset

#
# Paths and names
#
XORG_APP_XSET_VERSION	:= 1.1.0
XORG_APP_XSET		:= xset-$(XORG_APP_XSET_VERSION)
XORG_APP_XSET_SUFFIX	:= tar.bz2
XORG_APP_XSET_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX)
XORG_APP_XSET_SOURCE	:= $(SRCDIR)/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX)
XORG_APP_XSET_DIR	:= $(BUILDDIR)/$(XORG_APP_XSET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xset_get: $(STATEDIR)/xorg-app-xset.get

$(STATEDIR)/xorg-app-xset.get: $(xorg-app-xset_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XSET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XSET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xset_extract: $(STATEDIR)/xorg-app-xset.extract

$(STATEDIR)/xorg-app-xset.extract: $(xorg-app-xset_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XSET_DIR))
	@$(call extract, XORG_APP_XSET)
	@$(call patchin, XORG_APP_XSET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xset_prepare: $(STATEDIR)/xorg-app-xset.prepare

XORG_APP_XSET_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XSET_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XSET_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xset.prepare: $(xorg-app-xset_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XSET_DIR)/config.cache)
	cd $(XORG_APP_XSET_DIR) && \
		$(XORG_APP_XSET_PATH) $(XORG_APP_XSET_ENV) \
		./configure $(XORG_APP_XSET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xset_compile: $(STATEDIR)/xorg-app-xset.compile

$(STATEDIR)/xorg-app-xset.compile: $(xorg-app-xset_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XSET_DIR) && $(XORG_APP_XSET_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xset_install: $(STATEDIR)/xorg-app-xset.install

$(STATEDIR)/xorg-app-xset.install: $(xorg-app-xset_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XSET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xset_targetinstall: $(STATEDIR)/xorg-app-xset.targetinstall

$(STATEDIR)/xorg-app-xset.targetinstall: $(xorg-app-xset_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xset)
	@$(call install_fixup,xorg-app-xset,PACKAGE,xorg-app-xset)
	@$(call install_fixup,xorg-app-xset,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xset,VERSION,$(XORG_APP_XSET_VERSION))
	@$(call install_fixup,xorg-app-xset,SECTION,base)
	@$(call install_fixup,xorg-app-xset,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-xset,DEPENDS,)
	@$(call install_fixup,xorg-app-xset,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xset, 0, 0, 0755, $(XORG_APP_XSET_DIR)/xset, /usr/bin/xset)

	@$(call install_finish,xorg-app-xset)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xset_clean:
	rm -rf $(STATEDIR)/xorg-app-xset.*
	rm -rf $(PKGDIR)/xorg-app-xset_*
	rm -rf $(XORG_APP_XSET_DIR)

# vim: syntax=make

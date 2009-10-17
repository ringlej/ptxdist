# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
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
PACKAGES-$(PTXCONF_XORG_DATA_XBITMAPS) += xorg-data-xbitmaps

#
# Paths and names
#
XORG_DATA_XBITMAPS_VERSION	:= 1.1.0
XORG_DATA_XBITMAPS		:= xbitmaps-$(XORG_DATA_XBITMAPS_VERSION)
XORG_DATA_XBITMAPS_SUFFIX	:= tar.bz2
XORG_DATA_XBITMAPS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX)
XORG_DATA_XBITMAPS_SOURCE	:= $(SRCDIR)/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX)
XORG_DATA_XBITMAPS_DIR		:= $(BUILDDIR)/$(XORG_DATA_XBITMAPS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_get: $(STATEDIR)/xorg-data-xbitmaps.get

$(STATEDIR)/xorg-data-xbitmaps.get: $(xorg-data-xbitmaps_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DATA_XBITMAPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DATA_XBITMAPS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_extract: $(STATEDIR)/xorg-data-xbitmaps.extract

$(STATEDIR)/xorg-data-xbitmaps.extract: $(xorg-data-xbitmaps_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DATA_XBITMAPS_DIR))
	@$(call extract, XORG_DATA_XBITMAPS)
	@$(call patchin, XORG_DATA_XBITMAPS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_prepare: $(STATEDIR)/xorg-data-xbitmaps.prepare

XORG_DATA_XBITMAPS_PATH	:=  PATH=$(CROSS_PATH)
XORG_DATA_XBITMAPS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DATA_XBITMAPS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-data-xbitmaps.prepare: $(xorg-data-xbitmaps_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DATA_XBITMAPS_DIR)/config.cache)
	cd $(XORG_DATA_XBITMAPS_DIR) && \
		$(XORG_DATA_XBITMAPS_PATH) $(XORG_DATA_XBITMAPS_ENV) \
		./configure $(XORG_DATA_XBITMAPS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_compile: $(STATEDIR)/xorg-data-xbitmaps.compile

$(STATEDIR)/xorg-data-xbitmaps.compile: $(xorg-data-xbitmaps_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DATA_XBITMAPS_DIR) && $(XORG_DATA_XBITMAPS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_install: $(STATEDIR)/xorg-data-xbitmaps.install

$(STATEDIR)/xorg-data-xbitmaps.install: $(xorg-data-xbitmaps_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DATA_XBITMAPS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_targetinstall: $(STATEDIR)/xorg-data-xbitmaps.targetinstall

$(STATEDIR)/xorg-data-xbitmaps.targetinstall: $(xorg-data-xbitmaps_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-data-xbitmaps_clean:
	rm -rf $(STATEDIR)/xorg-data-xbitmaps.*
	rm -rf $(PKGDIR)/xorg-data-xbitmaps_*
	rm -rf $(XORG_DATA_XBITMAPS_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_APP_RGB) += xorg-app-rgb

#
# Paths and names
#
XORG_APP_RGB_VERSION	:= 1.0.1
XORG_APP_RGB		:= rgb-$(XORG_APP_RGB_VERSION)
XORG_APP_RGB_SUFFIX	:= tar.bz2
XORG_APP_RGB_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/app/$(XORG_APP_RGB).$(XORG_APP_RGB_SUFFIX)
XORG_APP_RGB_SOURCE	:= $(SRCDIR)/$(XORG_APP_RGB).$(XORG_APP_RGB_SUFFIX)
XORG_APP_RGB_DIR	:= $(BUILDDIR)/$(XORG_APP_RGB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-rgb_get: $(STATEDIR)/xorg-app-rgb.get

$(STATEDIR)/xorg-app-rgb.get: $(xorg-app-rgb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_RGB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_RGB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-rgb_extract: $(STATEDIR)/xorg-app-rgb.extract

$(STATEDIR)/xorg-app-rgb.extract: $(xorg-app-rgb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_RGB_DIR))
	@$(call extract, XORG_APP_RGB)
	@$(call patchin, XORG_APP_RGB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-rgb_prepare: $(STATEDIR)/xorg-app-rgb.prepare

XORG_APP_RGB_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_RGB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
# FIXME: importance of switch
#   --with-rgb-db-type=(text|dbm|ndbm) rgb database type (default is text)
#
XORG_APP_RGB_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking --datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-rgb.prepare: $(xorg-app-rgb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_RGB_DIR)/config.cache)
	cd $(XORG_APP_RGB_DIR) && \
		$(XORG_APP_RGB_PATH) $(XORG_APP_RGB_ENV) \
		./configure $(XORG_APP_RGB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-rgb_compile: $(STATEDIR)/xorg-app-rgb.compile

$(STATEDIR)/xorg-app-rgb.compile: $(xorg-app-rgb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_RGB_DIR) && $(XORG_APP_RGB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-rgb_install: $(STATEDIR)/xorg-app-rgb.install

$(STATEDIR)/xorg-app-rgb.install: $(xorg-app-rgb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_RGB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-rgb_targetinstall: $(STATEDIR)/xorg-app-rgb.targetinstall

$(STATEDIR)/xorg-app-rgb.targetinstall: $(xorg-app-rgb_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-rgb)
	@$(call install_fixup,xorg-app-rgb,PACKAGE,xorg-app-rgb)
	@$(call install_fixup,xorg-app-rgb,PRIORITY,optional)
	@$(call install_fixup,xorg-app-rgb,VERSION,$(XORG_APP_RGB_VERSION))
	@$(call install_fixup,xorg-app-rgb,SECTION,base)
	@$(call install_fixup,xorg-app-rgb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-rgb,DEPENDS,)
	@$(call install_fixup,xorg-app-rgb,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-rgb, 0, 0, 0644, \
		$(XORG_APP_RGB_DIR)/rgb.txt, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/rgb.txt, n)

	@$(call install_finish,xorg-app-rgb)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-rgb_clean:
	rm -rf $(STATEDIR)/xorg-app-rgb.*
	rm -rf $(PKGDIR)/xorg-app-rgb_*
	rm -rf $(XORG_APP_RGB_DIR)

# vim: syntax=make

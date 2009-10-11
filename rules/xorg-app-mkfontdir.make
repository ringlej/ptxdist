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
PACKAGES-$(PTXCONF_XORG_APP_MKFONTDIR) += xorg-app-mkfontdir

#
# Paths and names
#
XORG_APP_MKFONTDIR_VERSION	:= 1.0.5
XORG_APP_MKFONTDIR		:= mkfontdir-$(XORG_APP_MKFONTDIR_VERSION)
XORG_APP_MKFONTDIR_SUFFIX	:= tar.bz2
XORG_APP_MKFONTDIR_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_MKFONTDIR).$(XORG_APP_MKFONTDIR_SUFFIX)
XORG_APP_MKFONTDIR_SOURCE	:= $(SRCDIR)/$(XORG_APP_MKFONTDIR).$(XORG_APP_MKFONTDIR_SUFFIX)
XORG_APP_MKFONTDIR_DIR		:= $(BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_get: $(STATEDIR)/xorg-app-mkfontdir.get

$(STATEDIR)/xorg-app-mkfontdir.get: $(xorg-app-mkfontdir_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_MKFONTDIR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_extract: $(STATEDIR)/xorg-app-mkfontdir.extract

$(STATEDIR)/xorg-app-mkfontdir.extract: $(xorg-app-mkfontdir_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_MKFONTDIR_DIR))
	@$(call extract, XORG_APP_MKFONTDIR)
	@$(call patchin, XORG_APP_MKFONTDIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_prepare: $(STATEDIR)/xorg-app-mkfontdir.prepare

XORG_APP_MKFONTDIR_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_MKFONTDIR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_MKFONTDIR_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-mkfontdir.prepare: $(xorg-app-mkfontdir_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_MKFONTDIR_DIR)/config.cache)
	cd $(XORG_APP_MKFONTDIR_DIR) && \
		$(XORG_APP_MKFONTDIR_PATH) $(XORG_APP_MKFONTDIR_ENV) \
		./configure $(XORG_APP_MKFONTDIR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_compile: $(STATEDIR)/xorg-app-mkfontdir.compile

$(STATEDIR)/xorg-app-mkfontdir.compile: $(xorg-app-mkfontdir_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_MKFONTDIR_DIR) && $(XORG_APP_MKFONTDIR_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_install: $(STATEDIR)/xorg-app-mkfontdir.install

$(STATEDIR)/xorg-app-mkfontdir.install: $(xorg-app-mkfontdir_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_MKFONTDIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_targetinstall: $(STATEDIR)/xorg-app-mkfontdir.targetinstall

$(STATEDIR)/xorg-app-mkfontdir.targetinstall: $(xorg-app-mkfontdir_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-mkfontdir)
	@$(call install_fixup, xorg-app-mkfontdir,PACKAGE,xorg-app-mkfontdir)
	@$(call install_fixup, xorg-app-mkfontdir,PRIORITY,optional)
	@$(call install_fixup, xorg-app-mkfontdir,VERSION,$(XORG_APP_MKFONTDIR_VERSION))
	@$(call install_fixup, xorg-app-mkfontdir,SECTION,base)
	@$(call install_fixup, xorg-app-mkfontdir,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-app-mkfontdir,DEPENDS,)
	@$(call install_fixup, xorg-app-mkfontdir,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-mkfontdir, 0, 0, 0755, \
		$(XORG_APP_MKFONTDIR_DIR)/mkfontdir, \
		/usr/bin/mkfontdir, n)

	@$(call install_finish, xorg-app-mkfontdir)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-mkfontdir_clean:
	rm -rf $(STATEDIR)/xorg-app-mkfontdir.*
	rm -rf $(PKGDIR)/xorg-app-mkfontdir_*
	rm -rf $(XORG_APP_MKFONTDIR_DIR)

# vim: syntax=make

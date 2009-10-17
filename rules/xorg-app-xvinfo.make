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
PACKAGES-$(PTXCONF_XORG_APP_XVINFO) += xorg-app-xvinfo

#
# Paths and names
#
XORG_APP_XVINFO_VERSION	:= 1.1.0
XORG_APP_XVINFO		:= xvinfo-$(XORG_APP_XVINFO_VERSION)
XORG_APP_XVINFO_SUFFIX	:= tar.bz2
XORG_APP_XVINFO_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XVINFO).$(XORG_APP_XVINFO_SUFFIX)
XORG_APP_XVINFO_SOURCE	:= $(SRCDIR)/$(XORG_APP_XVINFO).$(XORG_APP_XVINFO_SUFFIX)
XORG_APP_XVINFO_DIR	:= $(BUILDDIR)/$(XORG_APP_XVINFO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xvinfo_get: $(STATEDIR)/xorg-app-xvinfo.get

$(STATEDIR)/xorg-app-xvinfo.get: $(xorg-app-xvinfo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XVINFO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XVINFO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xvinfo_extract: $(STATEDIR)/xorg-app-xvinfo.extract

$(STATEDIR)/xorg-app-xvinfo.extract: $(xorg-app-xvinfo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XVINFO_DIR))
	@$(call extract, XORG_APP_XVINFO)
	@$(call patchin, XORG_APP_XVINFO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xvinfo_prepare: $(STATEDIR)/xorg-app-xvinfo.prepare

XORG_APP_XVINFO_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XVINFO_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XVINFO_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xvinfo.prepare: $(xorg-app-xvinfo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XVINFO_DIR)/config.cache)
	cd $(XORG_APP_XVINFO_DIR) && \
		$(XORG_APP_XVINFO_PATH) $(XORG_APP_XVINFO_ENV) \
		./configure $(XORG_APP_XVINFO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xvinfo_compile: $(STATEDIR)/xorg-app-xvinfo.compile

$(STATEDIR)/xorg-app-xvinfo.compile: $(xorg-app-xvinfo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XVINFO_DIR) && $(XORG_APP_XVINFO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xvinfo_install: $(STATEDIR)/xorg-app-xvinfo.install

$(STATEDIR)/xorg-app-xvinfo.install: $(xorg-app-xvinfo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XVINFO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xvinfo_targetinstall: $(STATEDIR)/xorg-app-xvinfo.targetinstall

$(STATEDIR)/xorg-app-xvinfo.targetinstall: $(xorg-app-xvinfo_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xvinfo)
	@$(call install_fixup,xorg-app-xvinfo,PACKAGE,xorg-app-xvinfo)
	@$(call install_fixup,xorg-app-xvinfo,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xvinfo,VERSION,$(XORG_APP_XVINFO_VERSION))
	@$(call install_fixup,xorg-app-xvinfo,SECTION,base)
	@$(call install_fixup,xorg-app-xvinfo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-xvinfo,DEPENDS,)
	@$(call install_fixup,xorg-app-xvinfo,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xvinfo, 0, 0, 0755, $(XORG_APP_XVINFO_DIR)/xvinfo, $(XORG_BINDIR)/xvinfo)

	@$(call install_finish,xorg-app-xvinfo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xvinfo_clean:
	rm -rf $(STATEDIR)/xorg-app-xvinfo.*
	rm -rf $(PKGDIR)/xorg-app-xvinfo_*
	rm -rf $(XORG_APP_XVINFO_DIR)

# vim: syntax=make

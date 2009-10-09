# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
PACKAGES-$(PTXCONF_XORG_APP_XEYES) += xorg-app-xeyes

#
# Paths and names
#
XORG_APP_XEYES_VERSION	:= 1.0.991
XORG_APP_XEYES		:= xeyes-$(XORG_APP_XEYES_VERSION)
XORG_APP_XEYES_SUFFIX	:= tar.bz2
XORG_APP_XEYES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XEYES).$(XORG_APP_XEYES_SUFFIX)
XORG_APP_XEYES_SOURCE	:= $(SRCDIR)/$(XORG_APP_XEYES).$(XORG_APP_XEYES_SUFFIX)
XORG_APP_XEYES_DIR	:= $(BUILDDIR)/$(XORG_APP_XEYES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xeyes_get: $(STATEDIR)/xorg-app-xeyes.get

$(STATEDIR)/xorg-app-xeyes.get: $(xorg-app-xeyes_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XEYES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XEYES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xeyes_extract: $(STATEDIR)/xorg-app-xeyes.extract

$(STATEDIR)/xorg-app-xeyes.extract: $(xorg-app-xeyes_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XEYES_DIR))
	@$(call extract, XORG_APP_XEYES)
	@$(call patchin, XORG_APP_XEYES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xeyes_prepare: $(STATEDIR)/xorg-app-xeyes.prepare

XORG_APP_XEYES_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XEYES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XEYES_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xeyes.prepare: $(xorg-app-xeyes_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XEYES_DIR)/config.cache)
	cd $(XORG_APP_XEYES_DIR) && \
		$(XORG_APP_XEYES_PATH) $(XORG_APP_XEYES_ENV) \
		./configure $(XORG_APP_XEYES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xeyes_compile: $(STATEDIR)/xorg-app-xeyes.compile

$(STATEDIR)/xorg-app-xeyes.compile: $(xorg-app-xeyes_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XEYES_DIR) && $(XORG_APP_XEYES_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xeyes_install: $(STATEDIR)/xorg-app-xeyes.install

$(STATEDIR)/xorg-app-xeyes.install: $(xorg-app-xeyes_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XEYES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xeyes_targetinstall: $(STATEDIR)/xorg-app-xeyes.targetinstall

$(STATEDIR)/xorg-app-xeyes.targetinstall: $(xorg-app-xeyes_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xeyes)
	@$(call install_fixup, xorg-app-xeyes,PACKAGE,xorg-app-xeyes)
	@$(call install_fixup, xorg-app-xeyes,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xeyes,VERSION,$(XORG_APP_XEYES_VERSION))
	@$(call install_fixup, xorg-app-xeyes,SECTION,base)
	@$(call install_fixup, xorg-app-xeyes,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-app-xeyes,DEPENDS,)
	@$(call install_fixup, xorg-app-xeyes,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xeyes, 0, 0, 0755, $(XORG_APP_XEYES_DIR)/xeyes, $(XORG_PREFIX)/bin/xeyes)

	@$(call install_finish, xorg-app-xeyes)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xeyes_clean:
	rm -rf $(STATEDIR)/xorg-app-xeyes.*
	rm -rf $(PKGDIR)/xorg-app-xeyes_*
	rm -rf $(XORG_APP_XEYES_DIR)

# vim: syntax=make

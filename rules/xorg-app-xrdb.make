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
PACKAGES-$(PTXCONF_XORG_APP_XRDB) += xorg-app-xrdb

#
# Paths and names
#
XORG_APP_XRDB_VERSION	:= 1.0.6
XORG_APP_XRDB		:= xrdb-$(XORG_APP_XRDB_VERSION)
XORG_APP_XRDB_SUFFIX	:= tar.bz2
XORG_APP_XRDB_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XRDB).$(XORG_APP_XRDB_SUFFIX)
XORG_APP_XRDB_SOURCE	:= $(SRCDIR)/$(XORG_APP_XRDB).$(XORG_APP_XRDB_SUFFIX)
XORG_APP_XRDB_DIR	:= $(BUILDDIR)/$(XORG_APP_XRDB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xrdb_get: $(STATEDIR)/xorg-app-xrdb.get

$(STATEDIR)/xorg-app-xrdb.get: $(xorg-app-xrdb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XRDB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XRDB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xrdb_extract: $(STATEDIR)/xorg-app-xrdb.extract

$(STATEDIR)/xorg-app-xrdb.extract: $(xorg-app-xrdb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XRDB_DIR))
	@$(call extract, XORG_APP_XRDB)
	@$(call patchin, XORG_APP_XRDB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xrdb_prepare: $(STATEDIR)/xorg-app-xrdb.prepare

XORG_APP_XRDB_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XRDB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XRDB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-app-xrdb.prepare: $(xorg-app-xrdb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XRDB_DIR)/config.cache)
	cd $(XORG_APP_XRDB_DIR) && \
		$(XORG_APP_XRDB_PATH) $(XORG_APP_XRDB_ENV) \
		./configure $(XORG_APP_XRDB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xrdb_compile: $(STATEDIR)/xorg-app-xrdb.compile

$(STATEDIR)/xorg-app-xrdb.compile: $(xorg-app-xrdb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XRDB_DIR) && $(XORG_APP_XRDB_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xrdb_install: $(STATEDIR)/xorg-app-xrdb.install

$(STATEDIR)/xorg-app-xrdb.install: $(xorg-app-xrdb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XRDB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xrdb_targetinstall: $(STATEDIR)/xorg-app-xrdb.targetinstall

$(STATEDIR)/xorg-app-xrdb.targetinstall: $(xorg-app-xrdb_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xrdb)
	@$(call install_fixup,xorg-app-xrdb,PACKAGE,xorg-app-xrdb)
	@$(call install_fixup,xorg-app-xrdb,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xrdb,VERSION,$(XORG_APP_XRDB_VERSION))
	@$(call install_fixup,xorg-app-xrdb,SECTION,base)
	@$(call install_fixup,xorg-app-xrdb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-xrdb,DEPENDS,)
	@$(call install_fixup,xorg-app-xrdb,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xrdb, 0, 0, 0755, $(XORG_APP_XRDB_DIR)/xrdb, $(XORG_PREFIX)/bin/xrdb)

	@$(call install_finish,xorg-app-xrdb)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xrdb_clean:
	rm -rf $(STATEDIR)/xorg-app-xrdb.*
	rm -rf $(PKGDIR)/xorg-app-xrdb_*
	rm -rf $(XORG_APP_XRDB_DIR)

# vim: syntax=make

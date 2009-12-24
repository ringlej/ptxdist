# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007, 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_MINGW)-$(PTXCONF_WINE) += wine

#
# Paths and names
#
WINE_VERSION	:= 1.0.1
WINE		:= wine-$(WINE_VERSION)
WINE_SUFFIX	:= tar.bz2
WINE_URL	:= $(PTXCONF_SETUP_SFMIRROR)/wine/$(WINE).$(WINE_SUFFIX)
WINE_SOURCE	:= $(SRCDIR)/$(WINE).$(WINE_SUFFIX)
WINE_DIR	:= $(BUILDDIR)/$(WINE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wine_get: $(STATEDIR)/wine.get

$(STATEDIR)/wine.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(WINE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, WINE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wine_extract: $(STATEDIR)/wine.extract

$(STATEDIR)/wine.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(WINE_DIR))
	@$(call extract, WINE)
	@$(call patchin, WINE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wine_prepare: $(STATEDIR)/wine.prepare

$(STATEDIR)/wine.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wine_compile: $(STATEDIR)/wine.compile

$(STATEDIR)/wine.compile:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wine_install: $(STATEDIR)/wine.install

$(STATEDIR)/wine.install:
	@$(call targetinfo, $@)
	install -m644 $(WINE_DIR)/include/usp10.h $(SYSROOT)/usr/include/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wine_targetinstall: $(STATEDIR)/wine.targetinstall

$(STATEDIR)/wine.targetinstall:
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wine_clean:
	rm -rf $(STATEDIR)/wine.*
	rm -rf $(PKGDIR)/wine_*
	rm -rf $(WINE_DIR)

# vim: syntax=make

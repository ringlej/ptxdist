# -*-makefile-*-
#
# Copyright (C) 2007, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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

$(WINE_SOURCE):
	@$(call targetinfo)
	@$(call get, WINE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.install:
	@$(call targetinfo)
	install -m644 $(WINE_DIR)/include/usp10.h $(SYSROOT)/usr/include/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.targetinstall:
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wine_clean:
	rm -rf $(STATEDIR)/wine.*
	rm -rf $(PKGDIR)/wine_*
	rm -rf $(WINE_DIR)

# vim: syntax=make

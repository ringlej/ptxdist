# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFTDI) += libftdi

#
# Paths and names
#
LIBFTDI_VERSION	:= 0.16
LIBFTDI		:= libftdi-$(LIBFTDI_VERSION)
LIBFTDI_SUFFIX	:= tar.gz
LIBFTDI_URL	:= http://www.intra2net.com/en/developer/libftdi/download/$(LIBFTDI).$(LIBFTDI_SUFFIX)
LIBFTDI_SOURCE	:= $(SRCDIR)/$(LIBFTDI).$(LIBFTDI_SUFFIX)
LIBFTDI_DIR	:= $(BUILDDIR)/$(LIBFTDI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBFTDI_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBFTDI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBFTDI_DIR))
	@$(call extract, LIBFTDI)
	@$(call patchin, LIBFTDI)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFTDI_PATH	:= PATH=$(CROSS_PATH)

LIBFTDI_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_HAVELIBUSB='$(PTXDIST_SYSROOT_CROSS)/bin/$(COMPILER_PREFIX)pkg-config libusb'

#
# autoconf
#
LIBFTDI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static

ifndef PTXCONF_LIBFTDI_CPP_WRAPPER
LIBFTDI_AUTOCONF += --enable-libftdipp=no
endif

$(STATEDIR)/libftdi.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBFTDI_DIR)/config.cache)
	cd $(LIBFTDI_DIR) && \
		$(LIBFTDI_PATH) $(LIBFTDI_ENV) \
		./configure $(LIBFTDI_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi.compile:
	@$(call targetinfo)
	cd $(LIBFTDI_DIR) && $(LIBFTDI_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi.install:
	@$(call targetinfo)
	@$(call install, LIBFTDI)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libftdi)
	@$(call install_fixup, libftdi,PACKAGE,libftdi)
	@$(call install_fixup, libftdi,PRIORITY,optional)
	@$(call install_fixup, libftdi,VERSION,$(LIBFTDI_VERSION))
	@$(call install_fixup, libftdi,SECTION,base)
	@$(call install_fixup, libftdi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libftdi,DEPENDS,)
	@$(call install_fixup, libftdi,DESCRIPTION,missing)

	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang_ft2232)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang2)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/find_all)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang_cbus)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/simple)

	@$(call install_copy, libftdi, 0, 0, 0644, -, /usr/lib/libftdi.so.1.16.0)
	@$(call install_link, libftdi, libftdi.so.1.16.0, /usr/lib/libftdi.so.1)
	@$(call install_link, libftdi, libftdi.so.1.16.0, /usr/lib/libftdi.so)

	@$(call install_finish, libftdi)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libftdi_clean:
	rm -rf $(STATEDIR)/libftdi.*
	rm -rf $(PKGDIR)/libftdi_*
	rm -rf $(LIBFTDI_DIR)

# vim: syntax=make

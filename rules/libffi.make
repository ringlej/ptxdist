# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFFI) += libffi

#
# Paths and names
#
LIBFFI_VERSION	:= 3.0.7
LIBFFI		:= libffi-$(LIBFFI_VERSION)
LIBFFI_SUFFIX	:= tar.gz
LIBFFI_URL	:= ftp://sourceware.org/pub/libffi/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_SOURCE	:= $(SRCDIR)/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_DIR	:= $(BUILDDIR)/$(LIBFFI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBFFI_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBFFI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBFFI_DIR))
	@$(call extract, LIBFFI)
	@$(call patchin, LIBFFI)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFFI_PATH	:= PATH=$(CROSS_PATH)
LIBFFI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBFFI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libffi.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBFFI_DIR)/config.cache)
	cd $(LIBFFI_DIR) && \
		$(LIBFFI_PATH) $(LIBFFI_ENV) \
		./configure $(LIBFFI_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.compile:
	@$(call targetinfo)
	cd $(LIBFFI_DIR) && $(LIBFFI_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.install:
	@$(call targetinfo)
	@$(call install, LIBFFI)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libffi)
	@$(call install_fixup, libffi,PACKAGE,libffi)
	@$(call install_fixup, libffi,PRIORITY,optional)
	@$(call install_fixup, libffi,VERSION,$(LIBFFI_VERSION))
	@$(call install_fixup, libffi,SECTION,base)
	@$(call install_fixup, libffi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libffi,DEPENDS,)
	@$(call install_fixup, libffi,DESCRIPTION,missing)

	@$(call install_copy, libffi, 0, 0, 0644, \
		$(LIBFFI_DIR)/.libs/libffi.so.5.0.8, \
		/usr/lib/libffi.so.5.0.8)
	@$(call install_link, libffi, libffi.so.5.0.8, /usr/lib/libffi.so.5)
	@$(call install_link, libffi, libffi.so.5.0.8, /usr/lib/libffi.so)

	@$(call install_finish, libffi)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libffi_clean:
	rm -rf $(STATEDIR)/libffi.*
	rm -rf $(PKGDIR)/libffi_*
	rm -rf $(LIBFFI_DIR)

# vim: syntax=make

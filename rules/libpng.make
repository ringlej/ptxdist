# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPNG) += libpng

#
# Paths and names
#
LIBPNG_VERSION	:= 1.2.34
LIBPNG		:= libpng-$(LIBPNG_VERSION)
LIBPNG_SUFFIX	:= tar.bz2
LIBPNG_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libpng/$(LIBPNG).$(LIBPNG_SUFFIX)
LIBPNG_SOURCE	:= $(SRCDIR)/$(LIBPNG).$(LIBPNG_SUFFIX)
LIBPNG_DIR	:= $(BUILDDIR)/$(LIBPNG)
LIBPNG_PKGDIR	:= $(PKGDIR)/$(LIBPNG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPNG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPNG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPNG_PATH	:= PATH=$(CROSS_PATH)
LIBPNG_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBPNG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-libpng-compat

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpng.install:
	@$(call targetinfo)
	@$(call install, LIBPNG)
	$(INSTALL) -m 755 -D $(LIBPNG_DIR)/libpng-config $(PTXCONF_SYSROOT_CROSS)/bin/libpng-config
	$(INSTALL) -m 755 -D $(LIBPNG_DIR)/libpng12-config $(PTXCONF_SYSROOT_CROSS)/bin/libpng12-config

#
# remove library version 3, we don't install it on the target
# so we can't install it in SYSROOT, too
#
	for dir in "$(LIBPNG_PKGDIR)" "$(SYSROOT)"; do \
		rm -v "$$dir/usr/lib/libpng.so.3"*; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpng)
	@$(call install_fixup, libpng,PACKAGE,libpng)
	@$(call install_fixup, libpng,PRIORITY,optional)
	@$(call install_fixup, libpng,VERSION,$(LIBPNG_VERSION))
	@$(call install_fixup, libpng,SECTION,base)
	@$(call install_fixup, libpng,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libpng,DEPENDS,)
	@$(call install_fixup, libpng,DESCRIPTION,missing)

	@$(call install_copy, libpng, 0, 0, 0644, \
		$(LIBPNG_DIR)/.libs/libpng12.so.0.34.0, \
		/usr/lib/libpng12.so.0.34.0)
	@$(call install_link, libpng, libpng12.so.0.34.0, /usr/lib/libpng12.so.0)
	@$(call install_link, libpng, libpng12.so.0.34.0, /usr/lib/libpng12.so)

	@$(call install_finish, libpng)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpng_clean:
	rm -rf $(STATEDIR)/libpng.*
	rm -rf $(PKGDIR)/libpng_*
	rm -rf $(LIBPNG_DIR)

# vim: syntax=make

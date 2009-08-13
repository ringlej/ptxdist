# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMNG) += libmng

#
# Paths and names
#
LIBMNG_VERSION	:= 1.0.10
LIBMNG		:= libmng-$(LIBMNG_VERSION)
LIBMNG_SUFFIX	:= tar.bz2
LIBMNG_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libmng/$(LIBMNG).$(LIBMNG_SUFFIX)
LIBMNG_SOURCE	:= $(SRCDIR)/$(LIBMNG).$(LIBMNG_SUFFIX)
LIBMNG_DIR	:= $(BUILDDIR)/$(LIBMNG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMNG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMNG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libmng.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBMNG_DIR))
	@$(call extract, LIBMNG)
	@$(call patchin, LIBMNG)
	@cd $(LIBMNG_DIR); chmod +x configure config.sub config.guess
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMNG_PATH	:= PATH=$(CROSS_PATH)
LIBMNG_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBMNG_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBMNG_JPEG
LIBMNG_AUTOCONF += --with-jpeg
else
LIBMNG_AUTOCONF += --without-jpeg
endif

ifdef PTXCONF_LIBMNG_LCMS
LIBMNG_AUTOCONF += --with-lcms
else
LIBMNG_AUTOCONF += --without-lcms
endif


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmng.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libmng)
	@$(call install_fixup, libmng,PACKAGE,libmng)
	@$(call install_fixup, libmng,PRIORITY,optional)
	@$(call install_fixup, libmng,VERSION,$(LIBMNG_VERSION))
	@$(call install_fixup, libmng,SECTION,base)
	@$(call install_fixup, libmng,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmng,DEPENDS,)
	@$(call install_fixup, libmng,DESCRIPTION,missing)

	@$(call install_copy, libmng, 0, 0, 0644, -, /usr/lib/libmng.so.1.0.0)
	@$(call install_link, libmng, libmng.so.1.0.0, /usr/lib/libmng.so.1)
	@$(call install_link, libmng, libmng.so.1.0.0, /usr/lib/libmng.so)

	@$(call install_finish, libmng)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmng_clean:
	rm -rf $(STATEDIR)/libmng.*
	rm -rf $(PKGDIR)/libmng_*
	rm -rf $(LIBMNG_DIR)

# vim: syntax=make

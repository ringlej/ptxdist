# -*-makefile-*-
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
LIBMNG_MD5	:= eaf1476a3bb29f6190bca660e6abef16
LIBMNG		:= libmng-$(LIBMNG_VERSION)
LIBMNG_SUFFIX	:= tar.bz2
LIBMNG_URL	:= $(call ptx/mirror, SF, libmng/$(LIBMNG).$(LIBMNG_SUFFIX))
LIBMNG_SOURCE	:= $(SRCDIR)/$(LIBMNG).$(LIBMNG_SUFFIX)
LIBMNG_DIR	:= $(BUILDDIR)/$(LIBMNG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMNG_PATH	:= PATH=$(CROSS_PATH)
LIBMNG_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBMNG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-jpeg

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

	@$(call install_init, libmng)
	@$(call install_fixup, libmng,PRIORITY,optional)
	@$(call install_fixup, libmng,SECTION,base)
	@$(call install_fixup, libmng,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmng,DESCRIPTION,missing)

	@$(call install_lib, libmng, 0, 0, 0644, libmng)

	@$(call install_finish, libmng)

	@$(call touch)

# vim: syntax=make

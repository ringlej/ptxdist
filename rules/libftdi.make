# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBFTDI_VERSION	:= 0.17
LIBFTDI_MD5	:= 810c69cfaa078b49795c224ef9b6b851
LIBFTDI		:= libftdi-$(LIBFTDI_VERSION)
LIBFTDI_SUFFIX	:= tar.gz
LIBFTDI_URL	:= http://www.intra2net.com/en/developer/libftdi/download/$(LIBFTDI).$(LIBFTDI_SUFFIX)
LIBFTDI_SOURCE	:= $(SRCDIR)/$(LIBFTDI).$(LIBFTDI_SUFFIX)
LIBFTDI_DIR	:= $(BUILDDIR)/$(LIBFTDI)
LIBFTDI_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFTDI_PATH	:= PATH=$(CROSS_PATH)
LIBFTDI_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBFTDI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-python-binding

ifdef PTXCONF_LIBFTDI_CPP_WRAPPER
LIBFTDI_AUTOCONF += \
	--enable-libftdipp \
	--with-boost=$(SYSROOT)/usr
else
LIBFTDI_AUTOCONF += \
	--disable-libftdipp \
	--without-boost
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libftdi)
	@$(call install_fixup, libftdi,PRIORITY,optional)
	@$(call install_fixup, libftdi,SECTION,base)
	@$(call install_fixup, libftdi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libftdi,DESCRIPTION,missing)

	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang_ft2232)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang2)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/find_all)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/bitbang_cbus)
	@$(call install_copy, libftdi, 0, 0, 0755, -, /usr/bin/simple)

	@$(call install_lib, libftdi, 0, 0, 0644, libftdi)

	@$(call install_finish, libftdi)

	@$(call touch)

# vim: syntax=make

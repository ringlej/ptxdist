# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMAD) += libmad

#
# Paths and names
#
LIBMAD_VERSION	:= 0.15.1b
LIBMAD_MD5	:= 1be543bc30c56fb6bea1d7bf6a64e66c
LIBMAD		:= libmad-$(LIBMAD_VERSION)
LIBMAD_SUFFIX	:= tar.gz
LIBMAD_URL	:= ftp://ftp.mars.org/pub/mpeg/$(LIBMAD).$(LIBMAD_SUFFIX)
LIBMAD_SOURCE	:= $(SRCDIR)/$(LIBMAD).$(LIBMAD_SUFFIX)
LIBMAD_DIR	:= $(BUILDDIR)/$(LIBMAD)
LIBMAD_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMAD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMAD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMAD_PATH	:= PATH=$(CROSS_PATH)
LIBMAD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMAD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debugging \
	--disable-profiling \
	--disable-experimental

ifdef PTXCONF_LIBMAD__OPT_SPEED
LIBMAD_AUTOCONF += --enable-speed
endif
ifdef PTXCONF_LIBMAD__OPT_ACCURACY
LIBMAD_AUTOCONF += --enable-accuracy
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmad.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmad)
	@$(call install_fixup, libmad,PRIORITY,optional)
	@$(call install_fixup, libmad,SECTION,base)
	@$(call install_fixup, libmad,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libmad,DESCRIPTION,missing)

	@$(call install_lib, libmad, 0, 0, 0644, libmad)

	@$(call install_finish, libmad)

	@$(call touch)

# vim: syntax=make

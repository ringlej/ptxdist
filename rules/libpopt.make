# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2006, 2009 by Marc Kleine-Budde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPOPT) += libpopt

#
# Paths and names
#
LIBPOPT_VERSION	:= 1.15
LIBPOPT_MD5	:= c61ef795fa450eb692602a661ec8d7f1
LIBPOPT		:= popt-$(LIBPOPT_VERSION)
LIBPOPT_SUFFIX	:= tar.gz
LIBPOPT_URL	:= http://rpm5.org/files/popt/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_SOURCE	:= $(SRCDIR)/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_DIR	:= $(BUILDDIR)/$(LIBPOPT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPOPT_PATH	:= PATH=$(CROSS_PATH)
LIBPOPT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPOPT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBPOPT_NLS
LIBPOPT_AUTOCONF += --enable-nls
else
LIBPOPT_AUTOCONF += --disable-nls
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpopt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpopt)
	@$(call install_fixup, libpopt,PRIORITY,optional)
	@$(call install_fixup, libpopt,SECTION,base)
	@$(call install_fixup, libpopt,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpopt,DESCRIPTION,missing)

	@$(call install_lib, libpopt, 0, 0, 0644, libpopt)

	@$(call install_finish, libpopt)

	@$(call touch)

# vim: syntax=make

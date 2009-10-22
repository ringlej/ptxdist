# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
# Copyright (C) 2006 by Marc Kleine-Budde
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
LIBPOPT		:= popt-$(LIBPOPT_VERSION)
LIBPOPT_SUFFIX	:= tar.gz
LIBPOPT_URL	:= http://rpm5.org/files/popt/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_SOURCE	:= $(SRCDIR)/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_DIR	:= $(BUILDDIR)/$(LIBPOPT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPOPT_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPOPT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPOPT_PATH	:=  PATH=$(CROSS_PATH)
LIBPOPT_ENV 	:=  $(CROSS_ENV)

ifndef PTXCONF_LIBPOPT_NLS
# uggly hack: configure script sees "no" if we set this go ":"
LIBPOPT_ENV	+= ac_cv_path_XGETTEXT=:
endif

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
	@$(call install_fixup,libpopt,PACKAGE,libpopt)
	@$(call install_fixup,libpopt,PRIORITY,optional)
	@$(call install_fixup,libpopt,VERSION,$(LIBPOPT_VERSION))
	@$(call install_fixup,libpopt,SECTION,base)
	@$(call install_fixup,libpopt,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libpopt,DEPENDS,)
	@$(call install_fixup,libpopt,DESCRIPTION,missing)

	@$(call install_copy, libpopt, 0, 0, 0644, $(LIBPOPT_DIR)/.libs/libpopt.so.0.0.0, /usr/lib/libpopt.so.0.0.0)
	@$(call install_link, libpopt, libpopt.so.0.0.0, /usr/lib/libpopt.so.0)
	@$(call install_link, libpopt, libpopt.so.0.0.0, /usr/lib/libpopt.so)

	@$(call install_finish,libpopt)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpopt_clean:
	rm -rf $(STATEDIR)/libpopt.*
	rm -rf $(PKGDIR)/libpopt_*
	rm -rf $(LIBPOPT_DIR)

# vim: syntax=make

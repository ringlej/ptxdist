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
LIBPOPT_VERSION	:= 1.10.7
LIBPOPT		:= popt-$(LIBPOPT_VERSION)
LIBPOPT_SUFFIX	:= tar.gz
LIBPOPT_URL	:= ftp://wraptastic.org/pub/rpm-4.4.x/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_SOURCE	:= $(SRCDIR)/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_DIR	:= $(BUILDDIR)/$(LIBPOPT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpopt_get: $(STATEDIR)/libpopt.get

$(STATEDIR)/libpopt.get: $(libpopt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBPOPT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBPOPT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpopt_extract: $(STATEDIR)/libpopt.extract

$(STATEDIR)/libpopt.extract: $(libpopt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPOPT_DIR))
	@$(call extract, LIBPOPT)
	@$(call patchin, LIBPOPT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpopt_prepare: $(STATEDIR)/libpopt.prepare

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

$(STATEDIR)/libpopt.prepare: $(libpopt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPOPT_DIR)/config.cache)
	cd $(LIBPOPT_DIR) && \
		$(LIBPOPT_PATH) $(LIBPOPT_ENV) \
		./configure $(LIBPOPT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpopt_compile: $(STATEDIR)/libpopt.compile

$(STATEDIR)/libpopt.compile: $(libpopt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPOPT_DIR) && $(LIBPOPT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpopt_install: $(STATEDIR)/libpopt.install

$(STATEDIR)/libpopt.install: $(libpopt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBPOPT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpopt_targetinstall: $(STATEDIR)/libpopt.targetinstall

$(STATEDIR)/libpopt.targetinstall: $(libpopt_targetinstall_deps_default)
	@$(call targetinfo, $@)

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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpopt_clean:
	rm -rf $(STATEDIR)/libpopt.*
	rm -rf $(PKGDIR)/libpopt_*
	rm -rf $(LIBPOPT_DIR)

# vim: syntax=make

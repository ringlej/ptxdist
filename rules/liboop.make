# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOOP) += liboop

#
# Paths and names
#
LIBOOP_VERSION	= 1.0
LIBOOP		= liboop-$(LIBOOP_VERSION)
LIBOOP_SUFFIX	= tar.bz2
LIBOOP_URL	= http://download.ofb.net/liboop/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_SOURCE	= $(SRCDIR)/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_DIR	= $(BUILDDIR)/$(LIBOOP)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liboop_get: $(STATEDIR)/liboop.get

$(STATEDIR)/liboop.get: $(liboop_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBOOP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBOOP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liboop_extract: $(STATEDIR)/liboop.extract

$(STATEDIR)/liboop.extract: $(liboop_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOOP_DIR))
	@$(call extract, LIBOOP)
	@$(call patchin, $(LIBOOP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liboop_prepare: $(STATEDIR)/liboop.prepare

LIBOOP_PATH	=  PATH=$(CROSS_PATH)
#
# override glibc-config to prevent from using the host system's
#
LIBOOP_ENV = \
	$(CROSS_ENV) \
	ac_cv_prog_PROG_GLIB_CONFIG=

#
# autoconf
#
LIBOOP_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LIBOOP_AUTOCONF	+= \
	--without-tcl \
	--without-glib

$(STATEDIR)/liboop.prepare: $(liboop_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOOP_DIR)/config.cache)
	cd $(LIBOOP_DIR) && \
		$(LIBOOP_PATH) $(LIBOOP_ENV) \
		./configure $(LIBOOP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liboop_compile: $(STATEDIR)/liboop.compile

$(STATEDIR)/liboop.compile: $(liboop_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBOOP_DIR) && $(LIBOOP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liboop_install: $(STATEDIR)/liboop.install

$(STATEDIR)/liboop.install: $(liboop_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBOOP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liboop_targetinstall: $(STATEDIR)/liboop.targetinstall

$(STATEDIR)/liboop.targetinstall: $(liboop_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, liboop)
	@$(call install_fixup, liboop,PACKAGE,liboop)
	@$(call install_fixup, liboop,PRIORITY,optional)
	@$(call install_fixup, liboop,VERSION,$(LIBOOP_VERSION))
	@$(call install_fixup, liboop,SECTION,base)
	@$(call install_fixup, liboop,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, liboop,DEPENDS,)
	@$(call install_fixup, liboop,DESCRIPTION,missing)

	@$(call install_copy, liboop, 0, 0, 0644, \
		$(LIBOOP_DIR)/.libs/liboop.so.4.0.1, \
		/usr/lib/liboop.so.4.0.1)

	@$(call install_link, liboop, liboop.so.4.0.1, /usr/lib/liboop.so.4)
	@$(call install_link, liboop, liboop.so.4.0.1, /usr/lib/liboop.so)

	@$(call install_finish, liboop)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liboop_clean:
	rm -rf $(STATEDIR)/liboop.*
	rm -rf $(IMAGEDIR)/liboop_*
	rm -rf $(LIBOOP_DIR)

# vim: syntax=make

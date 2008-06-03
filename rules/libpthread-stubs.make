# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPTHREAD_STUBS) += libpthread-stubs

#
# Paths and names
#
LIBPTHREAD_STUBS_VERSION	:= 0.1
LIBPTHREAD_STUBS		:= libpthread-stubs-$(LIBPTHREAD_STUBS_VERSION)
LIBPTHREAD_STUBS_SUFFIX		:= tar.bz2
LIBPTHREAD_STUBS_URL		:= http://xcb.freedesktop.org/dist/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_SOURCE		:= $(SRCDIR)/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_DIR		:= $(BUILDDIR)/$(LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpthread-stubs_get: $(STATEDIR)/libpthread-stubs.get

$(STATEDIR)/libpthread-stubs.get: $(libpthread-stubs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBPTHREAD_STUBS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpthread-stubs_extract: $(STATEDIR)/libpthread-stubs.extract

$(STATEDIR)/libpthread-stubs.extract: $(libpthread-stubs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPTHREAD_STUBS_DIR))
	@$(call extract, LIBPTHREAD_STUBS)
	@$(call patchin, LIBPTHREAD_STUBS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpthread-stubs_prepare: $(STATEDIR)/libpthread-stubs.prepare

LIBPTHREAD_STUBS_PATH	:= PATH=$(CROSS_PATH)
LIBPTHREAD_STUBS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPTHREAD_STUBS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--enable-shared=no

$(STATEDIR)/libpthread-stubs.prepare: $(libpthread-stubs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPTHREAD_STUBS_DIR)/config.cache)
	cd $(LIBPTHREAD_STUBS_DIR) && \
		$(LIBPTHREAD_STUBS_PATH) $(LIBPTHREAD_STUBS_ENV) \
		./configure $(LIBPTHREAD_STUBS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpthread-stubs_compile: $(STATEDIR)/libpthread-stubs.compile

$(STATEDIR)/libpthread-stubs.compile: $(libpthread-stubs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPTHREAD_STUBS_DIR) && $(LIBPTHREAD_STUBS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpthread-stubs_install: $(STATEDIR)/libpthread-stubs.install

$(STATEDIR)/libpthread-stubs.install: $(libpthread-stubs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBPTHREAD_STUBS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpthread-stubs_targetinstall: $(STATEDIR)/libpthread-stubs.targetinstall

$(STATEDIR)/libpthread-stubs.targetinstall: $(libpthread-stubs_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpthread-stubs_clean:
	rm -rf $(STATEDIR)/libpthread-stubs.*
	rm -rf $(PKGDIR)/libpthread-stubs_*
	rm -rf $(LIBPTHREAD_STUBS_DIR)

# vim: syntax=make

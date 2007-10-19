# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_LIBPTHREAD_STUBS) += host-libpthread-stubs

#
# Paths and names
#
HOST_LIBPTHREAD_STUBS_DIR	= $(HOST_BUILDDIR)/$(LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libpthread-stubs_get: $(STATEDIR)/host-libpthread-stubs.get

$(STATEDIR)/host-libpthread-stubs.get: $(STATEDIR)/libpthread-stubs.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libpthread-stubs_extract: $(STATEDIR)/host-libpthread-stubs.extract

$(STATEDIR)/host-libpthread-stubs.extract: $(host-libpthread-stubs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBPTHREAD_STUBS_DIR))
	@$(call extract, LIBPTHREAD_STUBS, $(HOST_BUILDDIR))
	@$(call patchin, LIBPTHREAD_STUBS, $(HOST_LIBPTHREAD_STUBS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libpthread-stubs_prepare: $(STATEDIR)/host-libpthread-stubs.prepare

HOST_LIBPTHREAD_STUBS_PATH	:= PATH=$(HOST_PATH)
HOST_LIBPTHREAD_STUBS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBPTHREAD_STUBS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libpthread-stubs.prepare: $(host-libpthread-stubs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBPTHREAD_STUBS_DIR)/config.cache)
	cd $(HOST_LIBPTHREAD_STUBS_DIR) && \
		$(HOST_LIBPTHREAD_STUBS_PATH) $(HOST_LIBPTHREAD_STUBS_ENV) \
		./configure $(HOST_LIBPTHREAD_STUBS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libpthread-stubs_compile: $(STATEDIR)/host-libpthread-stubs.compile

$(STATEDIR)/host-libpthread-stubs.compile: $(host-libpthread-stubs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBPTHREAD_STUBS_DIR) && $(HOST_LIBPTHREAD_STUBS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libpthread-stubs_install: $(STATEDIR)/host-libpthread-stubs.install

$(STATEDIR)/host-libpthread-stubs.install: $(host-libpthread-stubs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBPTHREAD_STUBS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libpthread-stubs_clean:
	rm -rf $(STATEDIR)/host-libpthread-stubs.*
	rm -rf $(HOST_LIBPTHREAD_STUBS_DIR)

# vim: syntax=make

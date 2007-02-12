# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLIB) += host-glib

#
# Paths and names
#
HOST_GLIB_DIR	= $(HOST_BUILDDIR)/$(GLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-glib_get: $(STATEDIR)/host-glib.get

$(STATEDIR)/host-glib.get: $(STATEDIR)/glib.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-glib_extract: $(STATEDIR)/host-glib.extract

$(STATEDIR)/host-glib.extract: $(host-glib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLIB_DIR))
	@$(call extract, GLIB, $(HOST_BUILDDIR))
	@$(call patchin, GLIB, $(HOST_GLIB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-glib_prepare: $(STATEDIR)/host-glib.prepare

HOST_GLIB_PATH	:= PATH=$(HOST_PATH)
HOST_GLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLIB_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-glib.prepare: $(host-glib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLIB_DIR)/config.cache)
	cd $(HOST_GLIB_DIR) && \
		$(HOST_GLIB_PATH) $(HOST_GLIB_ENV) \
		./configure $(HOST_GLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-glib_compile: $(STATEDIR)/host-glib.compile

$(STATEDIR)/host-glib.compile: $(host-glib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GLIB_DIR) && $(HOST_GLIB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-glib_install: $(STATEDIR)/host-glib.install

$(STATEDIR)/host-glib.install: $(host-glib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GLIB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glib_clean:
	rm -rf $(STATEDIR)/host-glib.*
	rm -rf $(HOST_GLIB_DIR)

# vim: syntax=make

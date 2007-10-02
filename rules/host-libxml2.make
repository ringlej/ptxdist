# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXML2) += host-libxml2

#
# Paths and names
#
HOST_LIBXML2_DIR	= $(HOST_BUILDDIR)/$(LIBXML2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libxml2_get: $(STATEDIR)/host-libxml2.get

$(STATEDIR)/host-libxml2.get: $(STATEDIR)/libxml2.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libxml2_extract: $(STATEDIR)/host-libxml2.extract

$(STATEDIR)/host-libxml2.extract: $(host-libxml2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXML2_DIR))
	@$(call extract, LIBXML2, $(HOST_BUILDDIR))
	@$(call patchin, LIBXML2, $(HOST_LIBXML2_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libxml2_prepare: $(STATEDIR)/host-libxml2.prepare

HOST_LIBXML2_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXML2_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXML2_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libxml2.prepare: $(host-libxml2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXML2_DIR)/config.cache)
	cd $(HOST_LIBXML2_DIR) && \
		$(HOST_LIBXML2_PATH) $(HOST_LIBXML2_ENV) \
		./configure $(HOST_LIBXML2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libxml2_compile: $(STATEDIR)/host-libxml2.compile

$(STATEDIR)/host-libxml2.compile: $(host-libxml2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBXML2_DIR) && $(HOST_LIBXML2_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libxml2_install: $(STATEDIR)/host-libxml2.install

$(STATEDIR)/host-libxml2.install: $(host-libxml2_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBXML2,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libxml2_clean:
	rm -rf $(STATEDIR)/host-libxml2.*
	rm -rf $(HOST_LIBXML2_DIR)

# vim: syntax=make

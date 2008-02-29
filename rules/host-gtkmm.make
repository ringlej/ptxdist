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
HOST_PACKAGES-$(PTXCONF_HOST_GTKMM) += host-gtkmm

#
# Paths and names
#
HOST_GTKMM_DIR	= $(HOST_BUILDDIR)/$(GTKMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-gtkmm_get: $(STATEDIR)/host-gtkmm.get

$(STATEDIR)/host-gtkmm.get: $(STATEDIR)/gtkmm.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-gtkmm_extract: $(STATEDIR)/host-gtkmm.extract

$(STATEDIR)/host-gtkmm.extract: $(host-gtkmm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GTKMM_DIR))
	@$(call extract, GTKMM, $(HOST_BUILDDIR))
	@$(call patchin, GTKMM, $(HOST_GTKMM_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-gtkmm_prepare: $(STATEDIR)/host-gtkmm.prepare

HOST_GTKMM_PATH	:= PATH=$(HOST_PATH)
HOST_GTKMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GTKMM_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-gtkmm.prepare: $(host-gtkmm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GTKMM_DIR)/config.cache)
	cd $(HOST_GTKMM_DIR) && \
		$(HOST_GTKMM_PATH) $(HOST_GTKMM_ENV) \
		./configure $(HOST_GTKMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-gtkmm_compile: $(STATEDIR)/host-gtkmm.compile

$(STATEDIR)/host-gtkmm.compile: $(host-gtkmm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GTKMM_DIR) && $(HOST_GTKMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-gtkmm_install: $(STATEDIR)/host-gtkmm.install

$(STATEDIR)/host-gtkmm.install: $(host-gtkmm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GTKMM,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gtkmm_clean:
	rm -rf $(STATEDIR)/host-gtkmm.*
	rm -rf $(HOST_GTKMM_DIR)

# vim: syntax=make

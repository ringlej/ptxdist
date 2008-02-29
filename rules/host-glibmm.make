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
HOST_PACKAGES-$(PTXCONF_HOST_GLIBMM) += host-glibmm

#
# Paths and names
#
HOST_GLIBMM_DIR	= $(HOST_BUILDDIR)/$(GLIBMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-glibmm_get: $(STATEDIR)/host-glibmm.get

$(STATEDIR)/host-glibmm.get: $(STATEDIR)/glibmm.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-glibmm_extract: $(STATEDIR)/host-glibmm.extract

$(STATEDIR)/host-glibmm.extract: $(host-glibmm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLIBMM_DIR))
	@$(call extract, GLIBMM, $(HOST_BUILDDIR))
	@$(call patchin, GLIBMM, $(HOST_GLIBMM_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-glibmm_prepare: $(STATEDIR)/host-glibmm.prepare

HOST_GLIBMM_PATH	:= PATH=$(HOST_PATH)
HOST_GLIBMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLIBMM_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-glibmm.prepare: $(host-glibmm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLIBMM_DIR)/config.cache)
	cd $(HOST_GLIBMM_DIR) && \
		$(HOST_GLIBMM_PATH) $(HOST_GLIBMM_ENV) \
		./configure $(HOST_GLIBMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-glibmm_compile: $(STATEDIR)/host-glibmm.compile

$(STATEDIR)/host-glibmm.compile: $(host-glibmm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GLIBMM_DIR) && $(HOST_GLIBMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-glibmm_install: $(STATEDIR)/host-glibmm.install

$(STATEDIR)/host-glibmm.install: $(host-glibmm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GLIBMM,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glibmm_clean:
	rm -rf $(STATEDIR)/host-glibmm.*
	rm -rf $(HOST_GLIBMM_DIR)

# vim: syntax=make

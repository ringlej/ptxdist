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
HOST_PACKAGES-$(PTXCONF_HOST_CAIROMM) += host-cairomm

#
# Paths and names
#
HOST_CAIROMM_DIR	= $(HOST_BUILDDIR)/$(CAIROMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-cairomm_get: $(STATEDIR)/host-cairomm.get

$(STATEDIR)/host-cairomm.get: $(STATEDIR)/cairomm.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-cairomm_extract: $(STATEDIR)/host-cairomm.extract

$(STATEDIR)/host-cairomm.extract: $(host-cairomm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CAIROMM_DIR))
	@$(call extract, CAIROMM, $(HOST_BUILDDIR))
	@$(call patchin, CAIROMM, $(HOST_CAIROMM_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-cairomm_prepare: $(STATEDIR)/host-cairomm.prepare

HOST_CAIROMM_PATH	:= PATH=$(HOST_PATH)
HOST_CAIROMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CAIROMM_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-cairomm.prepare: $(host-cairomm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CAIROMM_DIR)/config.cache)
	cd $(HOST_CAIROMM_DIR) && \
		$(HOST_CAIROMM_PATH) $(HOST_CAIROMM_ENV) \
		./configure $(HOST_CAIROMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-cairomm_compile: $(STATEDIR)/host-cairomm.compile

$(STATEDIR)/host-cairomm.compile: $(host-cairomm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_CAIROMM_DIR) && $(HOST_CAIROMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-cairomm_install: $(STATEDIR)/host-cairomm.install

$(STATEDIR)/host-cairomm.install: $(host-cairomm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_CAIROMM,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-cairomm_clean:
	rm -rf $(STATEDIR)/host-cairomm.*
	rm -rf $(HOST_CAIROMM_DIR)

# vim: syntax=make

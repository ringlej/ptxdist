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
HOST_PACKAGES-$(PTXCONF_HOST_ATK) += host-atk

#
# Paths and names
#
HOST_ATK_DIR	= $(HOST_BUILDDIR)/$(ATK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-atk_get: $(STATEDIR)/host-atk.get

$(STATEDIR)/host-atk.get: $(STATEDIR)/atk.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-atk_extract: $(STATEDIR)/host-atk.extract

$(STATEDIR)/host-atk.extract: $(host-atk_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_ATK_DIR))
	@$(call extract, ATK, $(HOST_BUILDDIR))
	@$(call patchin, ATK, $(HOST_ATK_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-atk_prepare: $(STATEDIR)/host-atk.prepare

HOST_ATK_PATH	:= PATH=$(HOST_PATH)
HOST_ATK_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ATK_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-glibtest

$(STATEDIR)/host-atk.prepare: $(host-atk_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_ATK_DIR)/config.cache)
	cd $(HOST_ATK_DIR) && \
		$(HOST_ATK_PATH) $(HOST_ATK_ENV) \
		./configure $(HOST_ATK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-atk_compile: $(STATEDIR)/host-atk.compile

$(STATEDIR)/host-atk.compile: $(host-atk_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_ATK_DIR) && $(HOST_ATK_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-atk_install: $(STATEDIR)/host-atk.install

$(STATEDIR)/host-atk.install: $(host-atk_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_ATK,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-atk_clean:
	rm -rf $(STATEDIR)/host-atk.*
	rm -rf $(HOST_ATK_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLADEMM) += host-glademm

#
# Paths and names
#
HOST_GLADEMM_DIR	= $(HOST_BUILDDIR)/$(GLADEMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-glademm_get: $(STATEDIR)/host-glademm.get

$(STATEDIR)/host-glademm.get: $(STATEDIR)/glademm.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-glademm_extract: $(STATEDIR)/host-glademm.extract

$(STATEDIR)/host-glademm.extract: $(host-glademm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLADEMM_DIR))
	@$(call extract, GLADEMM, $(HOST_BUILDDIR))
	@$(call patchin, GLADEMM, $(HOST_GLADEMM_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-glademm_prepare: $(STATEDIR)/host-glademm.prepare

HOST_GLADEMM_PATH	:= PATH=$(HOST_PATH)
HOST_GLADEMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLADEMM_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-glademm.prepare: $(host-glademm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLADEMM_DIR)/config.cache)
	cd $(HOST_GLADEMM_DIR) && \
		$(HOST_GLADEMM_PATH) $(HOST_GLADEMM_ENV) \
		./configure $(HOST_GLADEMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-glademm_compile: $(STATEDIR)/host-glademm.compile

$(STATEDIR)/host-glademm.compile: $(host-glademm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GLADEMM_DIR) && $(HOST_GLADEMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-glademm_install: $(STATEDIR)/host-glademm.install

$(STATEDIR)/host-glademm.install: $(host-glademm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GLADEMM,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glademm_clean:
	rm -rf $(STATEDIR)/host-glademm.*
	rm -rf $(HOST_GLADEMM_DIR)

# vim: syntax=make

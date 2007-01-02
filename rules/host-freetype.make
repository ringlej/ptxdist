# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FREETYPE) += host-freetype

#
# Paths and names
#
HOST_FREETYPE_DIR	= $(HOST_BUILDDIR)/$(FREETYPE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-freetype_get: $(STATEDIR)/host-freetype.get

$(STATEDIR)/host-freetype.get: $(STATEDIR)/freetype.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-freetype_extract: $(STATEDIR)/host-freetype.extract

$(STATEDIR)/host-freetype.extract: $(host-freetype_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FREETYPE_DIR))
	@$(call extract, FREETYPE, $(HOST_BUILDDIR))
	@$(call patchin, FREETYPE, $(HOST_FREETYPE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-freetype_prepare: $(STATEDIR)/host-freetype.prepare

HOST_FREETYPE_PATH	:= PATH=$(HOST_PATH)
HOST_FREETYPE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_FREETYPE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-freetype.prepare: $(host-freetype_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FREETYPE_DIR)/config.cache)
	cd $(HOST_FREETYPE_DIR) && \
		$(HOST_FREETYPE_PATH) $(HOST_FREETYPE_ENV) \
		./configure $(HOST_FREETYPE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-freetype_compile: $(STATEDIR)/host-freetype.compile

$(STATEDIR)/host-freetype.compile: $(host-freetype_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_FREETYPE_DIR) && $(HOST_FREETYPE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-freetype_install: $(STATEDIR)/host-freetype.install

$(STATEDIR)/host-freetype.install: $(host-freetype_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_FREETYPE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-freetype_clean:
	rm -rf $(STATEDIR)/host-freetype.*
	rm -rf $(HOST_FREETYPE_DIR)

# vim: syntax=make

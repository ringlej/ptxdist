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
HOST_PACKAGES-$(PTXCONF_HOST_LIBGLADE) += host-libglade

#
# Paths and names
#
HOST_LIBGLADE_DIR	= $(HOST_BUILDDIR)/$(LIBGLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libglade_get: $(STATEDIR)/host-libglade.get

$(STATEDIR)/host-libglade.get: $(STATEDIR)/libglade.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libglade_extract: $(STATEDIR)/host-libglade.extract

$(STATEDIR)/host-libglade.extract: $(host-libglade_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBGLADE_DIR))
	@$(call extract, LIBGLADE, $(HOST_BUILDDIR))
	@$(call patchin, LIBGLADE, $(HOST_LIBGLADE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libglade_prepare: $(STATEDIR)/host-libglade.prepare

HOST_LIBGLADE_PATH	:= PATH=$(HOST_PATH)
HOST_LIBGLADE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBGLADE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libglade.prepare: $(host-libglade_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBGLADE_DIR)/config.cache)
	cd $(HOST_LIBGLADE_DIR) && \
		$(HOST_LIBGLADE_PATH) $(HOST_LIBGLADE_ENV) \
		./configure $(HOST_LIBGLADE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libglade_compile: $(STATEDIR)/host-libglade.compile

$(STATEDIR)/host-libglade.compile: $(host-libglade_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBGLADE_DIR) && $(HOST_LIBGLADE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libglade_install: $(STATEDIR)/host-libglade.install

$(STATEDIR)/host-libglade.install: $(host-libglade_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBGLADE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libglade_clean:
	rm -rf $(STATEDIR)/host-libglade.*
	rm -rf $(HOST_LIBGLADE_DIR)

# vim: syntax=make

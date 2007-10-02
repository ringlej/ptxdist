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
HOST_PACKAGES-$(PTXCONF_HOST_GLADE) += host-glade

#
# Paths and names
#
HOST_GLADE_DIR	= $(HOST_BUILDDIR)/$(GLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-glade_get: $(STATEDIR)/host-glade.get

$(STATEDIR)/host-glade.get: $(STATEDIR)/glade.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-glade_extract: $(STATEDIR)/host-glade.extract

$(STATEDIR)/host-glade.extract: $(host-glade_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLADE_DIR))
	@$(call extract, GLADE, $(HOST_BUILDDIR))
	@$(call patchin, GLADE, $(HOST_GLADE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-glade_prepare: $(STATEDIR)/host-glade.prepare

HOST_GLADE_PATH	:= PATH=$(HOST_PATH)
HOST_GLADE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLADE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-glade.prepare: $(host-glade_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GLADE_DIR)/config.cache)
	cd $(HOST_GLADE_DIR) && \
		$(HOST_GLADE_PATH) $(HOST_GLADE_ENV) \
		./configure $(HOST_GLADE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-glade_compile: $(STATEDIR)/host-glade.compile

$(STATEDIR)/host-glade.compile: $(host-glade_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GLADE_DIR) && $(HOST_GLADE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-glade_install: $(STATEDIR)/host-glade.install

$(STATEDIR)/host-glade.install: $(host-glade_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GLADE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glade_clean:
	rm -rf $(STATEDIR)/host-glade.*
	rm -rf $(HOST_GLADE_DIR)

# vim: syntax=make

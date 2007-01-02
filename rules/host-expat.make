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

#
HOST_PACKAGES-$(PTXCONF_HOST_EXPAT) += host-expat

#
# Paths and names
#
HOST_EXPAT	= $(EXPAT)
HOST_EXPAT_DIR	= $(HOST_BUILDDIR)/$(HOST_EXPAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-expat_get: $(STATEDIR)/host-expat.get

$(STATEDIR)/host-expat.get: $(STATEDIR)/expat.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-expat_extract: $(STATEDIR)/host-expat.extract

$(STATEDIR)/host-expat.extract: $(host-expat_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_EXPAT_DIR))
	@$(call extract, EXPAT, $(HOST_BUILDDIR))
	@$(call patchin, EXPAT, $(HOST_EXPAT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-expat_prepare: $(STATEDIR)/host-expat.prepare

HOST_EXPAT_PATH	:= PATH=$(HOST_PATH)
HOST_EXPAT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_EXPAT_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-expat.prepare: $(host-expat_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_EXPAT_DIR)/config.cache)
	cd $(HOST_EXPAT_DIR) && \
		$(HOST_EXPAT_PATH) $(HOST_EXPAT_ENV) \
		./configure $(HOST_EXPAT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-expat_compile: $(STATEDIR)/host-expat.compile


$(STATEDIR)/host-expat.compile: $(host-expat_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_EXPAT_DIR) && $(HOST_EXPAT_ENV) $(HOST_EXPAT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-expat_install: $(STATEDIR)/host-expat.install

$(STATEDIR)/host-expat.install: $(host-expat_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_EXPAT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-expat_clean:
	rm -rf $(STATEDIR)/host-expat.*
	rm -rf $(HOST_EXPAT_DIR)

# vim: syntax=make

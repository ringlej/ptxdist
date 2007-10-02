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
HOST_PACKAGES-$(PTXCONF_HOST_LIBXSLT) += host-libxslt

#
# Paths and names
#
HOST_LIBXSLT_DIR	= $(HOST_BUILDDIR)/$(LIBXSLT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libxslt_get: $(STATEDIR)/host-libxslt.get

$(STATEDIR)/host-libxslt.get: $(STATEDIR)/libxslt.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libxslt_extract: $(STATEDIR)/host-libxslt.extract

$(STATEDIR)/host-libxslt.extract: $(host-libxslt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXSLT_DIR))
	@$(call extract, LIBXSLT, $(HOST_BUILDDIR))
	@$(call patchin, LIBXSLT, $(HOST_LIBXSLT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libxslt_prepare: $(STATEDIR)/host-libxslt.prepare

HOST_LIBXSLT_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXSLT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXSLT_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libxslt.prepare: $(host-libxslt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBXSLT_DIR)/config.cache)
	cd $(HOST_LIBXSLT_DIR) && \
		$(HOST_LIBXSLT_PATH) $(HOST_LIBXSLT_ENV) \
		./configure $(HOST_LIBXSLT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libxslt_compile: $(STATEDIR)/host-libxslt.compile

$(STATEDIR)/host-libxslt.compile: $(host-libxslt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBXSLT_DIR) && $(HOST_LIBXSLT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libxslt_install: $(STATEDIR)/host-libxslt.install

$(STATEDIR)/host-libxslt.install: $(host-libxslt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBXSLT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libxslt_clean:
	rm -rf $(STATEDIR)/host-libxslt.*
	rm -rf $(HOST_LIBXSLT_DIR)

# vim: syntax=make

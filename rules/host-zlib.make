# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ZLIB) += host-zlib

#
# Paths and names
#
HOST_ZLIB_DIR	= $(HOST_BUILDDIR)/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-zlib_get: $(STATEDIR)/host-zlib.get

$(STATEDIR)/host-zlib.get: $(STATEDIR)/zlib.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-zlib_extract: $(STATEDIR)/host-zlib.extract

$(STATEDIR)/host-zlib.extract: $(host-zlib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_ZLIB_DIR))
	@$(call extract, ZLIB, $(HOST_BUILDDIR))
	@$(call patchin, ZLIB, $(HOST_ZLIB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-zlib_prepare: $(STATEDIR)/host-zlib.prepare

HOST_ZLIB_PATH	:= PATH=$(HOST_PATH)
HOST_ZLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ZLIB_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-zlib.prepare: $(host-zlib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_ZLIB_DIR)/config.cache)
	cd $(HOST_ZLIB_DIR) && \
		$(HOST_ZLIB_PATH) $(HOST_ZLIB_ENV) \
		./configure $(HOST_ZLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-zlib_compile: $(STATEDIR)/host-zlib.compile

$(STATEDIR)/host-zlib.compile: $(host-zlib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_ZLIB_DIR) && $(HOST_ZLIB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-zlib_install: $(STATEDIR)/host-zlib.install

$(STATEDIR)/host-zlib.install: $(host-zlib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_ZLIB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-zlib_clean:
	rm -rf $(STATEDIR)/host-zlib.*
	rm -rf $(HOST_ZLIB_DIR)

# vim: syntax=make

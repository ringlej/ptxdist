# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBSIGCPP) += host-libsigcpp

#
# Paths and names
#
HOST_LIBSIGCPP_DIR	= $(HOST_BUILDDIR)/$(LIBSIGCPP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libsigcpp_get: $(STATEDIR)/host-libsigcpp.get

$(STATEDIR)/host-libsigcpp.get: $(STATEDIR)/libsigcpp.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libsigcpp_extract: $(STATEDIR)/host-libsigcpp.extract

$(STATEDIR)/host-libsigcpp.extract: $(host-libsigcpp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBSIGCPP_DIR))
	@$(call extract, LIBSIGCPP, $(HOST_BUILDDIR))
	@$(call patchin, LIBSIGCPP, $(HOST_LIBSIGCPP_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libsigcpp_prepare: $(STATEDIR)/host-libsigcpp.prepare

HOST_LIBSIGCPP_PATH	:= PATH=$(HOST_PATH)
HOST_LIBSIGCPP_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBSIGCPP_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libsigcpp.prepare: $(host-libsigcpp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBSIGCPP_DIR)/config.cache)
	cd $(HOST_LIBSIGCPP_DIR) && \
		$(HOST_LIBSIGCPP_PATH) $(HOST_LIBSIGCPP_ENV) \
		./configure $(HOST_LIBSIGCPP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libsigcpp_compile: $(STATEDIR)/host-libsigcpp.compile

$(STATEDIR)/host-libsigcpp.compile: $(host-libsigcpp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBSIGCPP_DIR) && $(HOST_LIBSIGCPP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libsigcpp_install: $(STATEDIR)/host-libsigcpp.install

$(STATEDIR)/host-libsigcpp.install: $(host-libsigcpp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBSIGCPP,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libsigcpp_clean:
	rm -rf $(STATEDIR)/host-libsigcpp.*
	rm -rf $(HOST_LIBSIGCPP_DIR)

# vim: syntax=make

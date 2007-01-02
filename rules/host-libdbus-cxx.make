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
HOST_PACKAGES-$(PTXCONF_HOST_LIBDBUS_CXX) += host-libdbus-cxx

#
# Paths and names
#
HOST_LIBDBUS_CXX	= $(LIBDBUS_CXX)
HOST_LIBDBUS_CXX_DIR	= $(HOST_BUILDDIR)/$(HOST_LIBDBUS_CXX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libdbus-cxx_get: $(STATEDIR)/host-libdbus-cxx.get

$(STATEDIR)/host-libdbus-cxx.get: $(STATEDIR)/libdbus-cxx.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libdbus-cxx_extract: $(STATEDIR)/host-libdbus-cxx.extract

$(STATEDIR)/host-libdbus-cxx.extract: $(host-libdbus-cxx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBDBUS_CXX_DIR))
	@$(call extract, LIBDBUS_CXX, $(HOST_BUILDDIR))
	@$(call patchin, LIBDBUS_CXX, $(HOST_LIBDBUS_CXX_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libdbus-cxx_prepare: $(STATEDIR)/host-libdbus-cxx.prepare

HOST_LIBDBUS_CXX_PATH	:= PATH=$(HOST_PATH)
HOST_LIBDBUS_CXX_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBDBUS_CXX_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libdbus-cxx.prepare: $(host-libdbus-cxx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBDBUS_CXX_DIR)/config.cache)
	cd $(HOST_LIBDBUS_CXX_DIR) && \
		$(HOST_LIBDBUS_CXX_PATH) $(HOST_LIBDBUS_CXX_ENV) \
		./configure $(HOST_LIBDBUS_CXX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libdbus-cxx_compile: $(STATEDIR)/host-libdbus-cxx.compile


$(STATEDIR)/host-libdbus-cxx.compile: $(host-libdbus-cxx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_LIBDBUS_CXX_DIR) && $(HOST_LIBDBUS_CXX_ENV) $(HOST_LIBDBUS_CXX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libdbus-cxx_install: $(STATEDIR)/host-libdbus-cxx.install

$(STATEDIR)/host-libdbus-cxx.install: $(host-libdbus-cxx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBDBUS_CXX,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libdbus-cxx_clean:
	rm -rf $(STATEDIR)/host-libdbus-cxx.*
	rm -rf $(HOST_LIBDBUS_CXX_DIR)

# vim: syntax=make

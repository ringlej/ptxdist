# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CMAKE) += host-cmake

#
# Paths and names
#
HOST_CMAKE_VERSION	:= 2.6.3
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= http://www.cmake.org/files/v2.6/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-cmake_get: $(STATEDIR)/host-cmake.get

$(STATEDIR)/host-cmake.get: $(host-cmake_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_CMAKE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_CMAKE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-cmake_extract: $(STATEDIR)/host-cmake.extract

$(STATEDIR)/host-cmake.extract: $(host-cmake_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CMAKE_DIR))
	@$(call extract, HOST_CMAKE, $(HOST_BUILDDIR))
	@$(call patchin, HOST_CMAKE, $(HOST_CMAKE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-cmake_prepare: $(STATEDIR)/host-cmake.prepare

HOST_CMAKE_PATH	:= PATH=$(HOST_PATH)
HOST_CMAKE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CMAKE_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-cmake.prepare: $(host-cmake_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CMAKE_DIR)/config.cache)
	cd $(HOST_CMAKE_DIR) && \
		$(HOST_CMAKE_PATH) $(HOST_CMAKE_ENV) \
		./configure $(HOST_CMAKE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-cmake_compile: $(STATEDIR)/host-cmake.compile

$(STATEDIR)/host-cmake.compile: $(host-cmake_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_CMAKE_DIR) && $(HOST_CMAKE_ENV) $(HOST_CMAKE_PATH) make $(PARALLELMFLAGS) VERBOSE=1
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-cmake_install: $(STATEDIR)/host-cmake.install

$(STATEDIR)/host-cmake.install: $(host-cmake_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_CMAKE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-cmake_clean:
	rm -rf $(STATEDIR)/host-cmake.*
	rm -rf $(HOST_CMAKE_DIR)

# vim: syntax=make

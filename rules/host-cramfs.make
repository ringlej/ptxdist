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
HOST_PACKAGES-$(PTXCONF_HOST_CRAMFS) += host-cramfs

#
# Paths and names
#
HOST_CRAMFS_VERSION	:= 1.1
HOST_CRAMFS		:= cramfs-$(HOST_CRAMFS_VERSION)
HOST_CRAMFS_SUFFIX	:= tar.gz
HOST_CRAMFS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/cramfs/$(HOST_CRAMFS).$(HOST_CRAMFS_SUFFIX)
HOST_CRAMFS_SOURCE	:= $(SRCDIR)/$(HOST_CRAMFS).$(HOST_CRAMFS_SUFFIX)
HOST_CRAMFS_DIR		:= $(HOST_BUILDDIR)/$(HOST_CRAMFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-cramfs_get: $(STATEDIR)/host-cramfs.get

$(STATEDIR)/host-cramfs.get: $(host-cramfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_CRAMFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_CRAMFS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-cramfs_extract: $(STATEDIR)/host-cramfs.extract

$(STATEDIR)/host-cramfs.extract: $(host-cramfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CRAMFS_DIR))
	@$(call extract, HOST_CRAMFS, $(HOST_BUILDDIR))
	@$(call patchin, HOST_CRAMFS, $(HOST_CRAMFS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-cramfs_prepare: $(STATEDIR)/host-cramfs.prepare

HOST_CRAMFS_PATH	:= PATH=$(HOST_PATH)
HOST_CRAMFS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CRAMFS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-cramfs.prepare: $(host-cramfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CRAMFS_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-cramfs_compile: $(STATEDIR)/host-cramfs.compile

$(STATEDIR)/host-cramfs.compile: $(host-cramfs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_CRAMFS_DIR) && \
		$(HOST_CRAMFS_PATH) $(HOST_CRAMFS_ENV) $(MAKE) $(PARALLELMFLAGS) CPPFLAGS="-I. $(HOST_CPPFLAGS)"
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-cramfs_install: $(STATEDIR)/host-cramfs.install

$(STATEDIR)/host-cramfs.install: $(host-cramfs_install_deps_default)
	@$(call targetinfo, $@)
	cp $(HOST_CRAMFS_DIR)/mkcramfs $(PTXCONF_SYSROOT_HOST)/bin
	cp $(HOST_CRAMFS_DIR)/cramfsck $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-cramfs_clean:
	rm -rf $(STATEDIR)/host-cramfs.*
	rm -rf $(HOST_CRAMFS_DIR)

# vim: syntax=make

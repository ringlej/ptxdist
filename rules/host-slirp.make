# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SLIRP) += host-slirp

#
# Paths and names
#
HOST_SLIRP_VERSION	= 1.0.16
HOST_SLIRP		= slirp-$(HOST_SLIRP_VERSION)
HOST_SLIRP_SUFFIX	= tar.gz
HOST_SLIRP_URL		= $(PTXCONF_SETUP_SFMIRROR)/slirp/$(HOST_SLIRP).$(HOST_SLIRP_SUFFIX)
HOST_SLIRP_SOURCE	= $(SRCDIR)/$(HOST_SLIRP).$(HOST_SLIRP_SUFFIX)
HOST_SLIRP_DIR		= $(HOST_BUILDDIR)/$(HOST_SLIRP)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-slirp_get: $(STATEDIR)/host-slirp.get

host-slirp_get_deps = $(HOST_SLIRP_SOURCE)

$(STATEDIR)/host-slirp.get: $(host-slirp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_SLIRP))
	@$(call touch, $@)

$(HOST_SLIRP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_SLIRP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-slirp_extract: $(STATEDIR)/host-slirp.extract

host-slirp_extract_deps = $(STATEDIR)/host-slirp.get

$(STATEDIR)/host-slirp.extract: $(host-slirp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_SLIRP_DIR))
	@$(call extract, $(HOST_SLIRP_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_SLIRP), $(HOST_SLIRP_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-slirp_prepare: $(STATEDIR)/host-slirp.prepare

#
# dependencies
#
host-slirp_prepare_deps = \
	$(STATEDIR)/host-slirp.extract

HOST_SLIRP_PATH		=  PATH=$(HOST_PATH)
HOST_SLIRP_ENV 		=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_SLIRP_AUTOCONF  = $(HOST_AUTOCONF)
HOST_SLIRP_AUTOCONF += --prefix=$(PTXCONF_PREFIX)/usr

$(STATEDIR)/host-slirp.prepare: $(host-slirp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_SLIRP_DIR)/config.cache)
	cd $(HOST_SLIRP_DIR)/src && \
		$(HOST_SLIRP_PATH) $(HOST_SLIRP_ENV) \
		./configure $(HOST_SLIRP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-slirp_compile: $(STATEDIR)/host-slirp.compile

host-slirp_compile_deps = $(STATEDIR)/host-slirp.prepare

$(STATEDIR)/host-slirp.compile: $(host-slirp_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOST_SLIRP_DIR)/src && $(HOST_SLIRP_ENV) $(HOST_SLIRP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-slirp_install: $(STATEDIR)/host-slirp.install

host-slirp_install_deps = $(STATEDIR)/host-slirp.compile

$(STATEDIR)/host-slirp.install: $(host-slirp_install_deps)
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/usr/bin
	mkdir -p $(PTXCONF_PREFIX)/usr/man/man1
	@$(call install, HOST_SLIRP, $(HOST_SLIRP_DIR)/src ,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-slirp_clean:
	rm -rf $(STATEDIR)/host-slirp.*
	rm -rf $(HOST_SLIRP_DIR)

# vim: syntax=make

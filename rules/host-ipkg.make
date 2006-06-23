# -*-makefile-*-
# $Id:$
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
HOST_PACKAGES-$(PTXCONF_HOST_IPKG) += host-ipkg

#
# Paths and names
#

HOST_IPKG_VERSION	= 0.99.157
HOST_IPKG		= ipkg-$(HOST_IPKG_VERSION)
HOST_IPKG_SUFFIX	= tar.gz
HOST_IPKG_URL		= http://handhelds.org/download/packages/ipkg/$(HOST_IPKG).$(HOST_IPKG_SUFFIX)
HOST_IPKG_SOURCE	= $(SRCDIR)/$(HOST_IPKG).$(HOST_IPKG_SUFFIX)
HOST_IPKG_DIR		= $(HOST_BUILDDIR)/$(HOST_IPKG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ipkg_get: $(STATEDIR)/host-ipkg.get

$(STATEDIR)/host-ipkg.get: $(host-ipkg_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ipkg_extract: $(STATEDIR)/host-ipkg.extract

$(STATEDIR)/host-ipkg.extract: $(host-ipkg_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_IPKG_DIR))
	@$(call extract, HOST_IPKG, $(HOST_BUILDDIR))
	@$(call patchin, HOST_IPKG, $(HOST_IPKG_DIR))

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ipkg_prepare: $(STATEDIR)/host-ipkg.prepare

HOST_IPKG_PATH	:= PATH=$(HOST_PATH)
HOST_IPKG_ENV	:= $(HOSTCC_ENV)

#
# autoconf
#
HOST_IPKG_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-ipkg.prepare: $(host-ipkg_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_IPKG_DIR)/config.cache)
	cd $(HOST_IPKG_DIR) && \
		$(HOST_IPKG_PATH) $(HOST_IPKG_ENV) \
		./configure $(HOST_IPKG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-ipkg_compile: $(STATEDIR)/host-ipkg.compile

$(STATEDIR)/host-ipkg.compile: $(host-ipkg_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_IPKG_DIR) && $(HOST_IPKG_ENV) $(HOST_IPKG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ipkg_install: $(STATEDIR)/host-ipkg.install

$(STATEDIR)/host-ipkg.install: $(host-ipkg_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_IPKG,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-ipkg_targetinstall: $(STATEDIR)/host-ipkg.targetinstall

$(STATEDIR)/host-ipkg.targetinstall: $(host-ipkg_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ipkg_clean:
	rm -rf $(STATEDIR)/host-ipkg.*
	rm -rf $(HOST_IPKG_DIR)

# vim: syntax=make

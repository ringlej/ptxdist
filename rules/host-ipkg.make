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

HOST_IPKG_VERSION	= 0.99.154
HOST_IPKG		= ipkg-$(HOST_IPKG_VERSION)
HOST_IPKG_SUFFIX	= tar.gz
HOST_IPKG_URL	= http://www.handhelds.org/download/packages/ipkg/$(HOST_IPKG).$(HOST_IPKG_SUFFIX)
HOST_IPKG_SOURCE	= $(SRCDIR)/$(HOST_IPKG).$(HOST_IPKG_SUFFIX)
HOST_IPKG_DIR	= $(HOST_BUILDDIR)/$(HOST_IPKG)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ipkg_get: $(STATEDIR)/host-ipkg.get

host-ipkg_get_deps = $(HOST_IPKG_SOURCE)

$(STATEDIR)/host-ipkg.get: $(host-ipkg_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_IPKG))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ipkg_extract: $(STATEDIR)/host-ipkg.extract

host-ipkg_extract_deps = $(STATEDIR)/host-ipkg.get

$(STATEDIR)/host-ipkg.extract: $(host-ipkg_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_IPKG_DIR))
	@$(call extract, $(HOST_IPKG_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_IPKG), $(HOST_IPKG_DIR))

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ipkg_prepare: $(STATEDIR)/host-ipkg.prepare

#
# dependencies
#
host-ipkg_prepare_deps = \
	$(STATEDIR)/host-ipkg.extract

HOST_IPKG_PATH	=  PATH=$(CROSS_PATH)
HOST_IPKG_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_IPKG_AUTOCONF  = $(HOST_AUTOCONF)

$(STATEDIR)/host-ipkg.prepare: $(host-ipkg_prepare_deps)
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

host-ipkg_compile_deps = $(STATEDIR)/host-ipkg.prepare

$(STATEDIR)/host-ipkg.compile: $(host-ipkg_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOST_IPKG_DIR) && $(HOST_IPKG_ENV) $(HOST_IPKG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ipkg_install: $(STATEDIR)/host-ipkg.install

$(STATEDIR)/host-ipkg.install: $(STATEDIR)/host-ipkg.compile
	@$(call targetinfo, $@)
	@$(call install, HOST_IPKG,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-ipkg_targetinstall: $(STATEDIR)/host-ipkg.targetinstall

host-ipkg_targetinstall_deps = $(STATEDIR)/host-ipkg.install

$(STATEDIR)/host-ipkg.targetinstall: $(host-ipkg_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ipkg_clean:
	rm -rf $(STATEDIR)/host-ipkg.*
	rm -rf $(HOST_IPKG_DIR)

# vim: syntax=make

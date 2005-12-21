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
HOST_PACKAGES-$(PTXCONF_HOSTTOOL_IPKG) += hosttool-ipkg

#
# Paths and names
#

HOSTTOOL_IPKG_VERSION	= 0.99.154
HOSTTOOL_IPKG		= ipkg-$(HOSTTOOL_IPKG_VERSION)
HOSTTOOL_IPKG_SUFFIX	= tar.gz
HOSTTOOL_IPKG_URL	= http://www.handhelds.org/download/packages/ipkg/$(HOSTTOOL_IPKG).$(HOSTTOOL_IPKG_SUFFIX)
HOSTTOOL_IPKG_SOURCE	= $(SRCDIR)/$(HOSTTOOL_IPKG).$(HOSTTOOL_IPKG_SUFFIX)
HOSTTOOL_IPKG_DIR	= $(HOST_BUILDDIR)/$(HOSTTOOL_IPKG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-ipkg_get: $(STATEDIR)/hosttool-ipkg.get

hosttool-ipkg_get_deps = $(HOSTTOOL_IPKG_SOURCE)

$(STATEDIR)/hosttool-ipkg.get: $(hosttool-ipkg_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_IPKG))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-ipkg_extract: $(STATEDIR)/hosttool-ipkg.extract

hosttool-ipkg_extract_deps = $(STATEDIR)/hosttool-ipkg.get

$(STATEDIR)/hosttool-ipkg.extract: $(hosttool-ipkg_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_IPKG_DIR))
	@$(call extract, $(HOSTTOOL_IPKG_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL_IPKG), $(HOSTTOOL_IPKG_DIR))

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-ipkg_prepare: $(STATEDIR)/hosttool-ipkg.prepare

#
# dependencies
#
hosttool-ipkg_prepare_deps = \
	$(STATEDIR)/hosttool-ipkg.extract

HOSTTOOL_IPKG_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL_IPKG_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOSTTOOL_IPKG_AUTOCONF =  --prefix=$(PTXCONF_PREFIX)
HOSTTOOL_IPKG_AUTOCONF += --build=$(GNU_HOST)
HOSTTOOL_IPKG_AUTOCONF += --host=$(GNU_HOST)
HOSTTOOL_IPKG_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/hosttool-ipkg.prepare: $(hosttool-ipkg_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_IPKG_DIR)/config.cache)
	cd $(HOSTTOOL_IPKG_DIR) && \
		$(HOSTTOOL_IPKG_PATH) $(HOSTTOOL_IPKG_ENV) \
		./configure $(HOSTTOOL_IPKG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-ipkg_compile: $(STATEDIR)/hosttool-ipkg.compile

hosttool-ipkg_compile_deps = $(STATEDIR)/hosttool-ipkg.prepare

$(STATEDIR)/hosttool-ipkg.compile: $(hosttool-ipkg_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_IPKG_DIR) && $(HOSTTOOL_IPKG_ENV) $(HOSTTOOL_IPKG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-ipkg_install: $(STATEDIR)/hosttool-ipkg.install

$(STATEDIR)/hosttool-ipkg.install: $(STATEDIR)/hosttool-ipkg.compile
	@$(call targetinfo, $@)
	@$(call install, HOSTTOOL_IPKG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-ipkg_targetinstall: $(STATEDIR)/hosttool-ipkg.targetinstall

hosttool-ipkg_targetinstall_deps = $(STATEDIR)/hosttool-ipkg.install

$(STATEDIR)/hosttool-ipkg.targetinstall: $(hosttool-ipkg_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-ipkg_clean:
	rm -rf $(STATEDIR)/hosttool-ipkg.*
	rm -rf $(HOSTTOOL_IPKG_DIR)

# vim: syntax=make

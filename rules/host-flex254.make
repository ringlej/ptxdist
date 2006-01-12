# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 Ladislav Michl <ladis@linux-mips.org>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FLEX254) += host-flex254

#
# Paths and names
#
HOST_FLEX254_DIR	= $(HOST_BUILDDIR)/$(FLEX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-flex254_get: $(STATEDIR)/host-flex254.get

host-flex254_get_deps = $(STATEDIR)/flex.get

$(STATEDIR)/host-flex254.get: $(host-flex254_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-flex254_extract: $(STATEDIR)/host-flex254.extract

host-flex254_extract_deps = $(STATEDIR)/host-flex254.get

$(STATEDIR)/host-flex254.extract: $(host-flex254_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FLEX254_DIR))
	@$(call extract, $(FLEX_SOURCE), $(HOST_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-flex254_prepare: $(STATEDIR)/host-flex254.prepare

#
# dependencies
#
host-flex254_prepare_deps = \
	$(STATEDIR)/host-flex254.extract

HOST_FLEX254_PATH	=  PATH=$(CROSS_PATH)
HOST_FLEX254_ENV 	=  $(HOSTCC_ENV)

#
# autoconf, but without automake :-(
#
HOST_FLEX254_AUTOCONF = --prefix=$(PTXCONF_PREFIX)/usr

$(STATEDIR)/host-flex254.prepare: $(host-flex254_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FLEX254_DIR)/config.cache)
	cd $(HOST_FLEX254_DIR) && \
		$(HOST_FLEX254_PATH) $(HOST_FLEX254_ENV) \
		./configure $(HOST_FLEX254_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-flex254_compile: $(STATEDIR)/host-flex254.compile

host-flex254_compile_deps = $(STATEDIR)/host-flex254.prepare

$(STATEDIR)/host-flex254.compile: $(host-flex254_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_FLEX254_DIR) && $(HOST_FLEX254_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-flex254_install: $(STATEDIR)/host-flex254.install

$(STATEDIR)/host-flex254.install: $(STATEDIR)/host-flex254.compile
	@$(call targetinfo, $@)
	@$(call install, HOST_FLEX254,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-flex254_targetinstall: $(STATEDIR)/host-flex254.targetinstall

host-flex254_targetinstall_deps = $(STATEDIR)/host-flex254.compile

$(STATEDIR)/host-flex254.targetinstall: $(host-flex254_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-flex254_clean:
	rm -rf $(STATEDIR)/host-flex254.*
	rm -rf $(HOST_FLEX254_DIR)

# vim: syntax=make

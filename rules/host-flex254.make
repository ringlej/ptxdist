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
HOST_PACKAGES-$(PTXCONF_HOSTTOOL_FLEX254) += hosttool-flex254

#
# Paths and names
#
HOSTTOOL_FLEX254_DIR	= $(HOST_BUILDDIR)/$(FLEX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-flex254_get: $(STATEDIR)/hosttool-flex254.get

hosttool-flex254_get_deps = $(STATEDIR)/flex.get

$(STATEDIR)/hosttool-flex254.get: $(hosttool-flex254_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-flex254_extract: $(STATEDIR)/hosttool-flex254.extract

hosttool-flex254_extract_deps = $(STATEDIR)/hosttool-flex254.get

$(STATEDIR)/hosttool-flex254.extract: $(hosttool-flex254_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_FLEX254_DIR))
	@$(call extract, $(FLEX_SOURCE), $(HOST_BUILDDIR))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-flex254_prepare: $(STATEDIR)/hosttool-flex254.prepare

#
# dependencies
#
hosttool-flex254_prepare_deps = \
	$(STATEDIR)/hosttool-flex254.extract

HOSTTOOL_FLEX254_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL_FLEX254_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOSTTOOL_FLEX254_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST)

$(STATEDIR)/hosttool-flex254.prepare: $(hosttool-flex254_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_FLEX254_DIR)/config.cache)
	cd $(HOSTTOOL_FLEX254_DIR) && \
		$(HOSTTOOL_FLEX254_PATH) $(HOSTTOOL_FLEX254_ENV) \
		./configure $(HOSTTOOL_FLEX254_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-flex254_compile: $(STATEDIR)/hosttool-flex254.compile

hosttool-flex254_compile_deps = $(STATEDIR)/hosttool-flex254.prepare

$(STATEDIR)/hosttool-flex254.compile: $(hosttool-flex254_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_FLEX254_DIR) && $(HOSTTOOL_FLEX254_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-flex254_install: $(STATEDIR)/hosttool-flex254.install

$(STATEDIR)/hosttool-flex254.install: $(STATEDIR)/hosttool-flex254.compile
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_FLEX254_DIR) && $(HOSTTOOL_FLEX254_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-flex254_targetinstall: $(STATEDIR)/hosttool-flex254.targetinstall

hosttool-flex254_targetinstall_deps = $(STATEDIR)/hosttool-flex254.compile

$(STATEDIR)/hosttool-flex254.targetinstall: $(hosttool-flex254_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-flex254_clean:
	rm -rf $(STATEDIR)/hosttool-flex254.*
	rm -rf $(HOSTTOOL_FLEX254_DIR)

# vim: syntax=make

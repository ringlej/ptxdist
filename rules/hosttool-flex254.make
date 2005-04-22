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
ifdef PTXCONF_HOSTTOOLS_FLEX254
PACKAGES += hosttool-flex254
endif

#
# Paths and names
#
HOSTTOOLS_FLEX254_DIR	= $(HOSTTOOLS_BUILDDIR)/$(FLEX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-flex254_get: $(STATEDIR)/hosttool-flex254.get

hosttool-flex254_get_deps = $(STATEDIR)/flex.get

$(STATEDIR)/hosttool-flex254.get: $(hosttool-flex254_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-flex254_extract: $(STATEDIR)/hosttool-flex254.extract

hosttool-flex254_extract_deps = $(STATEDIR)/hosttool-flex254.get

$(STATEDIR)/hosttool-flex254.extract: $(hosttool-flex254_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_FLEX254_DIR))
	@$(call extract, $(FLEX_SOURCE), $(HOSTTOOLS_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-flex254_prepare: $(STATEDIR)/hosttool-flex254.prepare

#
# dependencies
#
hosttool-flex254_prepare_deps = \
	$(STATEDIR)/hosttool-flex254.extract

HOSTTOOLS_FLEX254_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOLS_FLEX254_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOSTTOOLS_FLEX254_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST)

$(STATEDIR)/hosttool-flex254.prepare: $(hosttool-flex254_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_FLEX254_DIR)/config.cache)
	cd $(HOSTTOOLS_FLEX254_DIR) && \
		$(HOSTTOOLS_FLEX254_PATH) $(HOSTTOOLS_FLEX254_ENV) \
		./configure $(HOSTTOOLS_FLEX254_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-flex254_compile: $(STATEDIR)/hosttool-flex254.compile

hosttool-flex254_compile_deps = $(STATEDIR)/hosttool-flex254.prepare

$(STATEDIR)/hosttool-flex254.compile: $(hosttool-flex254_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_FLEX254_DIR) && $(HOSTTOOLS_FLEX254_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-flex254_install: $(STATEDIR)/hosttool-flex254.install

$(STATEDIR)/hosttool-flex254.install: $(STATEDIR)/hosttool-flex254.compile
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_FLEX254_DIR) && $(HOSTTOOLS_FLEX254_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-flex254_targetinstall: $(STATEDIR)/hosttool-flex254.targetinstall

hosttool-flex254_targetinstall_deps = $(STATEDIR)/hosttool-flex254.compile

$(STATEDIR)/hosttool-flex254.targetinstall: $(hosttool-flex254_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-flex254_clean:
	rm -rf $(STATEDIR)/hosttool-flex254.*
	rm -rf $(HOSTTOOLS_FLEX254_DIR)

# vim: syntax=make

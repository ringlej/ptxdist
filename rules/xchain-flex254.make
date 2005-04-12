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
ifdef PTXCONF_XCHAIN_FLEX254
PACKAGES += xchain-flex254
endif

#
# Paths and names
#
XCHAIN_FLEX254_DIR	= $(XCHAIN_BUILDDIR)/$(FLEX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-flex254_get: $(STATEDIR)/xchain-flex254.get

xchain-flex254_get_deps = $(STATEDIR)/flex.get

$(STATEDIR)/xchain-flex254.get: $(xchain-flex254_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-flex254_extract: $(STATEDIR)/xchain-flex254.extract

xchain-flex254_extract_deps = $(STATEDIR)/xchain-flex254.get

$(STATEDIR)/xchain-flex254.extract: $(xchain-flex254_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_FLEX254_DIR))
	@$(call extract, $(FLEX_SOURCE), $(XCHAIN_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-flex254_prepare: $(STATEDIR)/xchain-flex254.prepare

#
# dependencies
#
xchain-flex254_prepare_deps = \
	$(STATEDIR)/xchain-flex254.extract

XCHAIN_FLEX254_PATH	=  PATH=$(CROSS_PATH)
XCHAIN_FLEX254_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
XCHAIN_FLEX254_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX)/$(XCHAIN_FLEX254) \
	--build=$(GNU_HOST)

$(STATEDIR)/xchain-flex254.prepare: $(xchain-flex254_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_FLEX254_DIR)/config.cache)
	cd $(XCHAIN_FLEX254_DIR) && \
		$(XCHAIN_FLEX254_PATH) $(XCHAIN_FLEX254_ENV) \
		./configure $(XCHAIN_FLEX254_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-flex254_compile: $(STATEDIR)/xchain-flex254.compile

xchain-flex254_compile_deps = $(STATEDIR)/xchain-flex254.prepare

$(STATEDIR)/xchain-flex254.compile: $(xchain-flex254_compile_deps)
	@$(call targetinfo, $@)
	cd $(XCHAIN_FLEX254_DIR) && $(XCHAIN_FLEX254_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-flex254_install: $(STATEDIR)/xchain-flex254.install

$(STATEDIR)/xchain-flex254.install: $(STATEDIR)/xchain-flex254.compile
	@$(call targetinfo, $@)
	cd $(XCHAIN_FLEX254_DIR) && $(XCHAIN_FLEX254_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-flex254_targetinstall: $(STATEDIR)/xchain-flex254.targetinstall

xchain-flex254_targetinstall_deps = $(STATEDIR)/xchain-flex254.compile

$(STATEDIR)/xchain-flex254.targetinstall: $(xchain-flex254_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-flex254_clean:
	rm -rf $(STATEDIR)/xchain-flex254.*
	rm -rf $(XCHAIN_FLEX254_DIR)

# vim: syntax=make

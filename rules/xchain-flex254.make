# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
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
XCHAIN_FLEX254_VERSION	= 2.5.4
XCHAIN_FLEX254		= flex-$(XCHAIN_FLEX254_VERSION)
XCHAIN_FLEX254_TARBALL	= flex-$(XCHAIN_FLEX254_VERSION)a.$(XCHAIN_FLEX254_SUFFIX)
XCHAIN_FLEX254_SUFFIX	= tar.gz
XCHAIN_FLEX254_URL	= $(PTXCONF_GNUMIRROR)/non-gnu/flex/$(XCHAIN_FLEX254_TARBALL)
XCHAIN_FLEX254_SOURCE	= $(SRCDIR)/$(XCHAIN_FLEX254_TARBALL)
XCHAIN_FLEX254_DIR	= $(XCHAIN_BUILDDIR)/$(XCHAIN_FLEX254)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-flex254_get: $(STATEDIR)/xchain-flex254.get

xchain-flex254_get_deps = $(XCHAIN_FLEX254_SOURCE)

$(STATEDIR)/xchain-flex254.get: $(xchain-flex254_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(XCHAIN_FLEX254_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN_FLEX254_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-flex254_extract: $(STATEDIR)/xchain-flex254.extract

xchain-flex254_extract_deps = $(STATEDIR)/xchain-flex254.get

$(STATEDIR)/xchain-flex254.extract: $(xchain-flex254_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_FLEX254_DIR))
	@$(call extract, $(XCHAIN_FLEX254_SOURCE), $(XCHAIN_BUILDDIR))
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
	$(XCHAIN_FLEX254_PATH) make -C $(XCHAIN_FLEX254_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-flex254_install: $(STATEDIR)/xchain-flex254.install

$(STATEDIR)/xchain-flex254.install: $(STATEDIR)/xchain-flex254.compile
	@$(call targetinfo, $@)
	$(XCHAIN_FLEX254_PATH) make -C $(XCHAIN_FLEX254_DIR) install
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

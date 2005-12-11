# -*-makefile-*-
# $Id: xchain-python24.make 3172 2005-09-28 15:01:53Z rsc $
#
# Copyright (C) 2003 by David R Bacon
#             Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
XCHAIN-$(PTXCONF_PYTHON24) += xchain-python24

#
# Paths and names
#
XCHAIN_PYTHON24_BUILDDIR	= $(HOST_BUILDDIR)/xchain-$(PYTHON24)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-python24_get: $(STATEDIR)/xchain-python24.get

$(STATEDIR)/xchain-python24.get: $(STATEDIR)/python24.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-python24_extract: $(STATEDIR)/xchain-python24.extract

$(STATEDIR)/xchain-python24.extract: $(STATEDIR)/python24.extract
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-python24_prepare: $(STATEDIR)/xchain-python24.prepare

#
# dependencies
#
xchain-python24_prepare_deps = \
	$(STATEDIR)/xchain-python24.extract

XCHAIN_PYTHON24_ENV		= $(HOSTCC_ENV)
XCHAIN_PYTHON24_AUTOCONF	= --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/xchain-python24.prepare: $(xchain-python24_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_PYTHON24_BUILDDIR))
	mkdir -p $(XCHAIN_PYTHON24_BUILDDIR)
	cd $(XCHAIN_PYTHON24_BUILDDIR) && \
		$(XCHAIN_PYTHON24_ENV) \
		$(PYTHON24_DIR)/configure $(XCHAIN_PYTHON24_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-python24_compile: $(STATEDIR)/xchain-python24.compile

$(STATEDIR)/xchain-python24.compile: $(STATEDIR)/xchain-python24.prepare
	@$(call targetinfo, $@)
	cd $(XCHAIN_PYTHON24_BUILDDIR) && make python
	cd $(XCHAIN_PYTHON24_BUILDDIR) && make Parser/pgen
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-python24_install: $(STATEDIR)/xchain-python24.install

$(STATEDIR)/xchain-python24.install: $(STATEDIR)/xchain-python24.compile
	@$(call targetinfo, $@)
# 	make -C $(XCHAIN_PYTHON24_BUILDDIR) bininstall
# 	install $(XCHAIN_PYTHON24_BUILDDIR)/Parser/pgen $(PTXCONF_PREFIX)/bin/pgen
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-python24_targetinstall: $(STATEDIR)/xchain-python24.targetinstall

$(STATEDIR)/xchain-python24.targetinstall:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-python24_clean: 
	rm -rf $(STATEDIR)/xchain-python24*
	rm -rf $(STATEDIR)/python24.extract
	rm -rf $(STATEDIR)/python24.prepare
	rm -rf $(STATEDIR)/python24.compile
	rm -rf $(XCHAIN_PYTHON24_BUILDDIR)
	rm -rf $(PYTHON24_BUILDDIR)
	rm -rf $(PYTHON24_DIR)

# vim: syntax=make

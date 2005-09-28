# -*-makefile-*-
# $Id$
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
ifdef PTXCONF_KAFFE
XCHAIN += xchain-python
endif

#
# Paths and names
#
XCHAIN_PYTHON_BUILDDIR	= $(BUILDDIR)/xchain-$(PYTHON)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-python_get: $(STATEDIR)/xchain-python.get

$(STATEDIR)/xchain-python.get: $(STATEDIR)/python.get
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-python_extract: $(STATEDIR)/xchain-python.extract

$(STATEDIR)/xchain-python.extract: $(STATEDIR)/python.extract
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-python_prepare: $(STATEDIR)/xchain-python.prepare

#
# dependencies
#
xchain-python_prepare_deps = \
	$(STATEDIR)/xchain-python.extract

XCHAIN_PYTHON_ENV	= $(HOSTCC_ENV)
XCHAIN_PYTHON_AUTOCONF	= --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/xchain-python.prepare: $(xchain-python_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_PYTHON_BUILDDIR))
	mkdir -p $(XCHAIN_PYTHON_BUILDDIR)
	cd $(XCHAIN_PYTHON_BUILDDIR) && \
		$(XCHAIN_PYTHON_ENV) \
		$(PYTHON_DIR)/configure $(XCHAIN_PYTHON_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-python_compile: $(STATEDIR)/xchain-python.compile

$(STATEDIR)/xchain-python.compile: $(STATEDIR)/xchain-python.prepare
	@$(call targetinfo, $@)
	make -C $(XCHAIN_PYTHON_BUILDDIR) python
	make -C $(XCHAIN_PYTHON_BUILDDIR) Parser/pgen
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-python_install: $(STATEDIR)/xchain-python.install

$(STATEDIR)/xchain-python.install: $(STATEDIR)/xchain-python.compile
	@$(call targetinfo, $@)
# 	make -C $(XCHAIN_PYTHON_BUILDDIR) bininstall
# 	install $(XCHAIN_PYTHON_BUILDDIR)/Parser/pgen $(PTXCONF_PREFIX)/bin/pgen
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-python_targetinstall: $(STATEDIR)/xchain-python.targetinstall

$(STATEDIR)/xchain-python.targetinstall:
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-python_clean: 
	rm -rf $(STATEDIR)/xchain-python*
	rm -rf $(STATEDIR)/python.extract
	rm -rf $(STATEDIR)/python.prepare
	rm -rf $(STATEDIR)/python.compile
	rm -rf $(XCHAIN_PYTHON_BUILDDIR)
	rm -rf $(PYTHON_BUILDDIR)
	rm -rf $(PYTHON_DIR)

# vim: syntax=make
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

# FIXME: nothing to do? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_LILO) += lilo

#
# Paths and names 
#
LILO_VERSION	= 22.5.9
LILO		= lilo-$(LILO_VERSION)
LILO_URL	= http://home.san.rr.com/johninsd/pub/linux/lilo/obsolete/$(LILO).tar.gz
LILO_SOURCE	= $(SRCDIR)/$(LILO).tar.gz
LILO_DIR	= $(BUILDDIR)/$(LILO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lilo_get: $(STATEDIR)/lilo.get

lilo_get_deps =  $(LILO_SOURCE)

$(STATEDIR)/lilo.get: $(lilo_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LILO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LILO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lilo_extract: $(STATEDIR)/lilo.extract

$(STATEDIR)/lilo.extract: $(STATEDIR)/lilo.get
	@$(call targetinfo, $@)
	@$(call clean, $(LILO_DIR))
	@$(call extract, $(LILO_SOURCE))
	@$(call patchin, $(LILO))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lilo_prepare: $(STATEDIR)/lilo.prepare

LILO_PATH	= PATH=$(CROSS_PATH)
LILO_MAKEVARS 	= CROSS=$(COMPILER_PREFIX)

#
# dependencies
#
lilo_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/lilo.extract

$(STATEDIR)/lilo.prepare: $(lilo_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lilo_compile: $(STATEDIR)/lilo.compile

lilo_compile_deps =  $(STATEDIR)/lilo.prepare

$(STATEDIR)/lilo.compile: $(lilo_compile_deps) 
	@$(call targetinfo, $@)
	cd $(LILO_DIR) && $(LILO_PATH) make $(LILO_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lilo_install: $(STATEDIR)/lilo.install

$(STATEDIR)/lilo.install: $(STATEDIR)/lilo.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lilo_targetinstall: $(STATEDIR)/lilo.targetinstall

$(STATEDIR)/lilo.targetinstall: $(STATEDIR)/lilo.install
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lilo_clean:
	rm -rf $(STATEDIR)/lilo.*
	rm -rf $(IMAGEDIR)/lilo_*
	rm -rf $(LILO_DIR)

# vim: syntax=make

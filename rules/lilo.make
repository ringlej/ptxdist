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
LILO_VERSION	= 22.8
LILO		= lilo-$(LILO_VERSION)
LILO_URL	= http://home.san.rr.com/johninsd/pub/linux/lilo/$(LILO).src.tar.gz
LILO_SOURCE	= $(SRCDIR)/$(LILO).tar.gz
LILO_DIR	= $(BUILDDIR)/$(LILO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lilo_get: $(STATEDIR)/lilo.get

$(STATEDIR)/lilo.get: $(lilo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LILO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LILO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lilo_extract: $(STATEDIR)/lilo.extract

$(STATEDIR)/lilo.extract: $(lilo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LILO_DIR))
	@$(call extract, LILO)
	@$(call patchin, LILO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lilo_prepare: $(STATEDIR)/lilo.prepare

LILO_PATH	= PATH=$(CROSS_PATH)
LILO_MAKEVARS 	= CROSS=$(COMPILER_PREFIX)

$(STATEDIR)/lilo.prepare: $(lilo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lilo_compile: $(STATEDIR)/lilo.compile

$(STATEDIR)/lilo.compile: $(lilo_compile_deps_default) 
	@$(call targetinfo, $@)
	cd $(LILO_DIR) && $(LILO_PATH) make $(LILO_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lilo_install: $(STATEDIR)/lilo.install

$(STATEDIR)/lilo.install: $(lilo_install_deps_default) 
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lilo_targetinstall: $(STATEDIR)/lilo.targetinstall

$(STATEDIR)/lilo.targetinstall: $(lilo_targetinstall_deps_default) 
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

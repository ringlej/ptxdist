# -*-makefile-*-
# $Id: lilo.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LILO
PACKAGES += lilo
endif

#
# Paths and names 
#
LILO		= lilo-22.5.4
LILO_URL	= http://home.san.rr.com/johninsd/pub/linux/lilo/$(LILO).tar.gz
LILO_SOURCE	= $(SRCDIR)/$(LILO).tar.gz
LILO_DIR	= $(BUILDDIR)/$(LILO)
LILO_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lilo_get: $(STATEDIR)/lilo.get

lilo_get_deps =  $(LILO_SOURCE)

$(STATEDIR)/lilo.get: $(lilo_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LILO_SOURCE):
	@$(call targetinfo, $@)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(LILO_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lilo_extract: $(STATEDIR)/lilo.extract

$(STATEDIR)/lilo.extract: $(STATEDIR)/lilo.get
	@$(call targetinfo, $@)
	$(LILO_EXTRACT) $(LILO_SOURCE) | tar -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lilo_prepare: $(STATEDIR)/lilo.prepare

LILO_PATH	= PATH=$(CROSS_PATH)
LILO_MAKEVARS 	= CROSS=$(PTXCONF_GNU_TARGET)-

#
# dependencies
#
lilo_prepare_deps =  $(STATEDIR)/lilo.extract $(STATEDIR)/virtual-xchain.install

$(STATEDIR)/lilo.prepare: $(lilo_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lilo_compile: $(STATEDIR)/lilo.compile

lilo_compile_deps =  $(STATEDIR)/lilo.prepare

$(STATEDIR)/lilo.compile: $(lilo_compile_deps) 
	@$(call targetinfo, $@)
	$(LILO_PATH) make -C $(LILO_DIR) $(LILO_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lilo_install: $(STATEDIR)/lilo.install

$(STATEDIR)/lilo.install: $(STATEDIR)/lilo.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lilo_targetinstall: $(STATEDIR)/lilo.targetinstall

$(STATEDIR)/lilo.targetinstall: $(STATEDIR)/lilo.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lilo_clean:
	-rm -rf $(STATEDIR)/lilo*
	-rm -rf $(LILO_DIR)

# vim: syntax=make
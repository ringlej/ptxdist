# -*-makefile-*-
# $Id: xchain-ksymoops.make,v 1.3 2003/10/23 20:42:01 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_KSYMOOPS
PACKAGES += ksymoops
endif

#
# Paths and names 
#
KSYMOOPS			= ksymoops-2.4.9
KSYMOOPS_URL			= http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/$(KSYMOOPS).tar.bz2
KSYMOOPS_SOURCE			= $(SRCDIR)/$(KSYMOOPS).tar.bz2
KSYMOOPS_DIR			= $(BUILDDIR)/$(KSYMOOPS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ksymoops_get: $(STATEDIR)/ksymoops.get

$(STATEDIR)/ksymoops.get: $(KSYMOOPS_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(KSYMOOPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KSYMOOPS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ksymoops_extract: $(STATEDIR)/ksymoops.extract

$(STATEDIR)/ksymoops.extract: $(STATEDIR)/ksymoops.get
	@$(call targetinfo, $@)
	@$(call clean, $(KSYMOOPS_DIR))
	@$(call extract, $(KSYMOOPS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ksymoops_prepare: $(STATEDIR)/ksymoops.prepare

KSYMOOPS_MAKEVARS = \
	CROSS=$(PTXCONF_GNU_TARGET)- \
	INSTALL_PREFIX=$(PTXCONF_PREFIX) \
	BFD_PREFIX=$(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET) \
	DEF_TARGET='\"elf32-$(subst ",,$(PTXCONF_ARCH))\"'

$(STATEDIR)/ksymoops.prepare:
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ksymoops_compile: $(STATEDIR)/ksymoops.compile

ksymoops_compile_deps = \
	$(STATEDIR)/xchain-binutils.install \
	$(STATEDIR)/ksymoops.extract

$(STATEDIR)/ksymoops.compile: $(ksymoops_compile_deps)
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ksymoops_install: $(STATEDIR)/ksymoops.install

$(STATEDIR)/ksymoops.install: $(STATEDIR)/ksymoops.compile
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ksymoops_targetinstall: $(STATEDIR)/ksymoops.targetinstall

$(STATEDIR)/ksymoops.targetinstall: $(STATEDIR)/ksymoops.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ksymoops_clean: 
	rm -rf $(STATEDIR)/ksymoops.* $(KSYMOOPS_DIR)

# vim: syntax=make

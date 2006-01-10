# -*-makefile-*-
# $Id:$
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
HOST_PACKAGES-$(PTXCONF_KSYMOOPS) += host-ksymoops

#
# Paths and names 
#
KSYMOOPS			= ksymoops-2.4.9
KSYMOOPS_URL			= http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/$(KSYMOOPS).tar.bz2
KSYMOOPS_SOURCE			= $(SRCDIR)/$(KSYMOOPS).tar.bz2
KSYMOOPS_DIR			= $(BUILDDIR)/$(KSYMOOPS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ksymoops_get: $(STATEDIR)/host-ksymoops.get

$(STATEDIR)/host-ksymoops.get: $(KSYMOOPS_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KSYMOOPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KSYMOOPS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ksymoops_extract: $(STATEDIR)/host-ksymoops.extract

$(STATEDIR)/host-ksymoops.extract: $(STATEDIR)/host-ksymoops.get
	@$(call targetinfo, $@)
	@$(call clean, $(KSYMOOPS_DIR))
	@$(call extract, $(KSYMOOPS_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ksymoops_prepare: $(STATEDIR)/host-ksymoops.prepare

KSYMOOPS_MAKEVARS = \
	CROSS=$(PTXCONF_GNU_TARGET)- \
	INSTALL_PREFIX=$(PTXCONF_PREFIX) \
	BFD_PREFIX=$(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET) \
	DEF_TARGET='\"elf32-$(call remove_quotes,$(PTXCONF_ARCH))\"'

$(STATEDIR)/host-ksymoops.prepare:
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-ksymoops_compile: $(STATEDIR)/host-ksymoops.compile

host-ksymoops_compile_deps = \
	$(STATEDIR)/host-ksymoops.extract

$(STATEDIR)/host-ksymoops.compile: $(host-ksymoops_compile_deps)
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ksymoops_install: $(STATEDIR)/host-ksymoops.install

$(STATEDIR)/host-ksymoops.install: $(STATEDIR)/host-ksymoops.compile
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS) install
#
# make short-name links to long-name programms
# e.g.: arm-linux-gcc -> arm-unknown-linux-gnu-gcc
#
	cd $(PTXCONF_PREFIX)/bin &&							\
		for FILE in host-ksymoops; do						\
		ln -sf $(PTXCONF_GNU_TARGET)-$$FILE $(SHORT_TARGET)-linux-$$FILE;	\
	done
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-ksymoops_targetinstall: $(STATEDIR)/host-ksymoops.targetinstall

$(STATEDIR)/host-ksymoops.targetinstall: $(STATEDIR)/host-ksymoops.install
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ksymoops_clean: 
	rm -rf $(STATEDIR)/host-ksymoops.* $(KSYMOOPS_DIR)

# vim: syntax=make

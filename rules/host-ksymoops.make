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
HOST_PACKAGES-$(PTXCONF_HOST_KSYMOOPS) += host-ksymoops

#
# Paths and names
#
HOST_KSYMOOPS		= ksymoops-2.4.9
HOST_KSYMOOPS_URL	= http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/$(HOST_KSYMOOPS).tar.bz2
HOST_KSYMOOPS_SOURCE	= $(SRCDIR)/$(HOST_KSYMOOPS).tar.bz2
HOST_KSYMOOPS_DIR	= $(HOST_BUILDDIR)/$(HOST_KSYMOOPS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ksymoops_get: $(STATEDIR)/host-ksymoops.get

$(STATEDIR)/host-ksymoops.get: $(host-ksymoops_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_KSYMOOPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_KSYMOOPS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ksymoops_extract: $(STATEDIR)/host-ksymoops.extract

$(STATEDIR)/host-ksymoops.extract: $(host-ksymoops_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_KSYMOOPS_DIR))
	@$(call extract, $(HOST_KSYMOOPS_SOURCE),$(HOST_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ksymoops_prepare: $(STATEDIR)/host-ksymoops.prepare

HOST_KSYMOOPS_MAKEVARS = \
	CROSS=$(PTXCONF_GNU_TARGET)- \
	INSTALL_PREFIX=$(PTXCONF_PREFIX) \
	BFD_PREFIX=$(PTXCONF_PREFIX) \
	DEF_TARGET='\"elf32-$(call remove_quotes,$(PTXCONF_ARCH))\"'

$(STATEDIR)/host-ksymoops.prepare: $(host-ksymoops_prepare_deps_default)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-ksymoops_compile: $(STATEDIR)/host-ksymoops.compile

$(STATEDIR)/host-ksymoops.compile: $(host-ksymoops_compile_deps_default)
	@$(call targetinfo, $@)
	make -C $(HOST_KSYMOOPS_DIR) $(HOST_KSYMOOPS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ksymoops_install: $(STATEDIR)/host-ksymoops.install

$(STATEDIR)/host-ksymoops.install: $(host-ksymoops_install_deps_default)
	@$(call targetinfo, $@)
	make -C $(HOST_KSYMOOPS_DIR) $(HOST_KSYMOOPS_MAKEVARS) install
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

$(STATEDIR)/host-ksymoops.targetinstall: $(host-ksymoops_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ksymoops_clean: 
	rm -rf $(STATEDIR)/host-ksymoops.* $(HOST_KSYMOOPS_DIR)

# vim: syntax=make

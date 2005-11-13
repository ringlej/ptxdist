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
HOST_PACKAGES-$(PTXCONF_KSYMOOPS) += hosttool-ksymoops

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

hosttool-ksymoops_get: $(STATEDIR)/hosttool-ksymoops.get

$(STATEDIR)/hosttool-ksymoops.get: $(KSYMOOPS_SOURCE)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(KSYMOOPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KSYMOOPS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-ksymoops_extract: $(STATEDIR)/hosttool-ksymoops.extract

$(STATEDIR)/hosttool-ksymoops.extract: $(STATEDIR)/hosttool-ksymoops.get
	@$(call targetinfo, $@)
	@$(call clean, $(KSYMOOPS_DIR))
	@$(call extract, $(KSYMOOPS_SOURCE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-ksymoops_prepare: $(STATEDIR)/hosttool-ksymoops.prepare

KSYMOOPS_MAKEVARS = \
	CROSS=$(PTXCONF_GNU_TARGET)- \
	INSTALL_PREFIX=$(PTXCONF_PREFIX) \
	BFD_PREFIX=$(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET) \
	DEF_TARGET='\"elf32-$(call remove_quotes,$(PTXCONF_ARCH))\"'

$(STATEDIR)/hosttool-ksymoops.prepare:
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-ksymoops_compile: $(STATEDIR)/hosttool-ksymoops.compile

hosttool-ksymoops_compile_deps = \
	$(STATEDIR)/hosttool-ksymoops.extract

$(STATEDIR)/hosttool-ksymoops.compile: $(hosttool-ksymoops_compile_deps)
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-ksymoops_install: $(STATEDIR)/hosttool-ksymoops.install

$(STATEDIR)/hosttool-ksymoops.install: $(STATEDIR)/hosttool-ksymoops.compile
	@$(call targetinfo, $@)
	make -C $(KSYMOOPS_DIR) $(KSYMOOPS_MAKEVARS) install
#
# make short-name links to long-name programms
# e.g.: arm-linux-gcc -> arm-unknown-linux-gnu-gcc
#
	cd $(PTXCONF_PREFIX)/bin &&							\
		for FILE in hosttool-ksymoops; do						\
		ln -sf $(PTXCONF_GNU_TARGET)-$$FILE $(SHORT_TARGET)-linux-$$FILE;	\
	done
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-ksymoops_targetinstall: $(STATEDIR)/hosttool-ksymoops.targetinstall

$(STATEDIR)/hosttool-ksymoops.targetinstall: $(STATEDIR)/hosttool-ksymoops.install
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-ksymoops_clean: 
	rm -rf $(STATEDIR)/hosttool-ksymoops.* $(KSYMOOPS_DIR)

# vim: syntax=make

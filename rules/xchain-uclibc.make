# -*-makefile-*-
# $Id: xchain-uclibc.make,v 1.4 2004/03/31 20:50:45 mkl Exp $
#
# Copyright (C) 2003, 2004 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
#ifdef PTXCONF_UCLIBC
#XCHAIN += xchain-uclibc
#endif

XCHAIN_UCLIBC_DIR	= $(BUILDDIR)/xchain/$(UCLIBC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-uclibc_get: $(STATEDIR)/xchain-uclibc.get

xchain-uclibc_get_deps = \
	$(uclibc_get_deps)

$(STATEDIR)/xchain-uclibc.get: $(xchain-uclibc_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-uclibc_extract: $(STATEDIR)/xchain-uclibc.extract

xchain-uclibc_extract_deps = $(STATEDIR)/xchain-uclibc.get

$(STATEDIR)/xchain-uclibc.extract: $(xchain-uclibc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_UCLIBC_DIR))
	@$(call extract, $(UCLIBC_SOURCE), $(XCHAIN_BUILDDIR))
	@$(call patchin, $(UCLIBC), $(XCHAIN_UCLIBC_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-uclibc_prepare: $(STATEDIR)/xchain-uclibc.prepare

xchain-uclibc_prepare_deps = \
	$(STATEDIR)/xchain-kernel.prepare \
	$(STATEDIR)/xchain-uclibc.extract

XCHAIN_UCLIBC_PATH	= PATH=$(CROSS_PATH)

XCHAIN_UCLIBC_MAKEVARS = \
	HOSTCC=$(HOSTCC) \
	TARGET_ARCH=$(PTXCONF_ARCH_USERSPACE)

# 	CROSS=$(PTXCONF_GNU_TARGET)- \

$(STATEDIR)/xchain-uclibc.prepare: $(xchain-uclibc_prepare_deps)
	@$(call targetinfo, $@)

	grep -e PTXCONF_UC_ .config > $(XCHAIN_UCLIBC_DIR)/.config
	perl -i -p -e 's/PTXCONF_UC_//g' $(XCHAIN_UCLIBC_DIR)/.config
	@$(call xchain-uclibc_fix_config, $(XCHAIN_UCLIBC_DIR)/.config)

	yes "" | $(XCHAIN_UCLIBC_PATH) $(MAKE) -C $(XCHAIN_UCLIBC_DIR) \
		$(XCHAIN_UCLIBC_MAKEVARS) \
		oldconfig
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-uclibc_compile: $(STATEDIR)/xchain-uclibc.compile

$(STATEDIR)/xchain-uclibc.compile: $(STATEDIR)/xchain-uclibc.prepare
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-uclibc_install: $(STATEDIR)/xchain-uclibc.install

$(STATEDIR)/xchain-uclibc.install: $(STATEDIR)/xchain-uclibc.compile
	@$(call targetinfo, $@)
	$(INSTALL) -d $(XCHAIN_UCLIBC_DIR)/lib
	$(XCHAIN_UCLIBC_PATH) $(MAKE) -C  $(XCHAIN_UCLIBC_DIR) \
		$(XCHAIN_UCLIBC_MAKEVARS) \
		headers install_dev
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-uclibc_targetinstall: $(STATEDIR)/xchain-uclibc.targetinstall

$(STATEDIR)/xchain-uclibc.targetinstall:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-uclibc_clean: 
	-rm -rf $(STATEDIR)/xchain-uclibc*
	-rm -rf $(XCHAIN_UCLIBC_DIR)
# vim: syntax=make
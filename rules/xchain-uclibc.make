# -*-makefile-*-
# $Id: xchain-uclibc.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_UCLIBC
XCHAIN += xchain-uclibc
endif

XCHAIN_UCLIBC_BUILDDIR	= $(BUILDDIR)/xchain/$(UCLIBC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-uclibc_get: $(STATEDIR)/xchain-uclibc.get

$(STATEDIR)/xchain-uclibc.get: $(uclibc_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-uclibc_extract: $(STATEDIR)/xchain-uclibc.extract

$(STATEDIR)/xchain-uclibc.extract: $(uclibc_get_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_UCLIBC_BUILDDIR))
	@$(call extract, $(UCLIBC_SOURCE), $(XCHAIN_BUILDDIR))
	@$(call patchin, $(UCLIBC), $(XCHAIN_UCLIBC_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-uclibc_prepare: $(STATEDIR)/xchain-uclibc.prepare

XCHAIN_UCLIBC_PATH	= PATH=$(CROSS_PATH)
XCHAIN_UCLIBC_MAKEVARS	= CROSS=$(PTXCONF_GNU_TARGET)- HOSTCC=$(HOSTCC)

xchain-uclibc_prepare_deps = \
	$(STATEDIR)/xchain-gccstage1.install \
	$(STATEDIR)/xchain-uclibc.extract

$(STATEDIR)/xchain-uclibc.prepare: $(xchain-uclibc_prepare_deps)
	@$(call targetinfo, $@)

	grep -e PTXCONF_UCLIBC_ .config > $(XCHAIN_UCLIBC_BUILDDIR)/.config
	perl -i -p -e 's/PTXCONF_UCLIBC_//g' $(XCHAIN_UCLIBC_BUILDDIR)/.config
	@$(call xchain-uclibc_fix_config, $(XCHAIN_UCLIBC_BUILDDIR)/.config)

	$(XCHAIN_UCLIBC_PATH) make -C $(XCHAIN_UCLIBC_BUILDDIR) oldconfig $(XCHAIN_UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-uclibc_compile: $(STATEDIR)/xchain-uclibc.compile

$(STATEDIR)/xchain-uclibc.compile: $(STATEDIR)/xchain-uclibc.prepare
	@$(call targetinfo, $@)
	$(XCHAIN_UCLIBC_PATH) make -C $(XCHAIN_UCLIBC_BUILDDIR) $(XCHAIN_UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-uclibc_install: $(STATEDIR)/xchain-uclibc.install

$(STATEDIR)/xchain-uclibc.install: $(STATEDIR)/xchain-uclibc.compile
	@$(call targetinfo, $@)
	$(XCHAIN_UCLIBC_PATH) make -C  $(XCHAIN_UCLIBC_BUILDDIR) \
		install_dev install_runtime install_utils \
		$(XCHAIN_UCLIBC_MAKEVARS) TARGET_ARCH=$(SHORT_TARGET)
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
	-rm -rf $(XCHAIN_UCLIBC_BUILDDIR)
# vim: syntax=make
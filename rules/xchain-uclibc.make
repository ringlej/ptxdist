# -*-makefile-*-
# $Id: xchain-uclibc.make,v 1.1 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
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
	@$(call targetinfo, xchain-uclibc.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-uclibc_extract: $(STATEDIR)/xchain-uclibc.extract

$(STATEDIR)/xchain-uclibc.extract: $(uclibc_get_deps)
	@$(call targetinfo, xchain-uclibc.extract)
	@$(call clean, $(XCHAIN_UCLIBC_BUILDDIR))
	@$(call extract, $(UCLIBC_SOURCE), $(XCHAIN_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-uclibc_prepare: $(STATEDIR)/xchain-uclibc.prepare

XCHAIN_UCLIBC_PATH	= PATH=$(CROSS_PATH)
XCHAIN_UCLIBC_MAKEVARS	= CROSS=$(PTXCONF_GNU_TARGET)- HOSTCC=$(HOSTCC)

$(STATEDIR)/xchain-uclibc.prepare: \
		$(STATEDIR)/xchain-gccstage1.install \
		$(STATEDIR)/xchain-uclibc.extract
	@$(call targetinfo, xchain-uclibc.prepare)

	grep -e PTXCONF_UCLIBC_ .config > $(XCHAIN_UCLIBC_BUILDDIR)/.config
	perl -i -p -e 's/PTXCONF_UCLIBC_//g' $(XCHAIN_UCLIBC_BUILDDIR)/.config
	@$(call xchain_uclibc_fix_config, $(XCHAIN_UCLIBC_BUILDDIR)/.config)

	$(XCHAIN_UCLIBC_PATH) make -C $(XCHAIN_UCLIBC_BUILDDIR) oldconfig $(XCHAIN_UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-uclibc_compile: $(STATEDIR)/xchain-uclibc.compile

$(STATEDIR)/xchain-uclibc.compile: $(STATEDIR)/xchain-uclibc.prepare
	@$(call targetinfo, xchain-uclibc.compile)
	$(XCHAIN_UCLIBC_PATH) make -C $(XCHAIN_UCLIBC_BUILDDIR) $(XCHAIN_UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-uclibc_install: $(STATEDIR)/xchain-uclibc.install

$(STATEDIR)/xchain-uclibc.install: $(STATEDIR)/xchain-uclibc.compile
	@$(call targetinfo, xchain-uclibc.install)
	$(XCHAIN_UCLIBC_PATH) make -C  $(XCHAIN_UCLIBC_BUILDDIR) \
		install_dev install_runtime install_utils \
		$(XCHAIN_UCLIBC_MAKEVARS) TARGET_ARCH=$(SHORT_TARGET)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-uclibc_targetinstall: $(STATEDIR)/xchain-uclibc.targetinstall

$(STATEDIR)/xchain-uclibc.targetinstall:
	@$(call targetinfo, xchain-uclibc.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-uclibc_clean: 
	-rm -rf $(STATEDIR)/xchain-uclibc*
	-rm -rf $(XCHAIN_UCLIBC_BUILDDIR)
# vim: syntax=make
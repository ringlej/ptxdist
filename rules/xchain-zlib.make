# -*-makefile-*-
# $Id: xchain-zlib.make,v 1.4 2003/10/26 21:59:07 mkl Exp $
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Paths and names 
#
XCHAIN_ZLIB_BUILDDIR	= $(BUILDDIR)/xchain/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-zlib_get: $(STATEDIR)/xchain-zlib.get

$(STATEDIR)/xchain-zlib.get: $(STATEDIR)/zlib.get
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-zlib_extract: $(STATEDIR)/xchain-zlib.extract

$(STATEDIR)/xchain-zlib.extract: $(STATEDIR)/xchain-zlib.get
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_ZLIB_BUILDDIR))
	@$(call extract, $(ZLIB_SOURCE), $(XCHAIN_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-zlib_prepare: $(STATEDIR)/xchain-zlib.prepare

XCHAIN_ZLIB_AUTOCONF	=  --shared
XCHAIN_ZLIB_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)
XCHAIN_ZLIB_MAKEVARS	=  $(HOSTCC_ENV)

$(STATEDIR)/xchain-zlib.prepare: $(STATEDIR)/xchain-zlib.extract
	@$(call targetinfo, $@)
	cd $(XCHAIN_ZLIB_BUILDDIR) && \
		./configure $(XCHAIN_ZLIB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xchain-zlib.compile: $(STATEDIR)/xchain-zlib.prepare 
	@$(call targetinfo, $@)
	make -C $(XCHAIN_ZLIB_BUILDDIR) $(XCHAIN_ZLIB_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-zlib_install: $(STATEDIR)/xchain-zlib.install

$(STATEDIR)/xchain-zlib.install: $(STATEDIR)/xchain-zlib.compile
	@$(call targetinfo, $@)
	make -C $(XCHAIN_ZLIB_BUILDDIR) $(XCHAIN_ZLIB_MAKEVARS) \
		install
	touch $@
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-zlib_targetinstall: $(STATEDIR)/xchain-zlib.targetinstall

$(STATEDIR)/xchain-zlib.targetinstall: $(STATEDIR)/xchain-zlib.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-zlib_clean:
	rm -rf $(STATEDIR)/xchain-zlib.*
	rm -rf $(XCHAIN_ZLIB_BUILDDIR)

# vim: syntax=make

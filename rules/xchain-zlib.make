# -*-makefile-*-
# $id$
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#

#
# Paths and names 
#
XCHAIN_ZLIB_BUILDDIR	= $(BUILDDIR)/xchain/$(ZLIB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-zlib_get: $(STATEDIR)/xchain-zlib.get

$(STATEDIR)/xchain-zlib.get: $(ZLIB_SOURCE)
	@$(call targetinfo, xchain-zlib.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-zlib_extract: $(STATEDIR)/xchain-zlib.extract

$(STATEDIR)/xchain-zlib.extract: $(STATEDIR)/xchain-zlib.get
	@$(call targetinfo, xchain-zlib.extract)
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
	@$(call targetinfo, xchain-zlib.prepare)
	cd $(XCHAIN_ZLIB_BUILDDIR) && \
		./configure $(XCHAIN_ZLIB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xchain-zlib.compile: $(STATEDIR)/xchain-zlib.prepare 
	@$(call targetinfo, xchain-zlib.compile)
	make -C $(XCHAIN_ZLIB_BUILDDIR) $(XCHAIN_ZLIB_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-zlib_install: $(STATEDIR)/xchain-zlib.install

$(STATEDIR)/xchain-zlib.install: $(STATEDIR)/xchain-zlib.compile
	@$(call targetinfo, xchain-zlib.install)
	make -C $(XCHAIN_ZLIB_BUILDDIR) $(XCHAIN_ZLIB_MAKEVARS) \
		install
	touch $@
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-zlib_targetinstall: $(STATEDIR)/xchain-zlib.targetinstall

$(STATEDIR)/xchain-zlib.targetinstall: $(STATEDIR)/xchain-zlib.install
	@$(call targetinfo, xchain-zlib.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-zlib_clean:
	rm -rf $(STATEDIR)/xchain-zlib.*
	rm -rf $(XCHAIN_ZLIB_BUILDDIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: xchain-glibc.make,v 1.10 2003/07/17 12:08:41 bsp Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GLIBC
XCHAIN += xchain-glibc
endif

XCHAIN_GLIBC_BUILDDIR	= $(BUILDDIR)/xchain-$(GLIBC)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-glibc_get:	$(STATEDIR)/xchain-glibc.get

$(STATEDIR)/xchain-glibc.get: $(glibc_get_deps)
	@$(call targetinfo, xchain-glibc.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-glibc_extract:	$(STATEDIR)/xchain-glibc.extract

$(STATEDIR)/xchain-glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, xchain-glibc.extract)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-glibc_prepare:	$(STATEDIR)/xchain-glibc.prepare

$(STATEDIR)/xchain-glibc.prepare: \
		$(STATEDIR)/autoconf213.install \
		$(STATEDIR)/xchain-gccstage1.install \
		$(STATEDIR)/xchain-glibc.extract
	@$(call targetinfo, xchain-glibc.prepare)
	@$(call clean, $(XCHAIN_GLIBC_BUILDDIR))
	mkdir -p $(XCHAIN_GLIBC_BUILDDIR)
	cd $(XCHAIN_GLIBC_BUILDDIR) &&					\
	        $(GLIBC_PATH) $(GLIBC_ENV)				\
		$(GLIBC_DIR)/configure $(PTXCONF_GNU_TARGET) 		\
		$(GLIBC_AUTOCONF)					\
		--prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)	\
		--libexecdir=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/bin
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-glibc_compile:	$(STATEDIR)/xchain-glibc.compile

$(STATEDIR)/xchain-glibc.compile: $(STATEDIR)/xchain-glibc.prepare 
	@$(call targetinfo, xchain-glibc.compile)
	cd $(XCHAIN_GLIBC_BUILDDIR) && $(GLIBC_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-glibc_install:	$(STATEDIR)/xchain-glibc.install

$(STATEDIR)/xchain-glibc.install: $(STATEDIR)/xchain-glibc.compile
	@$(call targetinfo, xchain-glibc.install)
	cd $(XCHAIN_GLIBC_BUILDDIR) && $(GLIBC_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-glibc_targetinstall:	$(STATEDIR)/xchain-glibc.targetinstall

$(STATEDIR)/xchain-glibc.targetinstall: $(STATEDIR)/xchain-glibc.install
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-glibc_clean:
	-rm -rf $(STATEDIR)/xchain-glibc*
	-rm -rf $(STATEDIR)/glibc*extract
	-rm -rf $(STATEDIR)/glibc.prepare
	-rm -rf $(STATEDIR)/glibc.compile
	-rm -rf $(GLIBC_DIR)
	-rm -rf $(GLIBC_BUILDDIR)
	-rm -rf $(XCHAIN_GLIBC_BUILDDIR)
# vim: syntax=make
# -*-makefile-*-
# $Id: xchain-kaffe.make,v 1.1 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_KAFFE
XCHAIN += xchain-kaffe
endif

#
# Paths and names
#
XCHAIN_KAFFE_BUILDDIR	= $(BUILDDIR)/xchain-$(KAFFE)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kaffe_get: $(STATEDIR)/xchain-kaffe.get

$(STATEDIR)/xchain-kaffe.get: $(kaffe_get_deps)
	@$(call targetinfo, xchain-kaffe.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-kaffe_extract: $(STATEDIR)/xchain-kaffe.extract

$(STATEDIR)/xchain-kaffe.extract: $(kaffe_extract_deps)
	@$(call targetinfo, xchain-kaffe.extract)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-kaffe_prepare: $(STATEDIR)/xchain-kaffe.prepare

XCHAIN_KAFFE_ENV = $(HOSTCC_ENV)

$(STATEDIR)/xchain-kaffe.prepare: $(STATEDIR)/xchain-kaffe.extract \
		$(STATEDIR)/xchain-kaffe.extract
	@$(call targetinfo, xchain-kaffe.prepare)
	@$(calll clean, $(XCHAIN_KAFFE_BUILDDIR))
	mkdir -p $(XCHAIN_KAFFE_BUILDDIR)
	cd $(XCHAIN_KAFFE_BUILDDIR) && \
		$(XCHAIN_KAFFE_ENV) \
		$(KAFFE_DIR)/configure --prefix=$(PTXCONF_PREFIX)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-kaffe_compile: $(STATEDIR)/xchain-kaffe.compile

$(STATEDIR)/xchain-kaffe.compile: $(STATEDIR)/xchain-kaffe.prepare
	@$(call targetinfo, xchain-kaffe.compile)
	make -C $(XCHAIN_KAFFE_BUILDDIR)/config
	make -C $(XCHAIN_KAFFE_BUILDDIR)/kaffe/kaffeh
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kaffe_install: $(STATEDIR)/xchain-kaffe.install

$(STATEDIR)/xchain-kaffe.install: $(STATEDIR)/xchain-kaffe.compile
	@$(call targetinfo, xchain-kaffe.install)
	make -C $(XCHAIN_KAFFE_BUILDDIR)/kaffe/kaffeh install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-kaffe_targetinstall: $(STATEDIR)/xchain-kaffe.targetinstall

$(STATEDIR)/xchain-kaffe.targetinstall:
	@$(call targetinfo, xchain-kaffe.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kaffe_clean: 
	rm -rf $(STATEDIR)/xchain-kaffe*
	rm -rf $(STATEDIR)/kaffe.extract
	rm -rf $(STATEDIR)/kaffe.prepare
	rm -rf $(STATEDIR)/kaffe.compile
	rm -rf $(XCHAIN_KAFFE_BUILDDIR)
	rm -rf $(KAFFE_BUILDDIR)
	rm -rf $(KAFFE_DIR)

# vim: syntax=make
# -*-makefile-*-
# $Id: xchain-kaffe.make,v 1.3 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
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
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-kaffe_extract: $(STATEDIR)/xchain-kaffe.extract

$(STATEDIR)/xchain-kaffe.extract: $(kaffe_extract_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-kaffe_prepare: $(STATEDIR)/xchain-kaffe.prepare

xchain-kaffe_prepare_deps = \
	$(STATEDIR)/xchain-kaffe.extract

XCHAIN_KAFFE_ENV = $(HOSTCC_ENV)

$(STATEDIR)/xchain-kaffe.prepare: $(xchain-kaffe_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_KAFFE_BUILDDIR))
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
	@$(call targetinfo, $@)
	make -C $(XCHAIN_KAFFE_BUILDDIR)/config
	make -C $(XCHAIN_KAFFE_BUILDDIR)/kaffe/kaffeh
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kaffe_install: $(STATEDIR)/xchain-kaffe.install

$(STATEDIR)/xchain-kaffe.install: $(STATEDIR)/xchain-kaffe.compile
	@$(call targetinfo, $@)
	make -C $(XCHAIN_KAFFE_BUILDDIR)/kaffe/kaffeh install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-kaffe_targetinstall: $(STATEDIR)/xchain-kaffe.targetinstall

$(STATEDIR)/xchain-kaffe.targetinstall:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kaffe_clean: 
	rm -rf $(STATEDIR)/xchain-kaffe*
	rm -rf $(XCHAIN_KAFFE_BUILDDIR)

# vim: syntax=make
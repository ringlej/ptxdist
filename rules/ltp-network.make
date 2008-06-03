# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2008 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_NETWORK) += ltp-network

#
# Paths and names
#
LTP_NETWORK_VERSION	= $(LTP_BASE_VERSION)
LTP_NETWORK		= ltp-network-$(LTP_BASE_VERSION)
LTP_NETWORK_PKGDIR	= $(PKGDIR)/$(LTP_NETWORK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-network_get: $(STATEDIR)/ltp-network.get

$(STATEDIR)/ltp-network.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-network_extract: $(STATEDIR)/ltp-network.extract

$(STATEDIR)/ltp-network.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-network_prepare: $(STATEDIR)/ltp-network.prepare

$(STATEDIR)/ltp-network.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-network_compile: $(STATEDIR)/ltp-network.compile

$(STATEDIR)/ltp-network.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/network; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-network_install: $(STATEDIR)/ltp-network.install

$(STATEDIR)/ltp-network.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_NETWORK_PKGDIR)/bin
	@ln -sf $(LTP_NETWORK_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/network; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-network_targetinstall: $(STATEDIR)/ltp-network.targetinstall

$(STATEDIR)/ltp-network.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-network)
	@$(call install_fixup, ltp-network,PACKAGE,ltp-network)
	@$(call install_fixup, ltp-network,PRIORITY,optional)
	@$(call install_fixup, ltp-network,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-network,SECTION,base)
	@$(call install_fixup, ltp-network,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-network,DEPENDS,)
	@$(call install_fixup, ltp-network,DESCRIPTION,missing)

	@cd $(LTP_NETWORK_PKGDIR)/bin; \
	for file in `find -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-network, 0, 0, $$PER, \
			$(LTP_NETWORK_PKGDIR)/bin/$$file, \
			$(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-network)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-network_clean:
	rm -rf $(STATEDIR)/ltp-network.*
	rm -rf $(PKGDIR)/ltp-network_*
	rm -rf $(LTP_NETWORK_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: wireless.make,v 1.1 2003/08/08 17:18:42 robert Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_WIRELESS))
PACKAGES += wireless
endif

#
# Paths and names 
#
WIRELESS_VERSION	= 26
WIRELESS		= wireless_tools.$(WIRELESS_VERSION)
WIRELESS_SUFFIX		= .tar.gz
WIRELESS_URL		= http://pcmcia-cs.sourceforge.net/ftp/contrib/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_SOURCE		= $(SRCDIR)/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_DIR 		= $(BUILDDIR)/$(WIRELESS)
WIRELESS_EXTRACT	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wireless_get: $(STATEDIR)/wireless.get

wireless_get_deps	= $(WIRELESS_SOURCE)

$(STATEDIR)/wireless.get: $(wireless_get_deps)
	@$(call targetinfo, wireless.get)
	touch $@

$(WIRELESS_SOURCE):
	@$(call targetinfo, $(WIRELESS_SOURCE))
	@$(call get, $(WIRELESS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wireless_extract: $(STATEDIR)/wireless.extract

wireless_extract_deps	= $(STATEDIR)/wireless.extract

$(STATEDIR)/wireless.extract: $(wireless_extract_deps)
	@$(call targetinfo, wireless.extract)
	@$(call clean, $(WIRELESS_DIR))
	@$(call extract, $(WIRELESS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wireless_prepare: $(STATEDIR)/wireless.prepare

wireless_prepare_deps	= $(STATEDIR)/wireless.extract

$(STATEDIR)/wireless.prepare: $(wireless_prepare_deps)
	@$(call targetinfo, wireless.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wireless_compile: $(STATEDIR)/wireless.compile

wireless_compile_deps	= $(STATEDIR)/wireless.prepare

$(STATEDIR)/wireless.compile: $(wireless_compile_deps) 
	@$(call targetinfo, wireless.compile)
	cd $(WIRELESS_DIR) && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wireless_install: $(STATEDIR)/wireless.install

wireless_compile_deps	= $(STATEDIR)/wireless.compile

$(STATEDIR)/wireless.install: $(wireless_compile_deps)
	@$(call targetinfo, wireless.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wireless_targetinstall: $(STATEDIR)/wireless.targetinstall

$(STATEDIR)/wireless.targetinstall: $(STATEDIR)/wireless.install
	@$(call targetinfo, wireless.targetinstall)
# TODO
	touch $@
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wireless_clean: 
	rm -rf $(STATEDIR)/wireless.* $(WIRELESS_DIR)

# vim: syntax=make

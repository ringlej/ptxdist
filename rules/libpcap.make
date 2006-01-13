# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCAP) += libpcap

#
# Paths and names
#
LIBPCAP_VERSION	= 0.8.3
LIBPCAP		= libpcap-$(LIBPCAP_VERSION)
LIBPCAP_SUFFIX	= tar.gz
LIBPCAP_URL	= http://www.tcpdump.org/release/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_SOURCE	= $(SRCDIR)/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_DIR	= $(BUILDDIR)/$(LIBPCAP)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpcap_get: $(STATEDIR)/libpcap.get

$(STATEDIR)/libpcap.get: $(libpcap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBPCAP))
	@$(call touch, $@)

$(LIBPCAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBPCAP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpcap_extract: $(STATEDIR)/libpcap.extract

$(STATEDIR)/libpcap.extract: $(libpcap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCAP_DIR))
	@$(call extract, $(LIBPCAP_SOURCE))
	@$(call patchin, $(LIBPCAP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpcap_prepare: $(STATEDIR)/libpcap.prepare

LIBPCAP_PATH	=  PATH=$(CROSS_PATH)
LIBPCAP_ENV = \
	$(CROSS_ENV) \
	ac_cv_linux_vers=2

#
# autoconf
#
LIBPCAP_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LIBPCAP_AUTOCONF += --with-pcap=linux

$(STATEDIR)/libpcap.prepare: $(libpcap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCAP_BUILDDIR))
	cd $(LIBPCAP_DIR) && \
		$(LIBPCAP_PATH) $(LIBPCAP_ENV) \
		./configure $(LIBPCAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpcap_compile: $(STATEDIR)/libpcap.compile

$(STATEDIR)/libpcap.compile: $(libpcap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPCAP_DIR) && $(LIBPCAP_PATH) make 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpcap_install: $(STATEDIR)/libpcap.install

$(STATEDIR)/libpcap.install: $(libpcap_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: shoudldn' that run on targetinstall? 
	@$(call install, LIBPCAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpcap_targetinstall: $(STATEDIR)/libpcap.targetinstall

$(STATEDIR)/libpcap.targetinstall: $(libpcap_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpcap_clean:
	rm -rf $(STATEDIR)/libpcap.*
	rm -rf $(LIBPCAP_DIR)

# vim: syntax=make

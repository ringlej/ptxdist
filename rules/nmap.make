# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Ixia Corporation (www.ixiacom.com), by Milan Bobde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NMAP) += nmap

#
# We depend on this package
#
ifdef PTXCONF_NMAP
PACKAGES += libpcap
endif

#
# Paths and names 
#
NMAP_VERSION		= 3.93
NMAP			= nmap-$(NMAP_VERSION)
NMAP_SUFFIX		= tgz
NMAP_URL		= http://download.insecure.org/nmap/dist/$(NMAP).$(NMAP_SUFFIX)
NMAP_SOURCE		= $(SRCDIR)/$(NMAP).$(NMAP_SUFFIX)
NMAP_DIR		= $(BUILDDIR)/$(NMAP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nmap_get: $(STATEDIR)/nmap.get

nmap_get_deps  =  $(NMAP_SOURCE)

$(STATEDIR)/nmap.get: $(nmap_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NMAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NMAP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nmap_extract: $(STATEDIR)/nmap.extract

$(STATEDIR)/nmap.extract: $(STATEDIR)/nmap.get
	@$(call targetinfo, $@)
	@$(call clean, $(NMAP_DIR))
	@$(call extract, $(NMAP_SOURCE))
	@$(call patchin, $(NMAP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nmap_prepare: $(STATEDIR)/nmap.prepare

#
# dependencies
#
nmap_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/nmap.extract \
	$(STATEDIR)/libpcap.install

NMAP_PATH	=  PATH=$(CROSS_PATH)
NMAP_ENV = \
	$(CROSS_ENV) \
	ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR)

#
# autoconf
#
NMAP_AUTOCONF =  $(CROSS_AUTOCONF_USR)
NMAP_AUTOCONF += --with-pcap=linux 
#
# FIXME:
#
# nmap works only with openssh shared libs, dunnno why...
#
ifdef PTXCONF_OPENSSL_SHARED
NMAP_AUTOCONF		+= --with-openssl=$(CROSS_LIB_DIR)
nmap_prepare_deps	+= $(STATEDIR)/openssl.install
else
NMAP_AUTOCONF		+= --without-openssl
endif

$(STATEDIR)/nmap.prepare: $(nmap_prepare_deps)
	@$(call targetinfo, $@)
	cd $(NMAP_DIR) && \
		$(NMAP_PATH) $(NMAP_ENV) \
		./configure $(NMAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nmap_compile: $(STATEDIR)/nmap.compile

nmap_compile_deps = $(STATEDIR)/nmap.prepare

$(STATEDIR)/nmap.compile: $(nmap_compile_deps) 
	@$(call targetinfo, $@)
#
# dftables is a tool that is run during make in the host system
#
	$(NMAP_PATH) make -C $(NMAP_DIR)/libpcre $(HOSTCC_ENV) CFLAGS='' CXXFLAGS='' dftables
	$(NMAP_PATH) make -C $(NMAP_DIR) nmap
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nmap_install: $(STATEDIR)/nmap.install

$(STATEDIR)/nmap.install: $(STATEDIR)/nmap.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nmap_targetinstall: $(STATEDIR)/nmap.targetinstall

nmap_targetinstall_deps	=  $(STATEDIR)/nmap.install
ifdef PTXCONF_OPENSSL_SHARED
nmap_targetinstall_deps	+= $(STATEDIR)/openssl.targetinstall
endif

$(STATEDIR)/nmap.targetinstall: $(nmap_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,nmap)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(NMAP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(NMAP_DIR)/nmap, /usr/bin/nmap)

ifdef PTXCONF_NMAP_SERVICES
	@$(call install_copy, 0, 0, 0644, $(NMAP_DIR)/nmap-os-fingerprints, /usr/share/nmap/nmap-os-fingerprints, n)
	@$(call install_copy, 0, 0, 0644, $(NMAP_DIR)/nmap-service-probes, /usr/share/nmap/nmap-service-probes, n)
	@$(call install_copy, 0, 0, 0644, $(NMAP_DIR)/nmap-services, /usr/share/nmap/nmap-services, n)
	@$(call install_copy, 0, 0, 0644, $(NMAP_DIR)/nmap-protocols, /usr/share/nmap/nmap-protocols, n)
	@$(call install_copy, 0, 0, 0644, $(NMAP_DIR)/nmap-rpc, /usr/share/nmap/nmap-rpc, n)
endif
	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nmap_clean: 
	rm -rf $(STATEDIR)/nmap.* 
	rm -rf $(IMAGEDIR)/nmap_* 
	rm -rf $(NMAP_DIR)

# vim: syntax=make

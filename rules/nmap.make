# -*-makefile-*-
# $Id: nmap.make,v 1.5 2003/10/28 02:20:33 mkl Exp $
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
ifdef PTXCONF_NMAP
PACKAGES += nmap
endif

#
# Paths and names 
#
NMAP_VERSION		= 3.48
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
	touch $@

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
	touch $@

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
NMAP_AUTOCONF =\
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr \
	--with-pcap=linux 

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
	touch $@

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
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nmap_install: $(STATEDIR)/nmap.install

$(STATEDIR)/nmap.install: $(STATEDIR)/nmap.compile
	@$(call targetinfo, $@)
	touch $@

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
	install -D $(NMAP_DIR)/nmap $(ROOTDIR)/usr/bin/nmap
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/nmap

ifdef PTXCONF_NMAP_SERVICES
	mkdir -p $(ROOTDIR)/usr/share/nmap
	install -m 644 $(NMAP_DIR)/nmap-os-fingerprints $(ROOTDIR)/usr/share/nmap/nmap-os-fingerprints
	install -m 644 $(NMAP_DIR)/nmap-service-probes $(ROOTDIR)/usr/share/nmap/nmap-service-probes
	install -m 644 $(NMAP_DIR)/nmap-services $(ROOTDIR)/usr/share/nmap/nmap-services
	install -m 644 $(NMAP_DIR)/nmap-protocols $(ROOTDIR)/usr/share/nmap/nmap-protocols
	install -m 644 $(NMAP_DIR)/nmap-rpc $(ROOTDIR)/usr/share/nmap/nmap-rpc
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nmap_clean: 
	rm -rf $(STATEDIR)/nmap.* $(NMAP_DIR)

# vim: syntax=make

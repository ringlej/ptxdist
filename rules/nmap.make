# -*-makefile-*-
# $id$
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
NMAP			= nmap-3.46
NMAP_URL		= http://download.insecure.org/nmap/dist/nmap-3.46.tgz
NMAP_SOURCE		= $(SRCDIR)/$(NMAP).tgz
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

NMAP_AUTOCONF	=  --prefix=/usr
NMAP_AUTOCONF	+= --build=$(GNU_HOST)
NMAP_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
NMAP_AUTOCONF	+= --with-pcap=linux 

NMAP_PATH	=  PATH=$(CROSS_PATH)
NMAP_ENV	=  $(CROSS_ENV)
NMAP_ENV   	+= ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR)

nmap_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/nmap.extract \
	$(STATEDIR)/libpcap.install

ifdef PTXCONF_OPENSSL_SHARED
NMAP_AUTOCONF		+= --with-openssl
nmap_prepare_deps	+= $(STATEDIR)/openssl.install
else
NMAP_AUTOCONF		+= --without-openssl
endif

$(STATEDIR)/nmap.prepare: $(nmap_prepare_deps)
	@$(call targetinfo, $@)
	cd $(NMAP_DIR) && \
		$(NMAP_PATH) $(NMAP_ENV) \
		./configure $(NMAP_AUTOCONF)
#
# Kludge:
# touch 3 files to avoid cross build failure
#
	touch $(NMAP_DIR)/libpcre/dftables.o
	sleep 1
	touch $(NMAP_DIR)/libpcre/dftables
	sleep 1
	touch $(NMAP_DIR)/libpcre/chartables.c

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nmap_compile: $(STATEDIR)/nmap.compile

nmap_compile_deps = $(STATEDIR)/nmap.prepare

$(STATEDIR)/nmap.compile: $(nmap_compile_deps) 
	@$(call targetinfo, $@)
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

$(STATEDIR)/nmap.targetinstall: $(STATEDIR)/nmap.install
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)/usr/bin

	install $(NMAP_DIR)/nmap $(ROOTDIR)/usr/bin/nmap
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nmap_clean: 
	rm -rf $(STATEDIR)/nmap.* $(NMAP_DIR)

# vim: syntax=make

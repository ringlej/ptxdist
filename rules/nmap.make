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
# Paths and names
#
NMAP_VERSION		= 4.11
NMAP			= nmap-$(NMAP_VERSION)
NMAP_SUFFIX		= tar.bz2
NMAP_URL		= http://freshmeat.net/redir/nmap/7202/url_bz2/$(NMAP).$(NMAP_SUFFIX)
NMAP_SOURCE		= $(SRCDIR)/$(NMAP).$(NMAP_SUFFIX)
NMAP_DIR		= $(BUILDDIR)/$(NMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nmap_get: $(STATEDIR)/nmap.get

$(STATEDIR)/nmap.get: $(nmap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NMAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NMAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nmap_extract: $(STATEDIR)/nmap.extract

$(STATEDIR)/nmap.extract: $(nmap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NMAP_DIR))
	@$(call extract, NMAP)
	@$(call patchin, NMAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nmap_prepare: $(STATEDIR)/nmap.prepare

NMAP_PATH	=  PATH=$(CROSS_PATH)
NMAP_ENV = \
	$(CROSS_ENV) \
	ac_cv_linux_vers=$(KERNEL_VERSION_MAJOR)

#
# autoconf
#
NMAP_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--with-pcap=linux
#
# FIXME:
#
# nmap works only with openssh shared libs, dunnno why...
#
ifdef PTXCONF_OPENSSL_SHARED
NMAP_AUTOCONF		+= --with-openssl=$(SYSROOT)
else
NMAP_AUTOCONF		+= --without-openssl
endif

$(STATEDIR)/nmap.prepare: $(nmap_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(NMAP_DIR) && \
		$(NMAP_PATH) $(NMAP_ENV) \
		./configure $(NMAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nmap_compile: $(STATEDIR)/nmap.compile

$(STATEDIR)/nmap.compile: $(nmap_compile_deps_default) 
	@$(call targetinfo, $@)
	$(NMAP_PATH) make -C $(NMAP_DIR) nmap
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nmap_install: $(STATEDIR)/nmap.install

$(STATEDIR)/nmap.install: $(nmap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nmap_targetinstall: $(STATEDIR)/nmap.targetinstall

$(STATEDIR)/nmap.targetinstall: $(nmap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, nmap)
	@$(call install_fixup, nmap,PACKAGE,nmap)
	@$(call install_fixup, nmap,PRIORITY,optional)
	@$(call install_fixup, nmap,VERSION,$(NMAP_VERSION))
	@$(call install_fixup, nmap,SECTION,base)
	@$(call install_fixup, nmap,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, nmap,DEPENDS,)
	@$(call install_fixup, nmap,DESCRIPTION,missing)

	@$(call install_copy, nmap, 0, 0, 0755, $(NMAP_DIR)/nmap, /usr/bin/nmap)

ifdef PTXCONF_NMAP_SERVICES
	@$(call install_copy, nmap, 0, 0, 0644, $(NMAP_DIR)/nmap-os-fingerprints, /usr/share/nmap/nmap-os-fingerprints, n)
	@$(call install_copy, nmap, 0, 0, 0644, $(NMAP_DIR)/nmap-service-probes, /usr/share/nmap/nmap-service-probes, n)
	@$(call install_copy, nmap, 0, 0, 0644, $(NMAP_DIR)/nmap-services, /usr/share/nmap/nmap-services, n)
	@$(call install_copy, nmap, 0, 0, 0644, $(NMAP_DIR)/nmap-protocols, /usr/share/nmap/nmap-protocols, n)
	@$(call install_copy, nmap, 0, 0, 0644, $(NMAP_DIR)/nmap-rpc, /usr/share/nmap/nmap-rpc, n)
endif
	@$(call install_finish, nmap)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nmap_clean: 
	rm -rf $(STATEDIR)/nmap.* 
	rm -rf $(IMAGEDIR)/nmap_* 
	rm -rf $(NMAP_DIR)

# vim: syntax=make

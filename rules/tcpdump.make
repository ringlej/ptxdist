# -*-makefile-*-
# $Id: tcpdump.make,v 1.2 2004/03/31 16:27:52 mkl Exp $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_TCPDUMP
PACKAGES += tcpdump
endif

#
# Paths and names
#
TCPDUMP_VERSION		= 3.8.1
TCPDUMP			= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX		= tar.gz
TCPDUMP_URL		= http://www.tcpdump.org/release/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE		= $(SRCDIR)/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_DIR		= $(BUILDDIR)/$(TCPDUMP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpdump_get: $(STATEDIR)/tcpdump.get

tcpdump_get_deps = $(TCPDUMP_SOURCE)

$(STATEDIR)/tcpdump.get: $(tcpdump_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, PTXCONF_TCPDUMP)
	touch $@

$(TCPDUMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TCPDUMP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpdump_extract: $(STATEDIR)/tcpdump.extract

tcpdump_extract_deps = $(STATEDIR)/tcpdump.get

$(STATEDIR)/tcpdump.extract: $(tcpdump_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPDUMP_DIR))
	@$(call extract, $(TCPDUMP_SOURCE))
	@$(call patchin, $(PTXCONF_TCPDUMP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpdump_prepare: $(STATEDIR)/tcpdump.prepare

#
# dependencies
#
tcpdump_prepare_deps = \
	$(STATEDIR)/tcpdump.extract \
	$(STATEDIR)/virtual-xchain.install

TCPDUMP_PATH	=  PATH=$(CROSS_PATH)
TCPDUMP_ENV 	=  $(CROSS_ENV)
#TCPDUMP_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#TCPDUMP_ENV	+=

#
# autoconf
#
TCPDUMP_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/tcpdump.prepare: $(tcpdump_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TCPDUMP_DIR)/config.cache)
	cd $(TCPDUMP_DIR) && \
		$(TCPDUMP_PATH) $(TCPDUMP_ENV) \
		./configure $(TCPDUMP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpdump_compile: $(STATEDIR)/tcpdump.compile

tcpdump_compile_deps = $(STATEDIR)/tcpdump.prepare

$(STATEDIR)/tcpdump.compile: $(tcpdump_compile_deps)
	@$(call targetinfo, $@)
	cd $(TCPDUMP_DIR) && $(TCPDUMP_ENV) $(TCPDUMP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpdump_install: $(STATEDIR)/tcpdump.install

$(STATEDIR)/tcpdump.install: $(STATEDIR)/tcpdump.compile
	@$(call targetinfo, $@)
	cd $(TCPDUMP_DIR) && $(TCPDUMP_ENV) $(TCPDUMP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpdump_targetinstall: $(STATEDIR)/tcpdump.targetinstall

tcpdump_targetinstall_deps = $(STATEDIR)/tcpdump.compile

$(STATEDIR)/tcpdump.targetinstall: $(tcpdump_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/sbin
	cp $(TCPDUMP_DIR)/tcpdump $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/tcpdump
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpdump_clean:
	rm -rf $(STATEDIR)/tcpdump.*
	rm -rf $(TCPDUMP_DIR)

# vim: syntax=make

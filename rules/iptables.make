# -*-makefile-*-
# $Id$
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
ifdef PTXCONF_IPTABLES
PACKAGES += iptables
endif

#
# Paths and names
#
IPTABLES_VERSION	= 1.2.11
IPTABLES		= iptables-$(IPTABLES_VERSION)
IPTABLES_SUFFIX		= tar.bz2
IPTABLES_URL		= http://www.netfilter.org/files/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_SOURCE		= $(SRCDIR)/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_DIR		= $(BUILDDIR)/$(IPTABLES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

iptables_get: $(STATEDIR)/iptables.get

iptables_get_deps = $(IPTABLES_SOURCE)

$(STATEDIR)/iptables.get: $(iptables_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(IPTABLES))
	touch $@

$(IPTABLES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(IPTABLES_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

iptables_extract: $(STATEDIR)/iptables.extract

iptables_extract_deps = $(STATEDIR)/iptables.get

$(STATEDIR)/iptables.extract: $(iptables_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(IPTABLES_DIR))
	@$(call extract, $(IPTABLES_SOURCE))
	@$(call patchin, $(IPTABLES))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

iptables_prepare: $(STATEDIR)/iptables.prepare

#
# dependencies
#
iptables_prepare_deps = \
	$(STATEDIR)/iptables.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.prepare

IPTABLES_PATH	=  PATH=$(CROSS_PATH)
IPTABLES_ENV 	=  $(CROSS_ENV)
#IPTABLES_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#IPTABLES_ENV	+=


$(STATEDIR)/iptables.prepare: $(iptables_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(IPTABLES_DIR)/config.cache)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

iptables_compile: $(STATEDIR)/iptables.compile

iptables_compile_deps = $(STATEDIR)/iptables.prepare

$(STATEDIR)/iptables.compile: $(iptables_compile_deps)
	@$(call targetinfo, $@)
	cd $(IPTABLES_DIR) && $(IPTABLES_ENV) $(IPTABLES_PATH) make KERNEL_DIR=$(KERNEL_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

iptables_install: $(STATEDIR)/iptables.install

$(STATEDIR)/iptables.install: $(STATEDIR)/iptables.compile
	@$(call targetinfo, $@)
	cd $(IPTABLES_DIR) && $(IPTABLES_ENV) $(IPTABLES_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

iptables_targetinstall: $(STATEDIR)/iptables.targetinstall

iptables_targetinstall_deps = $(STATEDIR)/iptables.compile

$(STATEDIR)/iptables.targetinstall: $(iptables_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef $(IPTABLES_INSTALL_IP6TABLES)
	install -D $(IPTABLES_DIR)/ip6tables $(ROOTDIR)/sbin/ip6tables
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/sbin/ip6tables
endif
ifdef $(IPTABLES_INSTALL_IPTABLES)
	install -D $(IPTABLES_DIR)/iptables $(ROOTDIR)/sbin/iptables
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/sbin/iptables
endif
ifdef $(IPTABLES_INSTALL_IPTABLES_RESTORE)
	install -D $(IPTABLES_DIR)/iptables-restore $(ROOTDIR)/sbin/iptables-restore
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/sbin/iptables-restore
endif
ifdef $(IPTABLES_INSTALL_IPTABLES_SAVE)
	install -D $(IPTABLES_DIR)/iptables $(ROOTDIR)/sbin/iptables-save
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/sbin/iptables
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iptables_clean:
	rm -rf $(STATEDIR)/iptables.*
	rm -rf $(IPTABLES_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003,2004 by leifj@it.su.se
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_OPENAFS
PACKAGES += openafs
endif

#
# Paths and names
#
OPENAFS_VERSION		= 1.2.11
OPENAFS			= openafs-$(OPENAFS_VERSION)
OPENAFS_SUFFIX		= -src.tar.gz
OPENAFS_URL		= http://www.openafs.org/dl/openafs/1.2.11/$(OPENAFS)$(OPENAFS_SUFFIX)
OPENAFS_SOURCE		= $(SRCDIR)/$(OPENAFS)$(OPENAFS_SUFFIX)
OPENAFS_DIR		= $(BUILDDIR)/$(OPENAFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openafs_get: $(STATEDIR)/openafs.get

openafs_get_deps = $(OPENAFS_SOURCE)

$(STATEDIR)/openafs.get: $(openafs_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(OPENAFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPENAFS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openafs_extract: $(STATEDIR)/openafs.extract

openafs_extract_deps = $(STATEDIR)/openafs.get

$(STATEDIR)/openafs.extract: $(openafs_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENAFS_DIR))
	@$(call extract, $(OPENAFS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openafs_prepare: $(STATEDIR)/openafs.prepare

#
# dependencies
#
openafs_prepare_deps = 				\
	kernel_targetinstall 			\
	$(STATEDIR)/openafs.extract 		\
	openafs-openafs-ptx-build_install 	\
	$(STATEDIR)/virtual-xchain.install

OPENAFS_PATH	=  PATH=$(CROSS_PATH)
OPENAFS_ENV 	=  $(CROSS_ENV)
#OPENAFS_ENV	+=

#
# autoconf
#
OPENAFS_AUTOCONF =  $(CROSS_AUTOCONF)
OPENAFS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
OPENAFS_AUTOCONF += -enable-tansac-paths
OPENAFS_AUTOCONF += --with-afs-sysname=$(OPENAFS_SYS)
OPENAFS_AUTOCONF += --with-linux-kernel-headers=$(KERNEL_DIR)

OPENAFS_SYS=i386_linux24

$(STATEDIR)/openafs.prepare: $(openafs_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENAFS_DIR)/config.cache)
	cd $(OPENAFS_DIR) && \
		$(OPENAFS_PATH) $(OPENAFS_ENV) \
		./configure $(OPENAFS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openafs_compile: $(STATEDIR)/openafs.compile

openafs_compile_deps = $(STATEDIR)/openafs.prepare

$(STATEDIR)/openafs.compile: $(openafs_compile_deps)
	@$(call targetinfo, $@)
	cd $(OPENAFS_DIR) && $(OPENAFS_PATH) make
	cd $(OPENAFS_DIR) && $(OPENAFS_PATH) make dest
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openafs_install: $(STATEDIR)/openafs.install

$(STATEDIR)/openafs.install: $(STATEDIR)/openafs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openafs_targetinstall: $(STATEDIR)/openafs.targetinstall

openafs_targetinstall_deps = $(STATEDIR)/openafs.compile

$(STATEDIR)/openafs.targetinstall: $(openafs_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr
	cp -a $(OPENAFS_DIR)/$(OPENAFS_SYS)/dest/root.client/usr/vice $(ROOTDIR)/usr
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openafs_clean:
	rm -rf $(STATEDIR)/openafs.*
	rm -rf $(OPENAFS_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

#
# Paths and names 
#
HOST_E2FSPROGS_VERSION		= 1.35
HOST_E2FSPROGS			= e2fsprogs-$(HOST_E2FSPROGS_VERSION)
HOST_E2FSPROGS_SUFFIX		= tar.gz
HOST_E2FSPROGS_URL		= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(HOST_E2FSPROGS).$(HOST_E2FSPROGS_SUFFIX)
HOST_E2FSPROGS_SOURCE_DIR	= $(SRCDIR)/host/
HOST_E2FSPROGS_SOURCE		= $(HOST_E2FSPROGS_SOURCE_DIR)/$(HOST_E2FSPROGS).$(HOST_E2FSPROGS_SUFFIX)
HOST_E2FSPROGS_DIR		= $(BUILDDIR)/host/$(HOST_E2FSPROGS)
HOST_E2FSPROGS_BUILD_DIR	= $(BUILDDIR)/host/$(HOST_E2FSPROGS)-build

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-e2fsprogs_get: $(STATEDIR)/host-e2fsprogs.get

$(STATEDIR)/host-e2fsprogs.get: $(HOST_E2FSPROGS_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_E2FSPROGS))
	@$(call touch, $@)

$(HOST_E2FSPROGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_E2FSPROGS_URL), $(HOST_E2FSPROGS_SOURCE_DIR) )

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-e2fsprogs_extract: $(STATEDIR)/host-e2fsprogs.extract

$(STATEDIR)/host-e2fsprogs.extract: $(STATEDIR)/host-e2fsprogs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_E2FSPROGS_DIR))
	@$(call extract, $(HOST_E2FSPROGS_SOURCE) , $(BUILDDIR)/host/ )
	@$(call patchin, $(HOST_E2FSPROGS), $(HOST_E2FSPROGS_DIR) )
	chmod +w $(HOST_E2FSPROGS_DIR)/po/*.po
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-e2fsprogs_prepare: $(STATEDIR)/host-e2fsprogs.prepare

# FIXME - doesn't seem to be a host...
HOST_E2FSPROGS_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
HOST_E2FSPROGS_AUTOCONF	+= --enable-fsck
HOST_E2FSPROGS_AUTOCONF	+= --with-cc=$(COMPILER_PREFIX)gcc
HOST_E2FSPROGS_AUTOCONF	+= --with-linker=$(COMPILER_PREFIX)ld
HOST_E2FSPROGS_PATH	=  PATH=$(CROSS_PATH)
HOST_E2FSPROGS_ENV	=  $(CROSS_ENV) 
HOST_E2FSPROGS_ENV	+= BUILD_CC=$(HOSTCC)

host-e2fsprogs_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/host-e2fsprogs.extract

$(STATEDIR)/host-e2fsprogs.prepare: $(host-e2fsprogs_prepare_deps_default)
	@$(call targetinfo, $@)
	mkdir -p $(HOST_E2FSPROGS_BUILD_DIR) && \
	cd $(HOST_E2FSPROGS_BUILD_DIR) && \
		$(HOST_E2FSPROGS_PATH) $(HOST_E2FSPROGS_ENV) \
		$(HOST_E2FSPROGS_DIR)/configure $(HOST_E2FSPROGS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-e2fsprogs_compile: $(STATEDIR)/host-e2fsprogs.compile

host-e2fsprogs_compile_deps = $(STATEDIR)/host-e2fsprogs.prepare

$(STATEDIR)/host-e2fsprogs.compile: $(host-e2fsprogs_compile_deps_default) 
	@$(call targetinfo, $@)
#
# in the util dir are tools that are compiled for the host system
# these tools are needed later in the compile progress
#
# it's not good to pass target CFLAGS to the host compiler :)
# so override these
#
	$(HOST_E2FSPROGS_PATH) make -C $(HOST_E2FSPROGS_BUILD_DIR)/util
	$(HOST_E2FSPROGS_PATH) make -C $(HOST_E2FSPROGS_BUILD_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-e2fsprogs_install: $(STATEDIR)/host-e2fsprogs.install

$(STATEDIR)/host-e2fsprogs.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Install
# ----------------------------------------------------------------------------

host-e2fsprogs_targetinstall: $(STATEDIR)/host-e2fsprogs.targetinstall

$(STATEDIR)/host-e2fsprogs.targetinstall: $(STATEDIR)/host-e2fsprogs.compile
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/sbin
ifdef PTXCONF_HOST_E2FSPROGS_TUNE2FS
	install -D $(HOST_E2FSPROGS_BUILD_DIR)/misc/tune2fs $(PTXCONF_PREFIX)/sbin/tune2fs
endif
ifdef PTXCONF_HOST_E2FSPROGS_RESIZE2FS
	install -D $(HOST_E2FSPROGS_BUILD_DIR)/resize/resize2fs $(PTXCONF_PREFIX)/sbin/resize2fs
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-e2fsprogs_clean: 
	rm -rf $(STATEDIR)/host-e2fsprogs.* $(HOST_E2FSPROGS_DIR) $(HOST_E2FSPROGS_BUILD_DIR)

# vim: syntax=make

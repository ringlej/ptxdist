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
ifdef PTXCONF_HOSTTOOL_E2FSPROGS
HOSTTOOLS += hosttool-e2fsprogs
endif

#
# Paths and names 
#
HOSTTOOL_E2FSPROGS_VERSION		= 1.35
HOSTTOOL_E2FSPROGS			= e2fsprogs-$(HOSTTOOL_E2FSPROGS_VERSION)
HOSTTOOL_E2FSPROGS_SUFFIX		= tar.gz
HOSTTOOL_E2FSPROGS_URL			= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(HOSTTOOL_E2FSPROGS).$(HOSTTOOL_E2FSPROGS_SUFFIX)
HOSTTOOL_E2FSPROGS_SOURCE_DIR		= $(SRCDIR)/hosttool/
HOSTTOOL_E2FSPROGS_SOURCE		= $(HOSTTOOL_E2FSPROGS_SOURCE_DIR)/$(HOSTTOOL_E2FSPROGS).$(HOSTTOOL_E2FSPROGS_SUFFIX)
HOSTTOOL_E2FSPROGS_DIR			= $(BUILDDIR)/hosttool/$(HOSTTOOL_E2FSPROGS)
HOSTTOOL_E2FSPROGS_BUILD_DIR		= $(BUILDDIR)/hosttool/$(HOSTTOOL_E2FSPROGS)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_get: $(STATEDIR)/hosttool-e2fsprogs.get

$(STATEDIR)/hosttool-e2fsprogs.get: $(HOSTTOOL_E2FSPROGS_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_E2FSPROGS))
	touch $@

$(HOSTTOOL_E2FSPROGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_E2FSPROGS_URL), $(HOSTTOOL_E2FSPROGS_SOURCE_DIR) )

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_extract: $(STATEDIR)/hosttool-e2fsprogs.extract

$(STATEDIR)/hosttool-e2fsprogs.extract: $(STATEDIR)/hosttool-e2fsprogs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_E2FSPROGS_DIR))
	@$(call extract, $(HOSTTOOL_E2FSPROGS_SOURCE) , $(BUILDDIR)/hosttool/ )
	@$(call patchin, $(HOSTTOOL_E2FSPROGS), $(HOSTTOOL_E2FSPROGS_DIR) )
	chmod +w $(HOSTTOOL_E2FSPROGS_DIR)/po/*.po
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_prepare: $(STATEDIR)/hosttool-e2fsprogs.prepare

# FIXME - doesn't seem to be a hosttool...
HOSTTOOL_E2FSPROGS_AUTOCONF	=  $(CROSS_AUTOCONF)
HOSTTOOL_E2FSPROGS_AUTOCONF	+= --prefix=/usr
HOSTTOOL_E2FSPROGS_AUTOCONF	+= --enable-fsck
HOSTTOOL_E2FSPROGS_AUTOCONF	+= --with-cc=$(COMPILER_PREFIX)gcc
HOSTTOOL_E2FSPROGS_AUTOCONF	+= --with-linker=$(COMPILER_PREFIX)ld
HOSTTOOL_E2FSPROGS_PATH		=  PATH=$(CROSS_PATH)
HOSTTOOL_E2FSPROGS_ENV		=  $(CROSS_ENV) 
HOSTTOOL_E2FSPROGS_ENV		+= BUILD_CC=$(HOSTCC)

hosttool-e2fsprogs_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/hosttool-e2fsprogs.extract

$(STATEDIR)/hosttool-e2fsprogs.prepare: $(hosttool-e2fsprogs_prepare_deps)
	@$(call targetinfo, $@)
	mkdir -p $(HOSTTOOL_E2FSPROGS_BUILD_DIR) && \
	cd $(HOSTTOOL_E2FSPROGS_BUILD_DIR) && \
		$(HOSTTOOL_E2FSPROGS_PATH) $(HOSTTOOL_E2FSPROGS_ENV) \
		$(HOSTTOOL_E2FSPROGS_DIR)/configure $(HOSTTOOL_E2FSPROGS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_compile: $(STATEDIR)/hosttool-e2fsprogs.compile

hosttool-e2fsprogs_compile_deps = $(STATEDIR)/hosttool-e2fsprogs.prepare

$(STATEDIR)/hosttool-e2fsprogs.compile: $(hosttool-e2fsprogs_compile_deps) 
	@$(call targetinfo, $@)
#
# in the util dir are tools that are compiled for the host system
# these tools are needed later in the compile progress
#
# it's not good to pass target CFLAGS to the host compiler :)
# so override these
#
	$(HOSTTOOL_E2FSPROGS_PATH) make -C $(HOSTTOOL_E2FSPROGS_BUILD_DIR)/util
	$(HOSTTOOL_E2FSPROGS_PATH) make -C $(HOSTTOOL_E2FSPROGS_BUILD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_install: $(STATEDIR)/hosttool-e2fsprogs.install

$(STATEDIR)/hosttool-e2fsprogs.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Hosttool Install
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_targetinstall: $(STATEDIR)/hosttool-e2fsprogs.targetinstall

$(STATEDIR)/hosttool-e2fsprogs.targetinstall: $(STATEDIR)/hosttool-e2fsprogs.compile
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/sbin
ifdef PTXCONF_HOSTTOOL_E2FSPROGS_TUNE2FS
	install -D $(HOSTTOOL_E2FSPROGS_BUILD_DIR)/misc/tune2fs $(PTXCONF_PREFIX)/sbin/tune2fs
endif
ifdef PTXCONF_HOSTTOOL_E2FSPROGS_RESIZE2FS
	install -D $(HOSTTOOL_E2FSPROGS_BUILD_DIR)/resize/resize2fs $(PTXCONF_PREFIX)/sbin/resize2fs
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_clean: 
	rm -rf $(STATEDIR)/hosttool-e2fsprogs.* $(HOSTTOOL_E2FSPROGS_DIR) $(HOSTTOOL_E2FSPROGS_BUILD_DIR)

# vim: syntax=make

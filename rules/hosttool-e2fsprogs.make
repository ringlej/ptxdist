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
ifdef PTXCONF_HOSTTOOLS_E2FSPROGS
HOSTTOOLS += hosttool-e2fsprogs
endif

#
# Paths and names 
#
HOSTTOOLS_E2FSPROGS_VERSION		= 1.35
HOSTTOOLS_E2FSPROGS			= e2fsprogs-$(HOSTTOOLS_E2FSPROGS_VERSION)
HOSTTOOLS_E2FSPROGS_SUFFIX		= tar.gz
HOSTTOOLS_E2FSPROGS_URL			= $(PTXCONF_SFMIRROR)/e2fsprogs/$(HOSTTOOLS_E2FSPROGS).$(HOSTTOOLS_E2FSPROGS_SUFFIX)
HOSTTOOLS_E2FSPROGS_SOURCE_DIR		= $(SRCDIR)/hosttool/
HOSTTOOLS_E2FSPROGS_SOURCE		= $(HOSTTOOLS_E2FSPROGS_SOURCE_DIR)/$(HOSTTOOLS_E2FSPROGS).$(HOSTTOOLS_E2FSPROGS_SUFFIX)
HOSTTOOLS_E2FSPROGS_DIR			= $(BUILDDIR)/hosttool/$(HOSTTOOLS_E2FSPROGS)
HOSTTOOLS_E2FSPROGS_BUILD_DIR		= $(BUILDDIR)/hosttool/$(HOSTTOOLS_E2FSPROGS)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_get: $(STATEDIR)/hosttool-e2fsprogs.get

$(STATEDIR)/hosttool-e2fsprogs.get: $(HOSTTOOLS_E2FSPROGS_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOLS_E2FSPROGS))
	touch $@

$(HOSTTOOLS_E2FSPROGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOLS_E2FSPROGS_URL), $(HOSTTOOLS_E2FSPROGS_SOURCE_DIR) )

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_extract: $(STATEDIR)/hosttool-e2fsprogs.extract

$(STATEDIR)/hosttool-e2fsprogs.extract: $(STATEDIR)/hosttool-e2fsprogs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_E2FSPROGS_DIR))
	@$(call extract, $(HOSTTOOLS_E2FSPROGS_SOURCE) , $(BUILDDIR)/hosttool/ )
	@$(call patchin, $(HOSTTOOLS_E2FSPROGS), $(HOSTTOOLS_E2FSPROGS_DIR) )
	chmod +w $(HOSTTOOLS_E2FSPROGS_DIR)/po/*.po
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_prepare: $(STATEDIR)/hosttool-e2fsprogs.prepare

# FIXME - doesn't seem to be a hosttool...
HOSTTOOLS_E2FSPROGS_AUTOCONF	=  $(CROSS_AUTOCONF)
HOSTTOOLS_E2FSPROGS_AUTOCONF	+= --prefix=/usr
HOSTTOOLS_E2FSPROGS_AUTOCONF	+= --enable-fsck
HOSTTOOLS_E2FSPROGS_AUTOCONF	+= --with-cc=$(PTXCONF_GNU_TARGET)-gcc
HOSTTOOLS_E2FSPROGS_AUTOCONF	+= --with-linker=$(PTXCONF_GNU_TARGET)-ld
HOSTTOOLS_E2FSPROGS_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOLS_E2FSPROGS_ENV		=  $(CROSS_ENV) 
HOSTTOOLS_E2FSPROGS_ENV		+= BUILD_CC=$(HOSTCC)

hosttool-e2fsprogs_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/hosttool-e2fsprogs.extract

$(STATEDIR)/hosttool-e2fsprogs.prepare: $(hosttool-e2fsprogs_prepare_deps)
	@$(call targetinfo, $@)
	mkdir -p $(HOSTTOOLS_E2FSPROGS_BUILD_DIR) && \
	cd $(HOSTTOOLS_E2FSPROGS_BUILD_DIR) && \
		$(HOSTTOOLS_E2FSPROGS_PATH) $(HOSTTOOLS_E2FSPROGS_ENV) \
		$(HOSTTOOLS_E2FSPROGS_DIR)/configure $(HOSTTOOLS_E2FSPROGS_AUTOCONF)
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
	$(HOSTTOOLS_E2FSPROGS_PATH) make -C $(HOSTTOOLS_E2FSPROGS_BUILD_DIR)/util
	$(HOSTTOOLS_E2FSPROGS_PATH) make -C $(HOSTTOOLS_E2FSPROGS_BUILD_DIR)
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
ifdef PTXCONF_HOSTTOOLS_E2FSPROGS_TUNE2FS
	install -D $(HOSTTOOLS_E2FSPROGS_BUILD_DIR)/misc/tune2fs $(PTXCONF_PREFIX)/sbin/tune2fs
endif
ifdef PTXCONF_HOSTTOOLS_E2FSPROGS_RESIZE2FS
	install -D $(HOSTTOOLS_E2FSPROGS_BUILD_DIR)/resize/resize2fs $(PTXCONF_PREFIX)/sbin/resize2fs
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-e2fsprogs_clean: 
	rm -rf $(STATEDIR)/hosttool-e2fsprogs.* $(HOSTTOOLS_E2FSPROGS_DIR) $(HOSTTOOLS_E2FSPROGS_BUILD_DIR)

# vim: syntax=make

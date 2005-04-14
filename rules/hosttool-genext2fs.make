# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_HOSTTOOLS_GENEXT2FS
HOSTTOOLS += hosttool-genext2fs
endif

#
# Paths and names 
#
HOSTTOOLS_GENEXT2FS_VERSION	= 1.3.orig
HOSTTOOLS_GENEXT2FS		= genext2fs-$(HOSTTOOLS_GENEXT2FS_VERSION)
HOSTTOOLS_GENEXT2FS_TARBALL	= genext2fs_$(HOSTTOOLS_GENEXT2FS_VERSION).$(HOSTTOOLS_GENEXT2FS_SUFFIX)
HOSTTOOLS_GENEXT2FS_SUFFIX	= tar.gz
HOSTTOOLS_GENEXT2FS_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/g/genext2fs/$(HOSTTOOLS_GENEXT2FS_TARBALL)
HOSTTOOLS_GENEXT2FS_SOURCE	= $(SRCDIR)/$(HOSTTOOLS_GENEXT2FS_TARBALL)
HOSTTOOLS_GENEXT2FS_DIR		= $(HOSTTOOLS_BUILDDIR)/$(HOSTTOOLS_GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-genext2fs_get: $(STATEDIR)/hosttool-genext2fs.get

hosttool-genext2fs_get_deps  =  $(HOSTTOOLS_GENEXT2FS_SOURCE)

$(STATEDIR)/hosttool-genext2fs.get: $(hosttool-genext2fs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOLS_GENEXT2FS))
	touch $@

$(HOSTTOOLS_GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOLS_GENEXT2FS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-genext2fs_extract: $(STATEDIR)/hosttool-genext2fs.extract

$(STATEDIR)/hosttool-genext2fs.extract: $(STATEDIR)/hosttool-genext2fs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_GENEXT2FS_DIR))
	@$(call extract, $(HOSTTOOLS_GENEXT2FS_SOURCE),$(HOSTTOOLS_BUILDDIR))
	@$(call patchin, $(HOSTTOOLS_GENEXT2FS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-genext2fs_prepare: $(STATEDIR)/hosttool-genext2fs.prepare

HOSTTOOLS_GENEXT2FS_ENV		=  $(HOSTCC_ENV)

hosttool-genext2fs_prepare_deps = \
	$(STATEDIR)/hosttool-genext2fs.extract

$(STATEDIR)/hosttool-genext2fs.prepare: $(hosttool-genext2fs_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-genext2fs_compile: $(STATEDIR)/hosttool-genext2fs.compile

hosttool-genext2fs_compile_deps = $(STATEDIR)/hosttool-genext2fs.prepare

$(STATEDIR)/hosttool-genext2fs.compile: $(hosttool-genext2fs_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_GENEXT2FS_DIR) && \
		$(HOSTCC) genext2fs.c -o genext2fs
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-genext2fs_install: $(STATEDIR)/hosttool-genext2fs.install

hosttool-genext2fs_install_deps = $(STATEDIR)/hosttool-genext2fs.compile

$(STATEDIR)/hosttool-genext2fs.install: $(hosttool-genext2fs_install_deps)
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/bin/
	install -d $(PTXCONF_PREFIX)/man/man8/

	install -m 755 $(HOSTTOOLS_GENEXT2FS_DIR)/genext2fs $(PTXCONF_PREFIX)/bin/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-genext2fs_targetinstall: $(STATEDIR)/hosttool-genext2fs.targetinstall

$(STATEDIR)/hosttool-genext2fs.targetinstall: $(STATEDIR)/hosttool-genext2fs.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-genext2fs_clean: 
	rm -rf $(STATEDIR)/hosttool-genext2fs.* $(HOSTTOOLS_GENEXT2FS_DIR)

# vim: syntax=make

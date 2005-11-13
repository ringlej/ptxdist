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
HOST_PACKAGES-$(PTXCONF_HOSTTOOL_GENEXT2FS) += hosttool-genext2fs

#
# Paths and names 
#
HOSTTOOL_GENEXT2FS_VERSION	= 1.3.orig
HOSTTOOL_GENEXT2FS		= genext2fs-$(HOSTTOOL_GENEXT2FS_VERSION)
HOSTTOOL_GENEXT2FS_TARBALL	= genext2fs_$(HOSTTOOL_GENEXT2FS_VERSION).$(HOSTTOOL_GENEXT2FS_SUFFIX)
HOSTTOOL_GENEXT2FS_SUFFIX	= tar.gz
HOSTTOOL_GENEXT2FS_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/g/genext2fs/$(HOSTTOOL_GENEXT2FS_TARBALL)
HOSTTOOL_GENEXT2FS_SOURCE	= $(SRCDIR)/$(HOSTTOOL_GENEXT2FS_TARBALL)
HOSTTOOL_GENEXT2FS_DIR		= $(HOST_BUILDDIR)/$(HOSTTOOL_GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-genext2fs_get: $(STATEDIR)/hosttool-genext2fs.get

hosttool-genext2fs_get_deps  =  $(HOSTTOOL_GENEXT2FS_SOURCE)

$(STATEDIR)/hosttool-genext2fs.get: $(hosttool-genext2fs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_GENEXT2FS))
	$(call touch, $@)

$(HOSTTOOL_GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_GENEXT2FS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-genext2fs_extract: $(STATEDIR)/hosttool-genext2fs.extract

$(STATEDIR)/hosttool-genext2fs.extract: $(STATEDIR)/hosttool-genext2fs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_GENEXT2FS_DIR))
	@$(call extract, $(HOSTTOOL_GENEXT2FS_SOURCE),$(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL_GENEXT2FS),$(HOSTTOOL_GENEXT2FS_DIR))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-genext2fs_prepare: $(STATEDIR)/hosttool-genext2fs.prepare

HOSTTOOL_GENEXT2FS_ENV		=  $(HOSTCC_ENV)

hosttool-genext2fs_prepare_deps = \
	$(STATEDIR)/hosttool-genext2fs.extract

$(STATEDIR)/hosttool-genext2fs.prepare: $(hosttool-genext2fs_prepare_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-genext2fs_compile: $(STATEDIR)/hosttool-genext2fs.compile

hosttool-genext2fs_compile_deps = $(STATEDIR)/hosttool-genext2fs.prepare

$(STATEDIR)/hosttool-genext2fs.compile: $(hosttool-genext2fs_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_GENEXT2FS_DIR) && make $(HOSTTOOL_GENEXT2FS_ENV)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-genext2fs_install: $(STATEDIR)/hosttool-genext2fs.install

hosttool-genext2fs_install_deps = $(STATEDIR)/hosttool-genext2fs.compile

$(STATEDIR)/hosttool-genext2fs.install: $(hosttool-genext2fs_install_deps)
	@$(call targetinfo, $@)
	install -d $(PTXCONF_HOST_PREFIX)/bin/
	install -d $(PTXCONF_HOST_PREFIX)/man/man8/

	install -m 755 $(HOSTTOOL_GENEXT2FS_DIR)/genext2fs $(PTXCONF_HOST_PREFIX)/bin/
	install -m 644 $(HOSTTOOL_GENEXT2FS_DIR)/genext2fs.8 $(PTXCONF_HOST_PREFIX)/man/man8/
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-genext2fs_targetinstall: $(STATEDIR)/hosttool-genext2fs.targetinstall

$(STATEDIR)/hosttool-genext2fs.targetinstall: $(STATEDIR)/hosttool-genext2fs.install
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-genext2fs_clean: 
	rm -rf $(STATEDIR)/hosttool-genext2fs.* $(HOSTTOOL_GENEXT2FS_DIR)

# vim: syntax=make

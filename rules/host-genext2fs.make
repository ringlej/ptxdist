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
HOST_PACKAGES-$(PTXCONF_HOST_GENEXT2FS) += host-genext2fs

#
# Paths and names 
#
HOST_GENEXT2FS_VERSION	= 1.3.orig
HOST_GENEXT2FS		= genext2fs-$(HOST_GENEXT2FS_VERSION)
HOST_GENEXT2FS_TARBALL	= genext2fs_$(HOST_GENEXT2FS_VERSION).$(HOST_GENEXT2FS_SUFFIX)
HOST_GENEXT2FS_SUFFIX	= tar.gz
HOST_GENEXT2FS_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/g/genext2fs/$(HOST_GENEXT2FS_TARBALL)
HOST_GENEXT2FS_SOURCE	= $(SRCDIR)/$(HOST_GENEXT2FS_TARBALL)
HOST_GENEXT2FS_DIR		= $(HOST_BUILDDIR)/$(HOST_GENEXT2FS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-genext2fs_get: $(STATEDIR)/host-genext2fs.get

host-genext2fs_get_deps  =  $(HOST_GENEXT2FS_SOURCE)

$(STATEDIR)/host-genext2fs.get: $(host-genext2fs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_GENEXT2FS))
	@$(call touch, $@)

$(HOST_GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_GENEXT2FS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-genext2fs_extract: $(STATEDIR)/host-genext2fs.extract

$(STATEDIR)/host-genext2fs.extract: $(STATEDIR)/host-genext2fs.get
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GENEXT2FS_DIR))
	@$(call extract, $(HOST_GENEXT2FS_SOURCE),$(HOST_BUILDDIR))
	@$(call patchin, $(HOST_GENEXT2FS),$(HOST_GENEXT2FS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-genext2fs_prepare: $(STATEDIR)/host-genext2fs.prepare

HOST_GENEXT2FS_ENV		=  $(HOSTCC_ENV)

host-genext2fs_prepare_deps = \
	$(STATEDIR)/host-genext2fs.extract

$(STATEDIR)/host-genext2fs.prepare: $(host-genext2fs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-genext2fs_compile: $(STATEDIR)/host-genext2fs.compile

host-genext2fs_compile_deps = $(STATEDIR)/host-genext2fs.prepare

$(STATEDIR)/host-genext2fs.compile: $(host-genext2fs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GENEXT2FS_DIR) && make $(HOST_GENEXT2FS_ENV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-genext2fs_install: $(STATEDIR)/host-genext2fs.install

host-genext2fs_install_deps = $(STATEDIR)/host-genext2fs.compile

$(STATEDIR)/host-genext2fs.install: $(host-genext2fs_install_deps_default)
	@$(call targetinfo, $@)
	install -d $(PTXCONF_HOST_PREFIX)/usr/bin/
	install -d $(PTXCONF_HOST_PREFIX)/usr/man/man8/
	# FIXME: correct path?
	install -m 755 $(HOST_GENEXT2FS_DIR)/genext2fs $(PTXCONF_HOST_PREFIX)/usr/bin/
	install -m 644 $(HOST_GENEXT2FS_DIR)/genext2fs.8 $(PTXCONF_HOST_PREFIX)/usr/man/man8/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-genext2fs_targetinstall: $(STATEDIR)/host-genext2fs.targetinstall

$(STATEDIR)/host-genext2fs.targetinstall: $(STATEDIR)/host-genext2fs.install
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-genext2fs_clean: 
	rm -rf $(STATEDIR)/host-genext2fs.* $(HOST_GENEXT2FS_DIR)

# vim: syntax=make

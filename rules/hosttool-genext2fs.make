# -*-makefile-*-
# $Id: hosttool-genext2fs.make,v 1.4 2003/12/19 08:09:23 bsp Exp $
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
ifdef PTXCONF_GENEXT2FS
PACKAGES += hosttool-genext2fs
endif

#
# Paths and names 
#
HOSTTOOL_GENEXT2FS_VERSION	= 1.3.orig
HOSTTOOL_GENEXT2FS		= genext2fs-$(HOSTTOOL_GENEXT2FS_VERSION)
HOSTTOOL_GENEXT2FS_TARBALL	= genext2fs_$(HOSTTOOL_GENEXT2FS_VERSION).$(HOSTTOOL_GENEXT2FS_SUFFIX)
HOSTTOOL_GENEXT2FS_SUFFIX	= tar.gz
HOSTTOOL_GENEXT2FS_URL		= http://ftp.debian.org/debian/pool/main/g/genext2fs/$(HOSTTOOL_GENEXT2FS_TARBALL)
HOSTTOOL_GENEXT2FS_SOURCE	= $(SRCDIR)/$(HOSTTOOL_GENEXT2FS_TARBALL)
HOSTTOOL_GENEXT2FS_DIR		= $(BUILDDIR)/$(HOSTTOOL_GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-genext2fs_get: $(STATEDIR)/hosttool-genext2fs.get

hosttool-genext2fs_get_deps  =  $(HOSTTOOL_GENEXT2FS_SOURCE)

$(STATEDIR)/hosttool-genext2fs.get: $(hosttool-genext2fs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_GENEXT2FS))
	touch $@

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
	@$(call extract, $(HOSTTOOL_GENEXT2FS_SOURCE))
	@$(call patchin, $(HOSTTOOL_GENEXT2FS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-genext2fs_prepare: $(STATEDIR)/hosttool-genext2fs.prepare

HOSTTOOL_GENEXT2FS_ENV		=  $(HOSTCC_ENV)

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
	make -C $(HOSTTOOL_GENEXT2FS_DIR) $(HOSTTOOL_GENEXT2FS_ENV)
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

	install -m 755 $(HOSTTOOL_GENEXT2FS_DIR)/genext2fs $(PTXCONF_PREFIX)/bin/
	install -m 644 $(HOSTTOOL_GENEXT2FS_DIR)/genext2fs.8 $(PTXCONF_PREFIX)/man/man8/
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
	rm -rf $(STATEDIR)/hosttool-genext2fs.* $(HOSTTOOL_GENEXT2FS_DIR)

# vim: syntax=make

# -*-makefile-*-
# $id$
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
PACKAGES += xchain-genext2fs
endif

#
# Paths and names 
#
XCHAIN_GENEXT2FS_VERSION	= 1.3.orig
XCHAIN_GENEXT2FS		= genext2fs-$(XCHAIN_GENEXT2FS_VERSION)
XCHAIN_GENEXT2FS_TARBALL	= genext2fs_$(XCHAIN_GENEXT2FS_VERSION).$(XCHAIN_GENEXT2FS_SUFFIX)
XCHAIN_GENEXT2FS_SUFFIX		= tar.gz
XCHAIN_GENEXT2FS_URL		= http://ftp.debian.org/debian/pool/main/g/genext2fs/$(XCHAIN_GENEXT2FS_TARBALL)
XCHAIN_GENEXT2FS_SOURCE		= $(SRCDIR)/$(XCHAIN_GENEXT2FS_TARBALL)
XCHAIN_GENEXT2FS_DIR		= $(BUILDDIR)/$(XCHAIN_GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-genext2fs_get: $(STATEDIR)/xchain-genext2fs.get

xchain-genext2fs_get_deps  =  $(XCHAIN_GENEXT2FS_SOURCE)

$(STATEDIR)/xchain-genext2fs.get: $(xchain-genext2fs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XCHAIN_GENEXT2FS))
	touch $@

$(XCHAIN_GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN_GENEXT2FS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-genext2fs_extract: $(STATEDIR)/xchain-genext2fs.extract

$(STATEDIR)/xchain-genext2fs.extract: $(STATEDIR)/xchain-genext2fs.get
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_GENEXT2FS_DIR))
	@$(call extract, $(XCHAIN_GENEXT2FS_SOURCE))
	@$(call patchin, $(XCHAIN_GENEXT2FS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-genext2fs_prepare: $(STATEDIR)/xchain-genext2fs.prepare

XCHAIN_GENEXT2FS_ENV		=  $(HOSTCC_ENV)

xchain-genext2fs_prepare_deps = \
	$(STATEDIR)/xchain-genext2fs.extract

$(STATEDIR)/xchain-genext2fs.prepare: $(xchain-genext2fs_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-genext2fs_compile: $(STATEDIR)/xchain-genext2fs.compile

xchain-genext2fs_compile_deps = $(STATEDIR)/xchain-genext2fs.prepare

$(STATEDIR)/xchain-genext2fs.compile: $(xchain-genext2fs_compile_deps)
	@$(call targetinfo, $@)
	make -C $(XCHAIN_GENEXT2FS_DIR) $(XCHAIN_GENEXT2FS_ENV)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-genext2fs_install: $(STATEDIR)/xchain-genext2fs.install

xchain-genext2fs_install_deps = $(STATEDIR)/xchain-genext2fs.compile

$(STATEDIR)/xchain-genext2fs.install:$(xchain-genext2fs_install_deps)
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/bin/
	install -d $(PTXCONF_PREFIX)/man/man8/

	install -m 755 $(XCHAIN_GENEXT2FS_DIR)/genext2fs $(PTXCONF_PREFIX)/bin/
	install -m 644 $(XCHAIN_GENEXT2FS_DIR)/genext2fs.8 $(PTXCONF_PREFIX)/man/man8/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-genext2fs_targetinstall: $(STATEDIR)/xchain-genext2fs.targetinstall

$(STATEDIR)/xchain-genext2fs.targetinstall: $(STATEDIR)/xchain-genext2fs.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-genext2fs_clean: 
	rm -rf $(STATEDIR)/xchain-genext2fs.* $(XCHAIN_GENEXT2FS_DIR)

# vim: syntax=make

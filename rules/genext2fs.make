# -*-makefile-*-
# $id$
#
# (C) 2003 by Ixia Corporation (www.ixiacom.com)
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GENEXT2FS
PACKAGES += genext2fs
endif

#
# Paths and names 
#
GENEXT2FS_VERSION		= 1.3.orig
GENEXT2FS			= genext2fs-$(GENEXT2FS_VERSION)
GENEXT2FS_TARBALL		= genext2fs_$(GENEXT2FS_VERSION).$(GENEXT2FS_SUFFIX)
GENEXT2FS_SUFFIX		= tar.gz
GENEXT2FS_URL			= http://ftp.debian.org/debian/pool/main/g/genext2fs/$(GENEXT2FS_TARBALL)
GENEXT2FS_SOURCE		= $(SRCDIR)/$(GENEXT2FS_TARBALL)
GENEXT2FS_DIR			= $(BUILDDIR)/$(GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

genext2fs_get: $(STATEDIR)/genext2fs.get

genext_get_deps  =  $(GENEXT2FS_SOURCE)

$(STATEDIR)/genext2fs.get: $(genext_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GENEXT2FS))
	touch $@

$(GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GENEXT2FS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

genext2fs_extract: $(STATEDIR)/genext2fs.extract

$(STATEDIR)/genext2fs.extract: $(STATEDIR)/genext2fs.get
	@$(call targetinfo, genext2fs.extract)
	@$(call clean, $(GENEXT2FS.DIR))
	@$(call extract, $(GENEXT2FS_SOURCE))
	@$(call patchin, $(GENEXT2FS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

genext2fs_prepare: $(STATEDIR)/genext2fs.prepare

GENEXT2FS_ENV		=  $(HOSTCC_ENV)

genext2fs_prepare_deps = \
	$(STATEDIR)/genext2fs.extract

$(STATEDIR)/genext2fs.prepare: $(genext2fs_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

genext2fs_compile: $(STATEDIR)/genext2fs.compile

genext2fs_compile_deps = $(STATEDIR)/genext2fs.prepare

$(STATEDIR)/genext2fs.compile: $(genext2fs_compile_deps)
	@$(call targetinfo, $@)
	make -C $(GENEXT2FS_DIR) $(GENEXT2FS_ENV)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

genext2fs_install: $(STATEDIR)/genext2fs.install

genext2fs_install_deps = $(STATEDIR)/genext2fs.compile

$(STATEDIR)/genext2fs.install:$(genext2fs_install_deps)
	@$(call targetinfo, genext2fs.install)
	make -C $(GENEXT2FS_DIR) install DESTDIR=$(PTXCONF_PREFIX)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

genext2fs_targetinstall: $(STATEDIR)/genext2fs.targetinstall

$(STATEDIR)/genext2fs.targetinstall: $(STATEDIR)/genext2fs.install
	@$(call targetinfo, genext2fs.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

genext2fs_clean: 
	rm -rf $(STATEDIR)/genext2fs.* $(GENEXT2FS_DIR)

# vim: syntax=make

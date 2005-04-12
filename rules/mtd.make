# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MTD_UTILS
PACKAGES += mtd
endif

#
# Paths and names
#
MTD_VERSION	= 20040621-1
MTD		= mtd-$(MTD_VERSION)
MTD_SUFFIX	= tar.gz
MTD_URL		= http://www.pengutronix.de/software/mtd-snapshots/$(MTD).$(MTD_SUFFIX)
MTD_SOURCE	= $(SRCDIR)/$(MTD).$(MTD_SUFFIX)
MTD_DIR		= $(BUILDDIR)/$(MTD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mtd_get: $(STATEDIR)/mtd.get

mtd_get_deps = $(MTD_SOURCE)

$(STATEDIR)/mtd.get: $(mtd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(MTD))
	touch $@

$(MTD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MTD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd_extract: $(STATEDIR)/mtd.extract

mtd_extract_deps = $(STATEDIR)/mtd.get

$(STATEDIR)/mtd.extract: $(mtd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MTD_DIR))
	@$(call extract, $(MTD_SOURCE))
	@$(call patchin, $(MTD))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd_prepare: $(STATEDIR)/mtd.prepare

#
# dependencies
#
mtd_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/mtd.extract

MTD_PATH	= PATH=$(CROSS_PATH)
MTD_MAKEVARS	= CROSS=$(PTXCONF_COMPILER_PREFIX)
MTD_ENV		= $(CROSS_ENV)

$(STATEDIR)/mtd.prepare: $(mtd_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mtd_compile: $(STATEDIR)/mtd.compile

mtd_compile_deps = $(STATEDIR)/mtd.prepare

$(STATEDIR)/mtd.compile: $(mtd_compile_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_MTD_FLASH_ERASE
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flash_erase $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flash_eraseall $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_INFO
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flash_info $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flash_lock $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flash_unlock $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASHCP
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make flashcp $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FTL_CHECK
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make ftl_check $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make ftl_format $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make jffs-dump $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make jffs2dump $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS2READER
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make jffs2reader $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_MTDDEBUG
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make mtd_debug $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_NANDDUMP
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make nanddump $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_NANDWRITE
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make nandwrite $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make nftl_format $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_NFTLDUMP
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make nftldump $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_MKJFFS
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make mkfs.jffs $(MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_MKJFFS2
	cd $(MTD_DIR)/util && $(MTD_ENV) $(MTD_PATH) make mkfs.jffs2 $(MTD_MAKEVARS)
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mtd_install: $(STATEDIR)/mtd.install

$(STATEDIR)/mtd.install: $(STATEDIR)/mtd.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mtd_targetinstall: $(STATEDIR)/mtd.targetinstall

mtd_targetinstall_deps	=  $(STATEDIR)/mtd.compile
ifdef PTXCONF_MTD_MKJFFS
mtd_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall
endif
ifdef PTXCONF_MTD_MKJFFS2
mtd_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall
endif

$(STATEDIR)/mtd.targetinstall: $(mtd_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/sbin

ifdef PTXCONF_MTD_FLASH_ERASE
	install $(BUILDDIR)/$(MTD)/util/flash_erase $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flash_erase
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	install $(BUILDDIR)/$(MTD)/util/flash_eraseall $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flash_eraseall
endif
ifdef PTXCONF_MTD_FLASH_INFO
	install $(BUILDDIR)/$(MTD)/util/flash_info $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flash_info
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	install $(BUILDDIR)/$(MTD)/util/flash_lock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flash_lock
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	install $(BUILDDIR)/$(MTD)/util/flash_unlock $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flash_unlock
endif
ifdef PTXCONF_MTD_FLASHCP
	install $(BUILDDIR)/$(MTD)/util/flashcp $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/flashcp
endif
ifdef PTXCONF_MTD_FTL_CHECK
	install $(BUILDDIR)/$(MTD)/util/ftl_check $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/ftl_check
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	install $(BUILDDIR)/$(MTD)/util/ftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/ftl_format
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	install $(BUILDDIR)/$(MTD)/util/jffs-dump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/jffs-dump
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	install $(BUILDDIR)/$(MTD)/util/jffs2dump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/jffs2dump
endif
ifdef PTXCONF_MTD_JFFS2READER
	install $(BUILDDIR)/$(MTD)/util/jffs2reader $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/jffs2reader
endif
ifdef PTXCONF_MTD_MTDDEBUG
	install $(BUILDDIR)/$(MTD)/util/mtd_debug $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mtd_debug
endif
ifdef PTXCONF_MTD_NANDDUMP
	install $(BUILDDIR)/$(MTD)/util/nanddump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nanddump
endif
ifdef PTXCONF_MTD_NANDWRITE
	install $(BUILDDIR)/$(MTD)/util/nandwrite $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nandwrite
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	install $(BUILDDIR)/$(MTD)/util/nftl_format $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nftl_format
endif
ifdef PTXCONF_MTD_NFTLDUMP
	install $(BUILDDIR)/$(MTD)/util/nftldump $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nftldump
endif
ifdef PTXCONF_MTD_MKJFFS
	install $(BUILDDIR)/$(MTD)/util/mkfs.jffs $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mkfs.jffs
endif
ifdef PTXCONF_MTD_MKJFFS2
	install $(BUILDDIR)/$(MTD)/util/mkfs.jffs2 $(ROOTDIR)/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mkfs.jffs2
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean:
	rm -rf $(STATEDIR)/mtd.*
	rm -rf $(MTD_DIR)

# vim: syntax=make

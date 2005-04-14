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

	$(call install_init,default)
	$(call install_fixup,PACKAGE,mtd)
	$(call install_fixup,PRIORITY,optional)
	$(call install_fixup,VERSION,$(MTD_VERSION))
	$(call install_fixup,SECTION,base)
	$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	$(call install_fixup,DEPENDS,libc)
	$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_MTD_FLASH_ERASE
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flash_erase, /sbin/flash_erase)
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flash_eraseall, /sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_FLASH_INFO
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flash_info, /sbin/flash_info)
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flash_lock, /sbin/flash_lock)
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flash_unlock, /sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_FLASHCP
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/flashcp, /sbin/flashcp)
endif
ifdef PTXCONF_MTD_FTL_CHECK
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/ftl_check, /sbin/ftl_check)
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/ftl_format, /sbin/ftl_format)
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/jffs-dump, /sbin/jffs-dump)
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/jffs2dump, /sbin/jffs2dump)
endif
ifdef PTXCONF_MTD_JFFS2READER
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/jffs2reader, /sbin/jffs2reader)
endif
ifdef PTXCONF_MTD_MTDDEBUG
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/mtd_debug, /sbin/mtd_debug)
endif
ifdef PTXCONF_MTD_NANDDUMP
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/nanddump, /sbin/nanddump)
endif
ifdef PTXCONF_MTD_NANDWRITE
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/nandwrite, /sbin/nandwrite)
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/nftl_format, /sbin/nftl_format)
endif
ifdef PTXCONF_MTD_NFTLDUMP
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/nftldump, /sbin/nftldump)
endif
ifdef PTXCONF_MTD_MKJFFS
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/mkfs.jffs, /sbin/mkfs.jffs)
endif
ifdef PTXCONF_MTD_MKJFFS2
	$(call install_copy, 0, 0, 0755, $(MTD_DIR)/util/mkfs.jffs2, /sbin/mkfs.jffs2)
endif

	$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean:
	rm -rf $(STATEDIR)/mtd.*
	rm -rf $(MTD_DIR)

# vim: syntax=make

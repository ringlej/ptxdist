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
PACKAGES-$(PTXCONF_MTD_UTILS) += mtd

#
# Paths and names
#
MTD_VERSION	= 20040621-1
MTD		= mtd-$(MTD_VERSION)
MTD_SUFFIX	= tar.gz
MTD_URL		= http://www.pengutronix.de/software/mtd-snapshots/$(MTD).$(MTD_SUFFIX)
MTD_UTILS_SOURCE	= $(SRCDIR)/$(MTD).$(MTD_SUFFIX)
MTD_DIR		= $(BUILDDIR)/$(MTD)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mtd_get: $(STATEDIR)/mtd.get

$(STATEDIR)/mtd.get: $(mtd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MTD_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MTD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd_extract: $(STATEDIR)/mtd.extract

$(STATEDIR)/mtd.extract: $(mtd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MTD_DIR))
	@$(call extract, $(MTD_UTILS_SOURCE))
	@$(call patchin, $(MTD))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd_prepare: $(STATEDIR)/mtd.prepare

MTD_PATH	= PATH=$(CROSS_PATH)
MTD_MAKEVARS	= CROSS=$(COMPILER_PREFIX)
MTD_ENV		= $(CROSS_ENV)

$(STATEDIR)/mtd.prepare: $(mtd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mtd_compile: $(STATEDIR)/mtd.compile

$(STATEDIR)/mtd.compile: $(mtd_compile_deps_default)
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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mtd_install: $(STATEDIR)/mtd.install

$(STATEDIR)/mtd.install: $(mtd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mtd_targetinstall: $(STATEDIR)/mtd.targetinstall

$(STATEDIR)/mtd.targetinstall: $(mtd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mtd)
	@$(call install_fixup, mtd,PACKAGE,mtd)
	@$(call install_fixup, mtd,PRIORITY,optional)
	@$(call install_fixup, mtd,VERSION,$(subst -,,$(MTD_VERSION)))
	@$(call install_fixup, mtd,SECTION,base)
	@$(call install_fixup, mtd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mtd,DEPENDS,)
	@$(call install_fixup, mtd,DESCRIPTION,missing)

ifdef PTXCONF_MTD_FLASH_ERASE
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flash_erase, /sbin/flash_erase)
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flash_eraseall, /sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_FLASH_INFO
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flash_info, /sbin/flash_info)
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flash_lock, /sbin/flash_lock)
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flash_unlock, /sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_FLASHCP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/flashcp, /sbin/flashcp)
endif
ifdef PTXCONF_MTD_FTL_CHECK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/ftl_check, /sbin/ftl_check)
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/ftl_format, /sbin/ftl_format)
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/jffs-dump, /sbin/jffs-dump)
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/jffs2dump, /sbin/jffs2dump)
endif
ifdef PTXCONF_MTD_JFFS2READER
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/jffs2reader, /sbin/jffs2reader)
endif
ifdef PTXCONF_MTD_MTDDEBUG
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/mtd_debug, /sbin/mtd_debug)
endif
ifdef PTXCONF_MTD_NANDDUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/nanddump, /sbin/nanddump)
endif
ifdef PTXCONF_MTD_NANDWRITE
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/nandwrite, /sbin/nandwrite)
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/nftl_format, /sbin/nftl_format)
endif
ifdef PTXCONF_MTD_NFTLDUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/nftldump, /sbin/nftldump)
endif
ifdef PTXCONF_MTD_MKJFFS
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/mkfs.jffs, /sbin/mkfs.jffs)
endif
ifdef PTXCONF_MTD_MKJFFS2
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_DIR)/util/mkfs.jffs2, /sbin/mkfs.jffs2)
endif

	@$(call install_finish, mtd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean:
	rm -rf $(STATEDIR)/mtd.*
	rm -rf $(IMAGEDIR)/mtd_*
	rm -rf $(MTD_DIR)

# vim: syntax=make

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
MTD_UTILS_VERSION	= 1.0.0
MTD_UTILS		= mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SUFFIX	= tar.gz
MTD_UTILS_URL		= ftp://ftp.infradead.org/pub/mtd-utils/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_SOURCE	= $(SRCDIR)/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_DIR		= $(BUILDDIR)/$(MTD_UTILS)

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
	@$(call get, $(MTD_UTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd_extract: $(STATEDIR)/mtd.extract

$(STATEDIR)/mtd.extract: $(mtd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MTD_UTILS_DIR))
	@$(call extract, $(MTD_UTILS_SOURCE))
	@$(call patchin, $(MTD_UTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd_prepare: $(STATEDIR)/mtd.prepare

MTD_UTILS_PATH		= PATH=$(CROSS_PATH)
MTD_UTILS_MAKEVARS	= CROSS=$(COMPILER_PREFIX)
MTD_UTILS_ENV		= $(CROSS_ENV)

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
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flash_erase $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flash_eraseall $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_INFO
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flash_info $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flash_lock $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flash_unlock $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FLASHCP
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make flashcp $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FTL_CHECK
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make ftl_check $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make ftl_format $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make jffs-dump $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make jffs2dump $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_JFFS2READER
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make jffs2reader $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_MTDDEBUG
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make mtd_debug $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_NANDDUMP
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make nanddump $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_NANDWRITE
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make nandwrite $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make nftl_format $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_NFTLDUMP
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make nftldump $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_MKJFFS
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make mkfs.jffs $(MTD_UTILS_MAKEVARS)
endif
ifdef PTXCONF_MTD_MKJFFS2
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_ENV) $(MTD_UTILS_PATH) make mkfs.jffs2 $(MTD_UTILS_MAKEVARS)
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
	@$(call install_fixup, mtd,VERSION,$(subst -,,$(MTD_UTILS_VERSION)))
	@$(call install_fixup, mtd,SECTION,base)
	@$(call install_fixup, mtd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mtd,DEPENDS,)
	@$(call install_fixup, mtd,DESCRIPTION,missing)

ifdef PTXCONF_MTD_FLASH_ERASE
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_erase, /sbin/flash_erase)
endif
ifdef PTXCONF_MTD_FLASH_ERASEALL
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_eraseall, /sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_FLASH_INFO
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_info, /sbin/flash_info)
endif
ifdef PTXCONF_MTD_FLASH_LOCK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_lock, /sbin/flash_lock)
endif
ifdef PTXCONF_MTD_FLASH_UNLOCK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_unlock, /sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_FLASHCP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/flashcp, /sbin/flashcp)
endif
ifdef PTXCONF_MTD_FTL_CHECK
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/ftl_check, /sbin/ftl_check)
endif
ifdef PTXCONF_MTD_FTL_FORMAT
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/ftl_format, /sbin/ftl_format)
endif
ifdef PTXCONF_MTD_JFFS_DUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/jffs-dump, /sbin/jffs-dump)
endif
ifdef PTXCONF_MTD_JFFS2_DUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/jffs2dump, /sbin/jffs2dump)
endif
ifdef PTXCONF_MTD_JFFS2READER
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/jffs2reader, /sbin/jffs2reader)
endif
ifdef PTXCONF_MTD_MTDDEBUG
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/mtd_debug, /sbin/mtd_debug)
endif
ifdef PTXCONF_MTD_NANDDUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/nanddump, /sbin/nanddump)
endif
ifdef PTXCONF_MTD_NANDWRITE
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/nandwrite, /sbin/nandwrite)
endif
ifdef PTXCONF_MTD_NFTL_FORMAT
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/nftl_format, /sbin/nftl_format)
endif
ifdef PTXCONF_MTD_NFTLDUMP
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/nftldump, /sbin/nftldump)
endif
ifdef PTXCONF_MTD_MKJFFS
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/mkfs.jffs, /sbin/mkfs.jffs)
endif
ifdef PTXCONF_MTD_MKJFFS2
	@$(call install_copy, mtd, 0, 0, 0755, $(MTD_UTILS_DIR)/mkfs.jffs2, /sbin/mkfs.jffs2)
endif

	@$(call install_finish, mtd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd_clean:
	rm -rf $(STATEDIR)/mtd.*
	rm -rf $(IMAGEDIR)/mtd_*
	rm -rf $(MTD_UTILS_DIR)

# vim: syntax=make

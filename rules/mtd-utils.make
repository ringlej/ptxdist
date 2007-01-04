# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MTD_UTILS) += mtd-utils

#
# Paths and names
#
MTD_UTILS_VERSION	:= 1.0.0
MTD_UTILS		:= mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SUFFIX	:= tar.gz
MTD_UTILS_URL		:= ftp://ftp.infradead.org/pub/mtd-utils/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_SOURCE	:= $(SRCDIR)/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_DIR		:= $(BUILDDIR)/$(MTD_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mtd-utils_get: $(STATEDIR)/mtd-utils.get

$(STATEDIR)/mtd-utils.get: $(mtd-utils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MTD_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MTD_UTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mtd-utils_extract: $(STATEDIR)/mtd-utils.extract

$(STATEDIR)/mtd-utils.extract: $(mtd-utils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MTD_UTILS_DIR))
	@$(call extract, MTD_UTILS)
	@$(call patchin, MTD_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mtd-utils_prepare: $(STATEDIR)/mtd-utils.prepare

MTD_UTILS_PATH		:= PATH=$(CROSS_PATH)
MTD_UTILS_ENV 		:= $(CROSS_ENV)
MTD_UTILS_MAKEVARS	:= \
	CROSS="$(COMPILER_PREFIX)" \
	CPPFLAGS="$(CROSS_CPPFLAGS)" \
	LDFLAGS="$(CROSS_LDFLAGS)"

$(STATEDIR)/mtd-utils.prepare: $(mtd-utils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mtd-utils_compile: $(STATEDIR)/mtd-utils.compile

$(STATEDIR)/mtd-utils.compile: $(mtd-utils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_PATH) $(MAKE) $(PARALLELMFLAGS) $(MTD_UTILS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mtd-utils_install: $(STATEDIR)/mtd-utils.install

$(STATEDIR)/mtd-utils.install: $(mtd-utils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mtd-utils_targetinstall: $(STATEDIR)/mtd-utils.targetinstall

$(STATEDIR)/mtd-utils.targetinstall: $(mtd-utils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mtd-utils)
	@$(call install_fixup, mtd-utils,PACKAGE,mtd-utils)
	@$(call install_fixup, mtd-utils,PRIORITY,optional)
	@$(call install_fixup, mtd-utils,VERSION,$(MTD_UTILS_VERSION))
	@$(call install_fixup, mtd-utils,SECTION,base)
	@$(call install_fixup, mtd-utils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mtd-utils,DEPENDS,)
	@$(call install_fixup, mtd-utils,DESCRIPTION,missing)

ifdef PTXCONF_MTD_UTILS_FLASH_ERASE
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_erase, /sbin/flash_erase)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_ERASEALL
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_eraseall, /sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_INFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_info, /sbin/flash_info)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_LOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_lock, /sbin/flash_lock)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_UNLOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flash_unlock, /sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_UTILS_FLASHCP
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/flashcp, /sbin/flashcp)
endif
ifdef PTXCONF_MTD_UTILS_FTL_CHECK
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/ftl_check, /sbin/ftl_check)
endif
ifdef PTXCONF_MTD_UTILS_FTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/ftl_format, /sbin/ftl_format)
endif
ifdef PTXCONF_MTD_UTILS_JFFS2_DUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/jffs2dump, /sbin/jffs2dump)
endif
#ifdef PTXCONF_MTD_UTILS_JFFS2READER
#	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/jffs2reader, /sbin/jffs2reader)
#endif
ifdef PTXCONF_MTD_UTILS_MTDDEBUG
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/mtd_debug, /sbin/mtd_debug)
endif
ifdef PTXCONF_MTD_UTILS_NANDDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/nanddump, /sbin/nanddump)
endif
ifdef PTXCONF_MTD_UTILS_NANDWRITE
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/nandwrite, /sbin/nandwrite)
endif
ifdef PTXCONF_MTD_UTILS_NFTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/nftl_format, /sbin/nftl_format)
endif
ifdef PTXCONF_MTD_UTILS_NFTLDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/nftldump, /sbin/nftldump)
endif
ifdef PTXCONF_MTD_UTILS_MKJFFS
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/mkfs.jffs, /sbin/mkfs.jffs)
endif
ifdef PTXCONF_MTD_UTILS_MKJFFS2
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/mkfs.jffs2, /sbin/mkfs.jffs2)
endif

	@$(call install_finish, mtd-utils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd-utils_clean:
	rm -rf $(STATEDIR)/mtd-utils.*
	rm -rf $(IMAGEDIR)/mtd-utils_*
	rm -rf $(MTD_UTILS_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
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
MTD_UTILS_VERSION	:= 1.2.0
MTD_UTILS		:= mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SUFFIX	:= tar.bz2
MTD_UTILS_URL		:= ftp://ftp.infradead.org/pub/mtd-utils/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_SOURCE	:= $(SRCDIR)/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_DIR		:= $(BUILDDIR)/$(MTD_UTILS)
MTD_UTILS_UBI_DIR	:= $(BUILDDIR)/$(MTD_UTILS)/ubi-utils/new-utils

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MTD_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, MTD_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MTD_UTILS_PATH		:= PATH=$(CROSS_PATH)
MTD_UTILS_ENV 		:= \
	$(CROSS_ENV) \
	CROSS='$(COMPILER_PREFIX)' \
	CPPFLAGS='$(CROSS_CPPFLAGS)' \
	LDFLAGS='$(CROSS_LDFLAGS)' \
	WITHOUT_XATTR=1

ifndef PTXCONF_MTD_UTILS_USE_LIBLZO
	MTD_UTILS_ENV += WITHOUT_LZO=1
endif

MTD_UTILS_MAKEVARS	:= BUILDDIR=. WITHOUT_XATTR=1

$(STATEDIR)/mtd-utils.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-utils.compile:
	@$(call targetinfo)
	cd $(MTD_UTILS_DIR) && $(MTD_UTILS_PATH) $(MTD_UTILS_ENV) \
		$(MAKE) $(MTD_UTILS_MAKEVARS) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/mtd-utils.install:
#	@$(call targetinfo)
#	@$(call install, MTD_UTILS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-utils.targetinstall:
	@$(call targetinfo)

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
ifdef PTXCONF_MTD_UTILS_MKJFFS2
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_DIR)/mkfs.jffs2, /sbin/mkfs.jffs2)
endif

ifdef PTXCONF_MTD_UTILS_UBIATTACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubiattach, /sbin/ubiattach)
endif
ifdef PTXCONF_MTD_UTILS_UBIDETACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubidetach, /sbin/ubidetach)
endif
ifdef PTXCONF_MTD_UTILS_UBICRC32
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubicrc32, /sbin/ubicrc32)
endif
ifdef PTXCONF_MTD_UTILS_UBIMKVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubimkvol, /sbin/ubimkvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIRMVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubirmvol, /sbin/ubirmvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIUPDATEVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubirmvol, /sbin/ubiupdatevol)
endif
ifdef PTXCONF_MTD_UTILS_UBINFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubinfo, /sbin/ubinfo)
endif
ifdef PTXCONF_MTD_UTILS_UBIFORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubiformat, /sbin/ubiformat)
endif
ifdef PTXCONF_MTD_UTILS_UBINIZE
	@$(call install_copy, mtd-utils, 0, 0, 0755, $(MTD_UTILS_UBI_DIR)/ubinize, /sbin/ubinize)
endif

	@$(call install_finish, mtd-utils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mtd-utils_clean:
	rm -rf $(STATEDIR)/mtd-utils.*
	rm -rf $(PKGDIR)/mtd-utils_*
	rm -rf $(MTD_UTILS_DIR)

# vim: syntax=make

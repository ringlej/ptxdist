# -*-makefile-*-
#
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
MTD_UTILS_VERSION	:= 1.3.0
MTD_UTILS		:= mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SUFFIX	:= tar.bz2
MTD_UTILS_URL		:= ftp://ftp.infradead.org/pub/mtd-utils/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_SOURCE	:= $(SRCDIR)/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_DIR		:= $(BUILDDIR)/$(MTD_UTILS)
MTD_UTILS_LICENSE	:= GPLv2+

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
MTD_UTILS_COMPILE_ENV 	:= \
	$(CROSS_ENV) \
	CROSS="$(COMPILER_PREFIX)" \
	WITHOUT_XATTR=1

ifndef PTXCONF_MTD_UTILS_USE_LIBLZO
MTD_UTILS_COMPILE_ENV += WITHOUT_LZO=1
endif

MTD_UTILS_MAKEVARS := BUILDDIR=$(MTD_UTILS_DIR)
MTD_UTILS_MAKE_PAR := NO

$(STATEDIR)/mtd-utils.prepare:
	@$(call targetinfo)
	@$(call touch)

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
	@$(call install_fixup, mtd-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mtd-utils,DEPENDS,)
	@$(call install_fixup, mtd-utils,DESCRIPTION,missing)

ifdef PTXCONF_MTD_UTILS_FLASH_ERASE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_erase)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_ERASEALL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_INFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_info)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_LOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_lock)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_UNLOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_UTILS_FLASHCP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flashcp)
endif
ifdef PTXCONF_MTD_UTILS_FTL_CHECK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ftl_check)
endif
ifdef PTXCONF_MTD_UTILS_FTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ftl_format)
endif
ifdef PTXCONF_MTD_UTILS_JFFS2_DUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/jffs2dump)
endif

ifdef PTXCONF_MTD_UTILS_MTDDEBUG
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mtd_debug)
endif
ifdef PTXCONF_MTD_UTILS_NANDDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nanddump)
endif
ifdef PTXCONF_MTD_UTILS_NANDWRITE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nandwrite)
endif
ifdef PTXCONF_MTD_UTILS_NFTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nftl_format)
endif
ifdef PTXCONF_MTD_UTILS_NFTLDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nftldump)
endif
ifdef PTXCONF_MTD_UTILS_MKJFFS2
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mkfs.jffs2)
endif
ifdef PTXCONF_MTD_UTILS_SUMTOOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/sumtool)
endif

ifdef PTXCONF_MTD_UTILS_UBIATTACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiattach)
endif
ifdef PTXCONF_MTD_UTILS_UBIDETACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubidetach)
endif
ifdef PTXCONF_MTD_UTILS_UBICRC32
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubicrc32)
endif
ifdef PTXCONF_MTD_UTILS_UBIMKVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubimkvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIRMVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubirmvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIUPDATEVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiupdatevol)
endif
ifdef PTXCONF_MTD_UTILS_UBINFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubinfo)
endif
ifdef PTXCONF_MTD_UTILS_UBIFORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiformat)
endif
ifdef PTXCONF_MTD_UTILS_UBINIZE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubinize)
endif
ifdef PTXCONF_MTD_UTILS_MKFS_UBIFS
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mkfs.ubifs);
endif
ifdef PTXCONF_MTD_UTILS_MTDINFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mtdinfo)
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

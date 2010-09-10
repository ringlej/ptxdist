# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XFSPROGS) += xfsprogs

#
# Paths and names
#
XFSPROGS_VERSION:= 3.0.5
XFSPROGS	:= xfsprogs-$(XFSPROGS_VERSION)
XFSPROGS_SUFFIX	:= tar.gz
XFSPROGS_URL	:= ftp://oss.sgi.com/projects/xfs/cmd_tars-oct_09/$(XFSPROGS).$(XFSPROGS_SUFFIX)
XFSPROGS_SOURCE	:= $(SRCDIR)/$(XFSPROGS).$(XFSPROGS_SUFFIX)
XFSPROGS_DIR	:= $(BUILDDIR)/$(XFSPROGS)
XFSPROGS_LICENSE:= GPLv2, LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XFSPROGS_SOURCE):
	@$(call targetinfo)
	@$(call get, XFSPROGS)

#
# autoconf
#
XFSPROGS_CONF_TOOL:= autoconf
XFSPROGS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
XFSPROGS_CPPFLAGS := $(strip $(PTXCONF_TARGET_EXTRA_CPPFLAGS) $(PTXDIST_CROSS_CPPFLAGS))
XFSPROGS_MAKE_OPT := GCCFLAGS="$(XFSPROGS_CPPFLAGS)"

XFSPROGS_INSTALL_OPT := \
	prefix=${XFSPROGS_PKGDIR}/usr \
	PKG_ROOT_SBIN_DIR=${XFSPROGS_PKGDIR}/sbin \
	PKG_ROOT_LIB_DIR=${XFSPROGS_PKGDIR}/lib \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xfsprogs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xfsprogs)
	@$(call install_fixup, xfsprogs,PRIORITY,optional)
	@$(call install_fixup, xfsprogs,SECTION,base)
	@$(call install_fixup, xfsprogs,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, xfsprogs,DESCRIPTION,missing)

ifdef PTXCONF_XFSPROGS_INSTALL_MKXFS
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /sbin/mkfs.xfs)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_XFS_REPAIR
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /sbin/xfs_repair)
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /sbin/fsck.xfs)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_GROWFS
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_growfs)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_INFO
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_info)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_DB
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_db)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_METADUMP
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_metadump)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_CHECK
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_check)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_NCHECK
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_ncheck)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_ADMIN
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_admin)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_IO
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_io)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_FREEZE
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_freeze)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_MKFILE
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_mkfile)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_BMAP
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_bmap)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_LOGPRINT
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_logprint)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_MDRESTORE
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_mdrestore)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_QUOTA
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_quota)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_RTCP
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_rtcp)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_COPY
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_copy)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_ESTIMATE
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_estimate)
endif

ifdef PTXCONF_XFSPROGS_INSTALL_FSR
	@$(call install_copy, xfsprogs, 0, 0, 0755, -, /usr/sbin/xfs_fsr)
	@$(call install_lib, xfsprogs, 0, 0, 0644, libhandle)
endif

	@$(call install_finish, xfsprogs)
	@$(call touch)

# vim: syntax=make

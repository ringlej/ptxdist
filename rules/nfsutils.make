# -*-makefile-*-
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
PACKAGES-$(PTXCONF_NFSUTILS) += nfsutils

#
# Paths and names
#
NFSUTILS_VERSION	:= 1.1.6
NFSUTILS		:= nfs-utils-$(NFSUTILS_VERSION)
NFSUTILS_SUFFIX		:= tar.bz2
NFSUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/nfs/$(NFSUTILS).$(NFSUTILS_SUFFIX)
NFSUTILS_SOURCE		:= $(SRCDIR)/$(NFSUTILS).$(NFSUTILS_SUFFIX)
NFSUTILS_DIR		:= $(BUILDDIR)/$(NFSUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NFSUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, NFSUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NFSUTILS_PATH	:= PATH=$(CROSS_PATH)
NFSUTILS_ENV 	:= \
	$(CROSS_ENV) \
	knfsd_cv_bsd_signals=no

#
# autoconf
#
NFSUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--sbindir=/sbin \
	--disable-gss \
	--disable-kprefix \
	--disable-tirpc \
	--disable-ipv6 \
	--enable-largefile \
	--enable-shared \
	--enable-static \
	--with-rpcgen=internal

# don't trust the default value. Set it as we use it here
NFSUTILS_AUTOCONF += --with-statedir=/var/lib/nfs

ifdef PTXCONF_NFSUTILS_V3
NFSUTILS_AUTOCONF += --enable-nfsv3
else
NFSUTILS_AUTOCONF += --disable-nfsv3
endif

ifdef PTXCONF_NFSUTILS_V4
NFSUTILS_AUTOCONF += --enable-nfsv4
else
NFSUTILS_AUTOCONF += --disable-nfsv4
endif

ifdef PTXCONF_NFSUTILS_WITH_TCPWRAPPERS
NFSUTILS_AUTOCONF += --with-tcp-wrappers=$(SYSROOT)
else
NFSUTILS_AUTOCONF += --without-tcp-wrappers
endif

ifdef PTXCONF_NFSUTILS_RPCUSER_UID
NFSUTILS_RPCUSER_UID := 65534
endif
ifdef PTXCONF_NFSUTILS_NOBODY_UID
NFSUTILS_RPCUSER_UID := 99
endif

NFSUTILS_AUTOCONF += --with-statduser=$(NFSUTILS_RPCUSER_UID)

#  --disable-uuid          Exclude uuid support to avoid buggy libblkid
#  --enable-mount          Create mount.nfs and don't use the util-linux
#                          mount(8) functionality. [default=yes]
#  --with-start-statd=scriptname
#                          When an nfs filesystems is mounted with locking, run
#                          this script
#  --with-tcp-wrappers[=PATH]      Enable tcpwrappers support
#                 (optionally in PATH)
#  --with-krb5=DIR         use Kerberos v5 installation in DIR

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nfsutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nfsutils)
	@$(call install_fixup,nfsutils,PACKAGE,nfsutils)
	@$(call install_fixup,nfsutils,PRIORITY,optional)
	@$(call install_fixup,nfsutils,VERSION,$(NFSUTILS_VERSION))
	@$(call install_fixup,nfsutils,SECTION,base)
	@$(call install_fixup,nfsutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,nfsutils,DEPENDS,)
	@$(call install_fixup,nfsutils,DESCRIPTION,missing)

ifdef PTXCONF_NFSUTILS_INSTALL_EXPORTFS
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/exportfs)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_MOUNTD
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/rpc.mountd)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_NFSD
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/rpc.nfsd)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_NFSSTAT
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/nfsstat)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_SHOWMOUNT
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/showmount)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_STATD
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/rpc.statd)
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/start-statd)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_MOUNT
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/mount.nfs)
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/umount.nfs)
ifdef PTXCONF_NFSUTILS_V4
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/mount.nfs4)
	@$(call install_copy, nfsutils, 0, 0, 0755, -, /sbin/umount.nfs4)
endif
endif

#	#
#	# create the /var/lib/nfs folder
#	# for locking this folder must be persistent on server side!
#	# Do not use tmpfs or any other non persistent filesystem.
#	#

	@$(call install_copy, nfsutils, 0, 0, 0755, /var/lib/nfs)

	mkdir -p $(NFSUTILS_DIR)/ptxdist_install_tmp

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/etab
	@$(call install_copy, nfsutils, 0, 0, 0644, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/etab, \
		/var/lib/nfs/etab, n)

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/rmtab
	@$(call install_copy, nfsutils, 0, 0, 0644, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/rmtab, \
		/var/lib/nfs/rmtab, n)

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/xtab
	@$(call install_copy, nfsutils, 0, 0, 0644, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/xtab, \
		/var/lib/nfs/xtab, n)

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/state
	@$(call install_copy, nfsutils, $(NFSUTILS_RPCUSER_UID), 0, 0600, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/xtab, \
		/var/lib/nfs/xtab, n)

	@$(call install_copy, nfsutils, $(NFSUTILS_RPCUSER_UID), 0, 0700, \
		/var/lib/nfs/sm)

	@$(call install_copy, nfsutils, $(NFSUTILS_RPCUSER_UID), 0, 0700, \
		/var/lib/nfs/sm.bak)

ifdef PTXCONF_NFSUTILS_INSTALL_USER_EXPORTS
#	# install user defined exportfs
	@$(call install_copy, nfsutils, 0, 0, 0644, \
		${PTXDIST_WORKSPACE}/projectroot/etc/exports, \
		/etc/exports, n)
endif

#	#
#	# busybox init: start scripts
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NFSUTILS_NFSD_STARTSCRIPT
	@$(call install_alternative, nfsutils, 0, 0, 0755, /etc/init.d/nfsd)
endif
endif
	@$(call install_finish, nfsutils)

# FIXME: not installed yet:
# /sbin/rpcdebug
# /sbin/sm-notify

	@$(call touch)

# vim: syntax=make

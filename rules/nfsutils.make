# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
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
NFSUTILS_VERSION	:= 1.1.3
NFSUTILS		:= nfs-utils-$(NFSUTILS_VERSION)
NFSUTILS_SUFFIX		:= tar.gz
NFSUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/nfs/$(NFSUTILS).$(NFSUTILS_SUFFIX)
NFSUTILS_SOURCE		:= $(SRCDIR)/$(NFSUTILS).$(NFSUTILS_SUFFIX)
NFSUTILS_DIR		:= $(BUILDDIR)/$(NFSUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nfsutils_get: $(STATEDIR)/nfsutils.get

$(STATEDIR)/nfsutils.get: $(nfsutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NFSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NFSUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nfsutils_extract: $(STATEDIR)/nfsutils.extract

$(STATEDIR)/nfsutils.extract: $(nfsutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NFSUTILS_DIR))
	@$(call extract, NFSUTILS)
	@$(call patchin, NFSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nfsutils_prepare: $(STATEDIR)/nfsutils.prepare

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
	--disable-nfsv4 \
	--disable-gss

# don't trust the default value. Set it as we use it here
NFSUTILS_AUTOCONF += --with-statedir=/var/lib/nfs

ifdef PTXCONF_NFSUTILS_V3
NFSUTILS_AUTOCONF += --enable-nfsv3
else
NFSUTILS_AUTOCONF += --disable-nfsv3
endif

ifdef PTXCONF_NFSUTILS_SECURE_STATD
NFSUTILS_AUTOCONF += --enable-secure-statd
else
NFSUTILS_AUTOCONF += --disable-secure-statd
endif

ifdef PTXCONF_NFSUTILS_RQUOTAD
NFSUTILS_AUTOCONF += --enable-rquotad
else
NFSUTILS_AUTOCONF += --disable-rquotad
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

$(STATEDIR)/nfsutils.prepare: $(nfsutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NFSUTILS_DIR)/config.cache)
	cd $(NFSUTILS_DIR) && \
		$(NFSUTILS_PATH) $(NFSUTILS_ENV) \
		./configure $(NFSUTILS_AUTOCONF) $(NFSUTILS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nfsutils_compile: $(STATEDIR)/nfsutils.compile

$(STATEDIR)/nfsutils.compile: $(nfsutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NFSUTILS_DIR) && $(NFSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nfsutils_install: $(STATEDIR)/nfsutils.install

$(STATEDIR)/nfsutils.install: $(nfsutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, NFSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nfsutils_targetinstall: $(STATEDIR)/nfsutils.targetinstall

$(STATEDIR)/nfsutils.targetinstall: $(nfsutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, nfsutils)
	@$(call install_fixup,nfsutils,PACKAGE,nfsutils)
	@$(call install_fixup,nfsutils,PRIORITY,optional)
	@$(call install_fixup,nfsutils,VERSION,$(NFSUTILS_VERSION))
	@$(call install_fixup,nfsutils,SECTION,base)
	@$(call install_fixup,nfsutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,nfsutils,DEPENDS,)
	@$(call install_fixup,nfsutils,DESCRIPTION,missing)

#ifdef PTXCONF_NFSUTILS_INSTALL_CLIENTSCRIPT
#	@$(call install_copy, nfsutils, 0, 0, 0755, $(NFSUTILS_DIR)/etc/nodist/nfs-client, /etc/init.d/nfs-client, n)
#endif
#ifdef PTXCONF_NFSUTILS_INSTALL_FUNCTIONSSCRIPT
#	@$(call install_copy, nfsutils, 0, 0, 0644, $(NFSUTILS_DIR)/etc/nodist/nfs-functions, /etc/init.d/nfs-functions, n)
#endif
#ifdef PTXCONF_NFSUTILS_INSTALL_SERVERSCRIPT
#	@$(call install_copy, nfsutils, 0, 0, 0755, $(NFSUTILS_DIR)/etc/nodist/nfs-server, /etc/init.d/nfs-server, n)
#endif

ifdef PTXCONF_NFSUTILS_INSTALL_EXPORTFS
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/exportfs/exportfs, \
		/usr/sbin/exportfs)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_MOUNTD
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/mountd/mountd, \
		/usr/sbin/mountd)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_NFSD
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/nfsd/nfsd, \
		/usr/sbin/rpc.nfsd)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_NFSSTAT
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/nfsstat/nfsstat, \
		/usr/sbin/nfsstat)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_SHOWMOUNT
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/showmount/showmount, /sbin/showmount)
endif

ifdef PTXCONF_NFSUTILS_INSTALL_STATD
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(NFSUTILS_DIR)/utils/statd/statd,\
		/usr/sbin/rpc.statd)
endif

# create the /var/lib/nfs folder
# for locking this folder must be persistent on server side!
# Do not use tmpfs or any other non persistent filesystem.
#
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		/var/lib/nfs)

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

ifdef PTXCONF_ROOTFS_ETC_INITD_NFS_DEFAULT
# install the generic one
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/nfsd, \
		/etc/init.d/nfsd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_NFS_USER
# install users one
	@$(call install_copy, nfsutils, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/nfsd, \
		/etc/init.d/nfsd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NFS_LINK),"")
	@$(call install_copy, nfsutils, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, nfsutils, ../init.d/nfsd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_NFS_LINK))
endif

ifdef PTXCONF_NFSUTILS_INSTALL_USER_EXPORTS
# install user defined exportfs
	@$(call install_copy, nfsutils, 0, 0, 0644, \
		${PTXDIST_WORKSPACE}/projectroot/etc/exports, \
		/etc/exports, n)
endif

	@$(call install_finish, nfsutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nfsutils_clean:
	rm -rf $(STATEDIR)/nfsutils.*
	rm -rf $(PKGDIR)/nfsutils_*
	rm -rf $(NFSUTILS_DIR)

# vim: syntax=make

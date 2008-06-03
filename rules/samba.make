# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SAMBA) += samba

#
# Paths and names
#
SAMBA_VERSION	:= 3.0.23d
SAMBA		:= samba-$(SAMBA_VERSION)
SAMBA_SUFFIX	:= tar.gz
SAMBA_URL	:= http://us5.samba.org/samba/ftp/old-versions/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_SOURCE	:= $(SRCDIR)/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_DIR	:= $(BUILDDIR)/$(SAMBA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

samba_get: $(STATEDIR)/samba.get

$(STATEDIR)/samba.get: $(samba_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SAMBA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SAMBA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

samba_extract: $(STATEDIR)/samba.extract

$(STATEDIR)/samba.extract: $(samba_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SAMBA_DIR))
	@$(call extract, SAMBA)
	@$(call patchin, SAMBA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

samba_prepare: $(STATEDIR)/samba.prepare

SAMBA_PATH	:= PATH=$(CROSS_PATH)

SAMBA_ENV 	:= \
	$(CROSS_ENV) \
	SMB_BUILD_CC_NEGATIVE_ENUM_VALUES=no \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_HAVE_IFACE_IFCONF=yes \
	samba_cv_HAVE_IFACE_IFREQ=yes

#
# autoconf
#
SAMBA_AUTOCONF := $(CROSS_AUTOCONF_USR)

SAMBA_AUTOCONF += --sysconfdir=/etc/samba \
		--libdir=/etc/samba \
		--with-lockdir=/var/lock \
		--with-piddir=/var/lock \
      		--with-configdir=/etc/samba \
		--with-logfilebase=/var/log \
		--with-libdir=/etc/samba \
		--with-privatedir=/etc/samba

ifdef PTXCONF_SAMBA_CUPS
SAMBA_AUTOCONF += --enable-cups
else
SAMBA_AUTOCONF += --disable-cups
endif

ifdef PTXCONF_SAMBA_SMBFS
SAMBA_AUTOCONF += --with-smbmount
endif
$(STATEDIR)/samba.prepare: $(samba_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SAMBA_DIR)/config.cache)
	cd $(SAMBA_DIR)/source && \
		$(SAMBA_PATH) $(SAMBA_ENV) \
		./configure $(SAMBA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

samba_compile: $(STATEDIR)/samba.compile

$(STATEDIR)/samba.compile: $(samba_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SAMBA_DIR)/source && $(SAMBA_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

samba_install: $(STATEDIR)/samba.install

$(STATEDIR)/samba.install: $(samba_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

samba_targetinstall: $(STATEDIR)/samba.targetinstall

$(STATEDIR)/samba.targetinstall: $(samba_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, samba)
	@$(call install_fixup, samba,PACKAGE,samba)
	@$(call install_fixup, samba,PRIORITY,optional)
	@$(call install_fixup, samba,VERSION,$(SAMBA_VERSION))
	@$(call install_fixup, samba,SECTION,base)
	@$(call install_fixup, samba,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, samba,DEPENDS,)
	@$(call install_fixup, samba,DESCRIPTION,missing)

	@$(call install_copy, samba, 0, 0, 0755, /etc/samba)	

ifdef PTXCONF_SAMBA_COMMON
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/nmblookup, /usr/bin/nmblookup)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/net, /usr/bin/net)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbpasswd, /usr/bin/smbpasswd)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/testparm, /usr/bin/testparm)
	@$(call install_copy, samba, 0, 0, 0644, $(SAMBA_DIR)/source/codepages/lowcase.dat, /etc/samba/lowcase.dat,n)
	@$(call install_copy, samba, 0, 0, 0644, $(SAMBA_DIR)/source/codepages/upcase.dat, /etc/samba/upcase.dat,n)
	@$(call install_copy, samba, 0, 0, 0644, $(SAMBA_DIR)/source/codepages/valid.dat, /etc/samba/valid.dat,n)
endif

ifdef PTXCONF_ROOTFS_ETC_SAMBA_CONFIG_DEFAULT
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/samba/smb.conf, \
		/etc/samba/smb.conf, n)
endif
ifdef PTXCONF_ROOTFS_ETC_SAMBA_CONFIG_USER
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/samba/smb.conf,\
		/etc/samba/smb.conf, n)
endif

ifdef PTXCONF_SAMBA_SERVER
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbd, /usr/sbin/smbd)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/nmbd, /usr/sbin/nmbd)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/pdbedit, /usr/sbin/pdbedit)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbcontrol, /usr/sbin/smbcontrol)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbstatus, /usr/sbin/smbstatus)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/tdbbackup, /usr/sbin/tdbbackup)
endif
ifdef PTXCONF_ROOTFS_ETC_SAMBA_SECRETS_USER
	@$(call install_copy, rootfs, 0, 0, 0600, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/samba/secrets.tdb,\
		/etc/samba/secrets.tdb, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_SAMBA_DEFAULT
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/samba, \
		/etc/init.d/samba, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_SAMBA_USER
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/samba,\
		/etc/init.d/samba, n)
endif

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SAMBA_LINK),"")
	@$(call install_copy, samba, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, samba, ../init.d/samba, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SAMBA_LINK))
endif

ifdef PTXCONF_SAMBA_CLIENT
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbcacls, /usr/bin/smbcacls)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbcquotas, /usr/bin/smbcquotas)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbtree, /usr/bin/smbtree)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbclient, /usr/bin/smbclient)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/rpcclient, /usr/bin/rpcclient)
endif

ifdef PTXCONF_SAMBA_LIBCLIENT
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/libsmbclient.so, /usr/lib/libsmbclient.so.0)
	@$(call install_link, samba, libsmbclient.so.0, /usr/lib/libsmbclient.so.0.1)
endif

ifdef PTXCONF_SAMBA_SMBFS
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbmount, /usr/bin/smbmount)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbumount, /usr/bin/smbumount)
endif

	@$(call install_finish, samba)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

samba_clean:
	rm -rf $(STATEDIR)/samba.*
	rm -rf $(PKGDIR)/samba_*
	rm -rf $(SAMBA_DIR)

# vim: syntax=make

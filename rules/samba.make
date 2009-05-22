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
SAMBA_VERSION	:= 3.0.33
SAMBA		:= samba-$(SAMBA_VERSION)
SAMBA_SUFFIX	:= tar.gz
SAMBA_URL	:= http://us5.samba.org/samba/ftp/old-versions/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_SOURCE	:= $(SRCDIR)/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_DIR	:= $(BUILDDIR)/$(SAMBA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SAMBA_SOURCE):
	@$(call targetinfo)
	@$(call get, SAMBA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SAMBA_PATH	:= PATH=$(CROSS_PATH)
SAMBA_ENV	:= \
	$(CROSS_ENV) \
	SMB_BUILD_CC_NEGATIVE_ENUM_VALUES=no \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_HAVE_IFACE_IFCONF=yes \
	samba_cv_HAVE_IFACE_IFREQ=yes

#
# autoconf
#
SAMBA_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--sysconfdir=/etc/samba \
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

$(STATEDIR)/samba.prepare:
	@$(call targetinfo)
	@$(call clean, $(SAMBA_DIR)/config.cache)
	cd $(SAMBA_DIR)/source && \
		$(SAMBA_PATH) $(SAMBA_ENV) \
		./configure $(SAMBA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/samba.compile:
	@$(call targetinfo)
	cd $(SAMBA_DIR)/source && $(SAMBA_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/samba.install:
	@$(call targetinfo)
	cd $(SAMBA_DIR)/source && $(SAMBA_PATH) $(MAKE) install DESTDIR=$(SYSROOT)
	cd $(SAMBA_DIR)/source && $(SAMBA_PATH) $(MAKE) install DESTDIR=$(PKGDIR)/$(SAMBA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/samba.targetinstall:
	@$(call targetinfo)

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

#	#
#	# busybox init
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_SAMBA_STARTSCRIPT
	@$(call install_alternative, samba, 0, 0, 0755, /etc/init.d/samba, n)
endif
endif

ifdef PTXCONF_SAMBA_CLIENT
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbcacls, /usr/bin/smbcacls)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbcquotas, /usr/bin/smbcquotas)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbtree, /usr/bin/smbtree)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbclient, /usr/bin/smbclient)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/rpcclient, /usr/bin/rpcclient)
endif

ifdef PTXCONF_SAMBA_LIBCLIENT
	@$(call install_copy, samba, 0, 0, 0644, $(SAMBA_DIR)/source/bin/libsmbclient.so, /usr/lib/libsmbclient.so.0)
	@$(call install_link, samba, libsmbclient.so.0, /usr/lib/libsmbclient.so.0.1)
endif

ifdef PTXCONF_SAMBA_SMBFS
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbmount, /usr/bin/smbmount)
	@$(call install_copy, samba, 0, 0, 0755, $(SAMBA_DIR)/source/bin/smbumount, /usr/bin/smbumount)
endif

	@$(call install_finish, samba)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

samba_clean:
	rm -rf $(STATEDIR)/samba.*
	rm -rf $(PKGDIR)/samba_*
	rm -rf $(SAMBA_DIR)

# vim: syntax=make

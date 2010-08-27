# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
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
PACKAGES-$(PTXCONF_SAMBA) += samba

#
# Paths and names
#
SAMBA_VERSION	:= 3.0.37
SAMBA		:= samba-$(SAMBA_VERSION)
SAMBA_SUFFIX	:= tar.gz
SAMBA_SOURCE	:= $(SRCDIR)/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_DIR	:= $(BUILDDIR)/$(SAMBA)
SAMBA_LICENSE	:= GPLv2

SAMBA_URL	:= \
	http://www.samba.org/samba/ftp/stable/$(SAMBA).$(SAMBA_SUFFIX) \
	http://www.samba.org/samba/ftp/old-versions/$(SAMBA).$(SAMBA_SUFFIX)

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
	CFLAGS=-O2 \
	libreplace_cv_READDIR_NEEDED=no \
	samba_cv_HAVE_BROKEN_FCNTL64_LOCKS=no \
	samba_cv_HAVE_BROKEN_GETGROUPS=no \
	samba_cv_HAVE_C99_VSNPRINTF=yes \
	samba_cv_HAVE_DEVICE_MAJOR_FN=yes \
	samba_cv_HAVE_DEVICE_MINOR_FN=yes \
	samba_cv_HAVE_FCNTL_LOCK=yes \
	samba_cv_HAVE_FTRUNCATE_EXTEND=yes \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
	samba_cv_HAVE_IFACE_AIX=no \
	samba_cv_HAVE_IFACE_IFCONF=yes \
	samba_cv_HAVE_IFACE_IFREQ=yes \
	samba_cv_HAVE_KERNEL_CHANGE_NOTIFY=yes \
	samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes \
	samba_cv_HAVE_KERNEL_SHARE_MODES=yes \
	samba_cv_HAVE_MAKEDEV=yes \
	samba_cv_HAVE_MMAP=yes \
	samba_cv_HAVE_NATIVE_ICONV=yes \
	samba_cv_HAVE_SECURE_MKSTEMP=yes \
	samba_cv_HAVE_STRUCT_FLOCK64=yes \
	samba_cv_HAVE_TRUNCATED_SALT=no \
	samba_cv_HAVE_WORKING_AF_LOCAL=yes \
	samba_cv_LINUX_LFS_SUPPORT=yes \
	samba_cv_REALPATH_TAKES_NULL=yes \
	samba_cv_REPLACE_INET_NTOA=no \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_USE_SETREUID=yes \
	samba_cv_have_longlong=yes \
	samba_cv_have_setresgid=yes \
	samba_cv_have_setresuid=yes

#
# autoconf
#
SAMBA_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-pie \
	--libdir=/usr/lib/samba \
	--sysconfdir=/etc \
	--with-configdir=/etc/samba \
	--with-libdir=/usr/lib \
	--with-libsmbclient \
	--with-lockdir=/var/lock \
	--with-logfilebase=/var/log \
	--with-piddir=/var/run \
	--with-privatedir=/etc/samba \
	--with-readline \
	--with-rootsbindir=/sbin \
	--with-syslog \
	--without-ads \
	--without-automount \
	--without-krb5 \
	--without-ldap \
	--without-pam \
	--without-utmp \
	--without-winbind

ifdef PTXCONF_SAMBA_CUPS
SAMBA_AUTOCONF += --enable-cups
else
SAMBA_AUTOCONF += --disable-cups
endif

ifdef PTXCONF_SAMBA_SMBFS
SAMBA_AUTOCONF += --with-smbmount
endif

ifdef PTXCONF_ICONV
SAMBA_AUTOCONF += --with-libiconv=$(SYSROOT)/usr
else
SAMBA_AUTOCONF += --without-libiconv
endif

SAMBA_SUBDIR := source
SAMBA_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/samba.targetinstall:
	@$(call targetinfo)

	@$(call install_init, samba)
	@$(call install_fixup, samba,PRIORITY,optional)
	@$(call install_fixup, samba,SECTION,base)
	@$(call install_fixup, samba,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, samba,DESCRIPTION,missing)

	@$(call install_copy, samba, 0, 0, 0755, /etc/samba)

ifdef PTXCONF_SAMBA_COMMON
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/nmblookup)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/net)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbpasswd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/testparm)
	@$(call install_copy, samba, 0, 0, 0644, -, \
		/usr/lib/lowcase.dat)
	@$(call install_copy, samba, 0, 0, 0644, -, \
		/usr/lib/upcase.dat)
	@$(call install_copy, samba, 0, 0, 0644, -, \
		/usr/lib/valid.dat)
endif

ifdef PTXCONF_SAMBA_SERVER
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/sbin/smbd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/sbin/nmbd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/pdbedit)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcontrol)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbstatus)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/tdbbackup)
endif

ifdef PTXCONF_SAMBA_SMB_CONF
	@$(call install_alternative, samba, 0, 0, 0644, \
		/etc/samba/smb.conf)
endif

ifdef PTXCONF_SAMBA_SECRETS_USER
	@$(call install_alternative, samba, 0, 0, 0600, \
		/etc/samba/secrets.tdb)
endif

#	#
#	# busybox init
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_SAMBA_STARTSCRIPT
	@$(call install_alternative, samba, 0, 0, 0755, /etc/init.d/samba)

ifneq ($(call remove_quotes,$(PTXCONF_SAMBA_BBINIT_LINK)),)
	@$(call install_link, samba, \
		../init.d/samba, \
		/etc/rc.d/$(PTXCONF_SAMBA_BBINIT_LINK))
endif
endif
endif

ifdef PTXCONF_SAMBA_CLIENT
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcacls)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcquotas)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbtree)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbclient)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/rpcclient)
endif

ifdef PTXCONF_SAMBA_LIBCLIENT
	@$(call install_copy, samba, 0, 0, 0644, -, \
		/usr/lib/libsmbclient.so)
endif

ifdef PTXCONF_SAMBA_SMBFS
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbmount)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbumount)
endif

	@$(call install_finish, samba)

	@$(call touch)

# vim: syntax=make

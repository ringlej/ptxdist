# -*-makefile-*-
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
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
PACKAGES-$(PTXCONF_INETUTILS) += inetutils

#
# Paths and names
#
INETUTILS_VERSION	:= 1.6
INETUTILS		:= inetutils-$(INETUTILS_VERSION)
INETUTILS_SUFFIX	:= tar.gz
INETUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/inetutils/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_SOURCE	:= $(SRCDIR)/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_DIR		:= $(BUILDDIR)/$(INETUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INETUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, INETUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

INETUTILS_PATH	:= PATH=$(CROSS_PATH)
INETUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
INETUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--with-PATH-CP=/bin/cp \
	--localstatedir=/var \
	--sysconfdir=/etc \
	--libexecdir=/usr/sbin \
	--disable-ftpd \
	--disable-rexecd \
	--disable-talkd \
	--disable-telnetd \
	--disable-telnet \
	--disable-uucpd \
	--disable-ftp \
	--disable-rlogin \
	--disable-logger \
	--disable-talk \
	--disable-tftp \
	--disable-whois \
	--disable-ifconfig \
	--disable-dependency-tracking
# FIXME: Unhandled options:
# --enable-encryption
# --enable-authentication
# --disable-libls
# --disable-ncurses
# --with-krb[4|5]
# --with-wrap
# --with-pam

# build only when enabled (speed up)
ifdef PTXCONF_INETUTILS_INETD
INETUTILS_AUTOCONF += --enable-inetd
else
INETUTILS_AUTOCONF += --disable-inetd
endif

ifdef PTXCONF_INETUTILS_PING
INETUTILS_AUTOCONF += --enable-ping
else
INETUTILS_AUTOCONF += --disable-ping
endif

ifdef PTXCONF_INETUTILS_RCP
INETUTILS_AUTOCONF += --enable-rcp
else
INETUTILS_AUTOCONF += --disable-rcp
endif

ifdef PTXCONF_INETUTILS_RLOGIND
INETUTILS_AUTOCONF += --enable-rlogind
else
INETUTILS_AUTOCONF += --disable-rlogind
endif

ifdef PTXCONF_INETUTILS_RSH
INETUTILS_AUTOCONF += --enable-rsh
else
INETUTILS_AUTOCONF += --disable-rsh
endif

ifdef PTXCONF_INETUTILS_RSHD
INETUTILS_AUTOCONF += --enable-rshd
else
INETUTILS_AUTOCONF += --disable-rshd
endif

ifdef PTXCONF_INETUTILS_SYSLOGD
INETUTILS_AUTOCONF += --enable-syslogd
else
INETUTILS_AUTOCONF += --disable-syslogd
endif

ifdef PTXCONF_INETUTILS_TFTPD
INETUTILS_AUTOCONF += --enable-tftpd
else
INETUTILS_AUTOCONF += --disable-tftpd
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inetutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inetutils)
	@$(call install_fixup, inetutils,PACKAGE,inetutils)
	@$(call install_fixup, inetutils,PRIORITY,optional)
	@$(call install_fixup, inetutils,VERSION,$(INETUTILS_VERSION))
	@$(call install_fixup, inetutils,SECTION,base)
	@$(call install_fixup, inetutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, inetutils,DEPENDS,)
	@$(call install_fixup, inetutils,DESCRIPTION,missing)

ifdef PTXCONF_INETUTILS_INETD
	@$(call install_copy, inetutils, 0, 0, 0755, -, /usr/sbin/inetd)
endif
ifdef PTXCONF_INETUTILS_PING
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_PKGDIR)/usr/bin/ping, /bin/ping)
endif
ifdef PTXCONF_INETUTILS_RCP
	@$(call install_copy, inetutils, 0, 0, 0755, -, /usr/bin/rcp)
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	@$(call install_copy, inetutils, 0, 0, 0755, -, /usr/sbin/rlogind)
endif
ifdef PTXCONF_INETUTILS_RSH
	@$(call install_copy, inetutils, 0, 0, 0755, -, /usr/bin/rsh)
endif
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_copy, inetutils, 0, 0, 0755, -, /usr/sbin/rshd)
	@$(call install_alternative, inetutils, 0, 0, 0644, \
		/etc/inetd.conf.d/inetutils-rshd, n)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_PKGDIR)/usr/sbin/syslogd, /sbin/syslogd)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD_STARTSRCIPT
	@$(call install_alternative, inetutils, 0, 0, 0755, \
		/etc/init.d/syslogd, n)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD_CONFIG
	@$(call install_alternative, inetutils, 0, 0, 0644, \
		/etc/syslog.conf, n)
endif
ifdef PTXCONF_INETUTILS_TFTPD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_PKGDIR)/usr/sbin/tftpd, /sbin/tftpd)
ifneq ($(PTXCONF_INETUTILS_TFTPD_BASE_DIR),"")
#	# create the base dir
	@$(call install_copy, inetutils, 99, 0, 0755, \
		$(PTXCONF_INETUTILS_TFTPD_BASE_DIR) )
endif
	@$(call install_alternative, inetutils, 0, 0, 0644, /etc/inetd.conf.d/tftp, n)
	@$(call install_replace, inetutils, \
		/etc/inetd.conf.d/tftp, \
		@ROOT@, \
		$(PTXCONF_INETUTILS_TFTPD_BASE_DIR) )
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_INETUTILS_INETD_STARTSCRIPT
	@$(call install_alternative, inetutils, 0, 0, 0755, /etc/init.d/inetd, n)
endif
endif

	@$(call install_finish, inetutils)

	@$(call touch)

# vim: syntax=make

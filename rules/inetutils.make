# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
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
INETUTILS_VERSION	= 1.5
INETUTILS		= inetutils-$(INETUTILS_VERSION)
INETUTILS_SUFFIX	= tar.gz
INETUTILS_URL		= $(PTXCONF_SETUP_GNUMIRROR)/inetutils/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_SOURCE	= $(SRCDIR)/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_DIR		= $(BUILDDIR)/$(INETUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

inetutils_get: $(STATEDIR)/inetutils.get

$(STATEDIR)/inetutils.get: $(inetutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(INETUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, INETUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

inetutils_extract: $(STATEDIR)/inetutils.extract

$(STATEDIR)/inetutils.extract: $(inetutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(INETUTILS_DIR))
	@$(call extract, INETUTILS)
	@$(call patchin, INETUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

inetutils_prepare: $(STATEDIR)/inetutils.prepare

INETUTILS_PATH	=  PATH=$(CROSS_PATH)
INETUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
INETUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--with-PATH-CP=/bin/cp \
	--localstatedir=/var \
	--sysconfdir=/etc \
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

$(STATEDIR)/inetutils.prepare: $(inetutils_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(INETUTILS_DIR) && \
		$(INETUTILS_PATH) $(INETUTILS_ENV) \
		./configure $(INETUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

inetutils_compile: $(STATEDIR)/inetutils.compile

$(STATEDIR)/inetutils.compile: $(inetutils_compile_deps_default)
	@$(call targetinfo, $@)
	$(INETUTILS_PATH) make -C $(INETUTILS_DIR)/lib
	$(INETUTILS_PATH) make -C $(INETUTILS_DIR)/libinetutils

# First the libraries:
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/libicmp && $(INETUTILS_PATH) make
endif

# Now the tools:
ifdef PTXCONF_INETUTILS_INETD
	cd $(INETUTILS_DIR)/inetd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/ping && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RCP
	cd $(INETUTILS_DIR)/rcp && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	cd $(INETUTILS_DIR)/rlogind && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSH
	cd $(INETUTILS_DIR)/rsh && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSHD
	cd $(INETUTILS_DIR)/rshd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	cd $(INETUTILS_DIR)/syslogd && $(INETUTILS_PATH) make
endif

ifdef PTXCONF_INETUTILS_TFTPD
	cd $(INETUTILS_DIR)/tftpd && $(INETUTILS_PATH) make
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

inetutils_install: $(STATEDIR)/inetutils.install

$(STATEDIR)/inetutils.install: $(inetutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

inetutils_targetinstall: $(STATEDIR)/inetutils.targetinstall

$(STATEDIR)/inetutils.targetinstall: $(inetutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, inetutils)
	@$(call install_fixup, inetutils,PACKAGE,inetutils)
	@$(call install_fixup, inetutils,PRIORITY,optional)
	@$(call install_fixup, inetutils,VERSION,$(INETUTILS_VERSION))
	@$(call install_fixup, inetutils,SECTION,base)
	@$(call install_fixup, inetutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, inetutils,DEPENDS,)
	@$(call install_fixup, inetutils,DESCRIPTION,missing)

ifdef PTXCONF_INETUTILS_INETD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/inetd/inetd, /usr/sbin/inetd)
endif
ifdef PTXCONF_INETUTILS_PING
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/ping/ping, /bin/ping)
endif
ifdef PTXCONF_INETUTILS_RCP
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rcp/rcp, /usr/bin/rcp)
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rlogind/rlogind, /usr/sbin/rlogind)
endif
ifdef PTXCONF_INETUTILS_RSH
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rsh/rsh, /usr/bin/rsh)
endif
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rshd/rshd, /usr/sbin/rshd)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/syslogd/syslogd, /sbin/syslogd)
endif
ifdef PTXCONF_INETUTILS_TFTPD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/tftpd/tftpd, /sbin/tftpd)
# create the base dir
ifneq ($(PTXCONF_INETUTILS_TFTPD_BASE_DIR),"")
	@$(call install_copy, inetutils, 99, 0, 0755, \
		$(PTXCONF_INETUTILS_TFTPD_BASE_DIR) )
endif
endif
#
# Install the startup for inetd script on request only
#
ifdef PTXCONF_INETUTILS_ETC_INITD_INETD
ifdef PTXCONF_INETUTILS_ETC_INITD_INETD_DEFAULT
# install the generic one
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/inetd, \
		/etc/init.d/inetd, n)
endif

ifdef PTXCONF_INETUTILS_ETC_INITD_INETD_USER
# install users one
	@$(call install_copy, inetutils, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/inetd, \
		/etc/init.d/inetd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK),"")
	@$(call install_copy, inetutils, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, inetutils, ../init.d/inetd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK))
endif
endif

	@$(call install_finish, inetutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inetutils_clean:
	rm -rf $(STATEDIR)/inetutils.*
	rm -rf $(PKGDIR)/inetutils_*
	rm -rf $(INETUTILS_DIR)

# vim: syntax=make

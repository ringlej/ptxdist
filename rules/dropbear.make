# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#                       Pengutronix e.K. <info@pengutronix.de>, Germany
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
PACKAGES-$(PTXCONF_DROPBEAR) += dropbear

#
# Paths and names
#
DROPBEAR_VERSION	:= 0.53.1
DROPBEAR_MD5		:= 0284ea239083f04c8b874e08e1aca243
DROPBEAR		:= dropbear-$(DROPBEAR_VERSION)
DROPBEAR_SUFFIX		:= tar.bz2
DROPBEAR_URL		:= http://matt.ucc.asn.au/dropbear/releases/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_SOURCE		:= $(SRCDIR)/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_DIR		:= $(BUILDDIR)/$(DROPBEAR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DROPBEAR_SOURCE):
	@$(call targetinfo)
	@$(call get, DROPBEAR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DROPBEAR_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls

ifdef PTXCONF_DROPBEAR_ZLIB
DROPBEAR_AUTOCONF	+= --enable-zlib
else
DROPBEAR_AUTOCONF	+= --disable-zlib
endif

ifdef PTXCONF_DROPBEAR_DIS_OPENPTY
DROPBEAR_AUTOCONF	+= --disable-openpty
endif

ifdef PTXCONF_DROPBEAR_DIS_SYSLOG
DROPBEAR_AUTOCONF	+= --disable-syslog
endif

ifdef PTXCONF_DROPBEAR_DIS_LASTLOG
DROPBEAR_AUTOCONF	+= --disable-lastlog
endif

ifdef PTXCONF_DROPBEAR_DIS_UTMP
DROPBEAR_AUTOCONF	+= --disable-utmp
endif

ifdef PTXCONF_DROPBEAR_DIS_UTMPX
DROPBEAR_AUTOCONF	+= --disable-utmpx
endif

ifdef PTXCONF_DROPBEAR_DIS_WTMP
DROPBEAR_AUTOCONF	+= --disable-wtmp
endif

ifdef PTXCONF_DROPBEAR_DIS_WTMPX
DROPBEAR_AUTOCONF	+= --disable-wtmpx
endif

ifdef PTXCONF_DROPBEAR_DIS_LIBUTIL
DROPBEAR_AUTOCONF	+= --disable-libutil
endif

ifdef PTXCONF_DROPBEAR_DIS_PUTUTLINE
DROPBEAR_AUTOCONF	+= --disable-pututline
endif

ifdef PTXCONF_DROPBEAR_DIS_PUTUTXLINE
DROPBEAR_AUTOCONF	+= --disable-pututxline
endif

$(STATEDIR)/dropbear.prepare:
	@$(call targetinfo)
	@$(call world/prepare, DROPBEAR)

ifdef PTXCONF_DROPBEAR_DIS_X11
	@echo "ptxdist: disabling x11 forwarding"
	$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_X11FWD)
else
	@echo "ptxdist: enabling x11 forwarding"
	$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_X11FWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_TCP
	@echo "ptxdist: disabling tcp"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_CLI_LOCALTCPFWD)
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_CLI_REMOTETCPFWD)
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_SVR_LOCALTCPFWD)
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_SVR_REMOTETCPFWD)
else
	@echo "ptxdist: enabling tcp"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_CLI_LOCALTCPFWD)
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_CLI_REMOTETCPFWD)
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_SVR_LOCALTCPFWD)
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_SVR_REMOTETCPFWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_AGENT
	@echo "ptxdist: disabling agent"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_AGENTFWD)
else
	@echo "ptxdist: enabling agent"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,ENABLE_AGENTFWD)
endif


ifdef PTXCONF_DROPBEAR_AES128
	@echo "ptxdist: enabling aes128"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128)
else
	@echo "ptxdist: disabling aes128"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128)
endif

ifdef PTXCONF_DROPBEAR_3DES
	@echo "ptxdist: enabling 3des"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES)
else
	@echo "ptxdist: disabling 3des"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES)
endif

ifdef PTXCONF_DROPBEAR_AES256
	@echo "ptxdist: enabling aes256"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES256)
else
	@echo "ptxdist: disabling aes256"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES256)
endif

ifdef PTXCONF_DROPBEAR_BLOWFISH
	@echo "ptxdist: enabling blowfish"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH)
else
	@echo "ptxdist: disabling blowfish"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH256
	@echo "ptxdist: enabling twofish256"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH256)
else
	@echo "ptxdist: disabling twofish256"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH256)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH128
	@echo "ptxdist: enabling twofish128"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128)
else
	@echo "ptxdist: disabling twofish128"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128)
endif



ifdef PTXCONF_DROPBEAR_SHA1
	@echo "ptxdist: enabling sha1"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
else
	@echo "ptxdist: disabling sha1"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
endif

ifdef PTXCONF_DROPBEAR_SHA1_96
	@echo "ptxdist: enabling sha1-96"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_96_HMAC)
else
	@echo "ptxdist: disabling sha1-96"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_96_HMAC)
endif

ifdef PTXCONF_DROPBEAR_MD5
	@echo "ptxdist: enabling md5"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_MD5_HMAC)
else
	@echo "ptxdist: disabling md5"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_MD5_HMAC)
endif


ifdef PTXCONF_DROPBEAR_RSA
	@echo "ptxdist: enabling rsa"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_RSA)
else
	@echo "ptxdist: disabling rsa"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_RSA)
endif

ifdef PTXCONF_DROPBEAR_DSS
	@echo "ptxdist: enabling dss"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_DSS)
else
	@echo "ptxdist: disabling dss"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_DSS)
endif

ifdef PTXCONF_DROPBEAR_PASSWD
	@echo "ptxdist: enabling passwd"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PASSWORD_AUTH)
else
	@echo "ptxdist: disabling passwd"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PASSWORD_AUTH)
endif

ifdef PTXCONF_DROPBEAR_PUBKEY
	@echo "ptxdist: enabling pubkey"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PUBKEY_AUTH)
else
	@echo "ptxdist: disabling pubkey"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PUBKEY_AUTH)
endif

	@$(call touch)

DROPBEAR_MAKE_OPT	:= all scp
DROPBEAR_INSTALL_OPT	:= install inst_scp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dropbear.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dropbear)
	@$(call install_fixup, dropbear,PRIORITY,optional)
	@$(call install_fixup, dropbear,SECTION,base)
	@$(call install_fixup, dropbear,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dropbear,DESCRIPTION,missing)

ifdef PTXCONF_DROPBEAR_DROPBEAR
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/sbin/dropbear)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dropbearkey)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dropbearconvert)
endif

ifdef PTXCONF_DROPBEAR_SCP
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/scp)
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dbclient)
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_DROPBEAR_STARTSCRIPT
	@$(call install_alternative, dropbear, 0, 0, 0755, /etc/init.d/dropbear, n)
	@$(call install_replace, dropbear, /etc/init.d/dropbear, \
		@KEYDIR@, $(PTXCONF_DROPBEAR_KEY_DIR))
	@$(call install_alternative, dropbear, 0, 0, 0755, /etc/rc.once.d/dropbear, n)
	@$(call install_replace, dropbear, /etc/rc.once.d/dropbear, \
		@KEYDIR@, $(PTXCONF_DROPBEAR_KEY_DIR))

ifneq ($(call remove_quotes,$(PTXCONF_DROPBEAR_BBINIT_LINK)),)
	@$(call install_link, dropbear, \
		../init.d/dropbear, \
		/etc/rc.d/$(PTXCONF_DROPBEAR_BBINIT_LINK))
endif
endif
endif

	@$(call install_copy, dropbear, 0, 0, 0755, $(PTXCONF_DROPBEAR_KEY_DIR))

	@$(call install_finish, dropbear)

	@$(call touch)

# vim: syntax=make

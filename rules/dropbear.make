# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#                       Pengutronix e.K. <info@pengutronix.de>, Germany
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
DROPBEAR_VERSION		= 0.50
DROPBEAR			= dropbear-$(DROPBEAR_VERSION)
DROPBEAR_SUFFIX			= tar.bz2
DROPBEAR_URL			= http://matt.ucc.asn.au/dropbear/releases/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_SOURCE			= $(SRCDIR)/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_DIR			= $(BUILDDIR)/$(DROPBEAR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dropbear_get: $(STATEDIR)/dropbear.get

$(STATEDIR)/dropbear.get: $(dropbear_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DROPBEAR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DROPBEAR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dropbear_extract: $(STATEDIR)/dropbear.extract

$(STATEDIR)/dropbear.extract: $(dropbear_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DROPBEAR_DIR))
	@$(call extract, DROPBEAR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dropbear_prepare: $(STATEDIR)/dropbear.prepare

DROPBEAR_PATH	=  PATH=$(CROSS_PATH)
DROPBEAR_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DROPBEAR_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
DROPBEAR_AUTOCONF	+= --disable-nls

ifdef PTXCONF_DROPBEAR_DIS_ZLIB
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

$(STATEDIR)/dropbear.prepare: $(dropbear_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DROPBEAR_BUILDDIR))
	cd $(DROPBEAR_DIR) && \
		$(DROPBEAR_PATH) $(DROPBEAR_ENV) \
		$(DROPBEAR_DIR)/configure $(DROPBEAR_AUTOCONF)

# FIXME: rsc: write a proper autotoolization for these switches, it
# really doesn't work this way!!!

ifdef PTXCONF_DROPBEAR_DIS_X11
	@echo "ptxdist: disabling x11 forwarding"
	$(call disable_c, $(DROPBEAR_DIR)/options.h,ENABLE_X11FWD)
else
	@echo "ptxdist: enabling x11 forwarding"
	$(call enable_c, $(DROPBEAR_DIR)/options.h,ENSABLE_X11FWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_TCP
	@echo "ptxdist: enabling tcp"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_TCPFWD)
else
	@echo "ptxdist: disabling tcp"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DISABLE_TCPFWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_AGENT
	@echo "ptxdist: enabling agent"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_AGENTFWD)
else
	@echo "ptxdist: disabling agent"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DISABLE_AGENTFWD)
endif


ifdef PTXCONF_DROPBEAR_AES128
	@echo "ptxdist: enabling aes128"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_AGENTFWD)
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128_CBC)
else
	@echo "ptxdist: disabling aes128"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128_CBC)
endif

ifdef PTXCONF_DROPBEAR_BLOWFISH
	@echo "ptxdist: enabling blowfish"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH_CBC)
else
	@echo "ptxdist: disabling blowfish"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH_CBC)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH123
	@echo "ptxdist: enabling twofish123"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128_CBC)
else
	@echo "ptxdist: disabling twofish123"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128_CBC)
endif

ifdef PTXCONF_DROPBEAR_3DES
	@echo "ptxdist: enabling 3des"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES_CBC)
else
	@echo "ptxdist: disabling 3des"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES_CBC)
endif


ifdef PTXCONF_DROPBEAR_SHA1
	@echo "ptxdist: enabling sha1"
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
else
	@echo "ptxdist: disabling sha1"
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dropbear_compile: $(STATEDIR)/dropbear.compile

$(STATEDIR)/dropbear.compile: $(dropbear_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DROPBEAR_DIR) && $(DROPBEAR_ENV) $(DROPBEAR_PATH) make dropbear

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	cd $(DROPBEAR_DIR) && $(DROPBEAR_ENV) $(DROPBEAR_PATH) make dropbearkey
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	cd $(DROPBEAR_DIR) && $(DROPBEAR_ENV) $(DROPBEAR_PATH) make dropbearconvert
endif

ifdef PTXCONF_DROPBEAR_SCP
	cd $(DROPBEAR_DIR) && $(DROPBEAR_ENV) $(DROPBEAR_PATH) make scp
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dropbear_install: $(STATEDIR)/dropbear.install

$(STATEDIR)/dropbear.install: $(dropbear_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, DROPBEAR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dropbear_targetinstall: $(STATEDIR)/dropbear.targetinstall

$(STATEDIR)/dropbear.targetinstall: $(dropbear_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dropbear)
	@$(call install_fixup, dropbear,PACKAGE,dropbear)
	@$(call install_fixup, dropbear,PRIORITY,optional)
	@$(call install_fixup, dropbear,VERSION,$(DROPBEAR_VERSION))
	@$(call install_fixup, dropbear,SECTION,base)
	@$(call install_fixup, dropbear,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dropbear,DEPENDS,)
	@$(call install_fixup, dropbear,DESCRIPTION,missing)

ifdef PTXCONF_DROPBEAR_DROPBEAR
	@$(call install_copy, dropbear, 0, 0, 0755, \
		$(DROPBEAR_DIR)/dropbear, /usr/sbin/dropbear)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	@$(call install_copy, dropbear, 0, 0, 0755, \
		$(DROPBEAR_DIR)/dropbearkey, /usr/sbin/dropbearkey)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	@$(call install_copy, dropbear, 0, 0, 0755, \
		$(DROPBEAR_DIR)/dropbearconvert, /usr/sbin/dropbearconvert)
endif

ifdef PTXCONF_DROPBEAR_SCP
	@$(call install_copy, dropbear, 0, 0, 0755, \
		$(DROPBEAR_DIR)/scp, /usr/bin/scp)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_DROPBEAR
ifdef PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_DEFAULT
# install generic one
	@$(call install_copy, dropbear, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/dropbear, \
		/etc/init.d/dropbear, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_USER
# install users one
	@$(call install_copy, dropbear, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/dropbear, \
		/etc/init.d/dropbear, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK),"")
	@$(call install_link, dropbear, ../init.d/dropbear, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK))
endif
endif

	@$(call install_copy, dropbear, 0, 0, 0755, /etc/dropbear)

	@$(call install_finish, dropbear)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dropbear_clean:
	rm -rf $(STATEDIR)/dropbear.*
	rm -rf $(IMAGEDIR)/dropbear_*
	rm -rf $(DROPBEAR_DIR)

# vim: syntax=make

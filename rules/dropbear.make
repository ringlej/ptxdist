# -*-makefile-*-
# $Id: dropbear.make,v 1.6 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_DROPBEAR
PACKAGES += dropbear
endif

#
# Paths and names
#
DROPBEAR_VERSION		= 0.36
DROPBEAR			= dropbear-$(DROPBEAR_VERSION)
DROPBEAR_SUFFIX			= tar.bz2
DROPBEAR_URL			= http://matt.ucc.asn.au/dropbear/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_SOURCE			= $(SRCDIR)/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_DIR			= $(BUILDDIR)/$(DROPBEAR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dropbear_get: $(STATEDIR)/dropbear.get

dropbear_get_deps	=  $(DROPBEAR_SOURCE)

$(STATEDIR)/dropbear.get: $(dropbear_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(DROPBEAR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DROPBEAR_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dropbear_extract: $(STATEDIR)/dropbear.extract

dropbear_extract_deps	=  $(STATEDIR)/dropbear.get

$(STATEDIR)/dropbear.extract: $(dropbear_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DROPBEAR_DIR))
	@$(call extract, $(DROPBEAR_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dropbear_prepare: $(STATEDIR)/dropbear.prepare

#
# dependencies
#
dropbear_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/dropbear.extract

ifndef PTXCONF_DROPBEAR_DIS_ZLIB
dropbear_prepare_deps +=  $(STATEDIR)/zlib.install
endif

DROPBEAR_PATH	=  PATH=$(CROSS_PATH)
DROPBEAR_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DROPBEAR_AUTOCONF	=  --prefix=/usr
DROPBEAR_AUTOCONF	+= --build=$(GNU_HOST)
DROPBEAR_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
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

$(STATEDIR)/dropbear.prepare: $(dropbear_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DROPBEAR_BUILDDIR))
	cd $(DROPBEAR_DIR) && \
		$(DROPBEAR_PATH) $(DROPBEAR_ENV) \
		$(DROPBEAR_DIR)/configure $(DROPBEAR_AUTOCONF)

ifdef PTXCONF_DROPBEAR_DIS_X11
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_X11FWD)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DISABLE_X11FWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_TCP
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_TCPFWD)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DISABLE_TCPFWD)
endif

ifdef PTXCONF_DROPBEAR_DIS_AGENT
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DISABLE_AGENTFWD)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DISABLE_AGENTFWD)
endif


ifdef PTXCONF_DROPBEAR_AES128
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128_CBC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_AES128_CBC)
endif

ifdef PTXCONF_DROPBEAR_BLOWFISH
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH_CBC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_BLOWFISH_CBC)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH123
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128_CBC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_TWOFISH128_CBC)
endif

ifdef PTXCONF_DROPBEAR_3DES
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES_CBC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_3DES_CBC)
endif


ifdef PTXCONF_DROPBEAR_SHA1
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_SHA1_HMAC)
endif

ifdef PTXCONF_DROPBEAR_MD5
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_MD5_HMAC)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_MD5_HMAC)
endif


ifdef PTXCONF_DROPBEAR_RSA
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_RSA)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_RSA)
endif

ifdef PTXCONF_DROPBEAR_DSS
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_DSS)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_DSS)
endif

ifdef PTXCONF_DROPBEAR_PASSWD
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PASSWORD_AUTH)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PASSWORD_AUTH)
endif

ifdef PTXCONF_DROPBEAR_PUBKEY
	@$(call enable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PUBKEY_AUTH)
else
	@$(call disable_c, $(DROPBEAR_DIR)/options.h,DROPBEAR_PUBKEY_AUTH)
endif

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dropbear_compile: $(STATEDIR)/dropbear.compile

dropbear_compile_deps =  $(STATEDIR)/dropbear.prepare

$(STATEDIR)/dropbear.compile: $(dropbear_compile_deps)
	@$(call targetinfo, $@)
	$(DROPBEAR_PATH) make -C $(DROPBEAR_DIR) dropbear
ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	$(DROPBEAR_PATH) make -C $(DROPBEAR_DIR) dropbearkey
endif
ifdef PTXCONF_DROPBEAR_CONVERT
	$(DROPBEAR_PATH) make -C $(DROPBEAR_DIR) dropbearconvert
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dropbear_install: $(STATEDIR)/dropbear.install

$(STATEDIR)/dropbear.install: $(STATEDIR)/dropbear.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dropbear_targetinstall: $(STATEDIR)/dropbear.targetinstall

dropbear_targetinstall_deps	=  $(STATEDIR)/dropbear.compile
ifndef PTXCONF_DROPBEAR_DIS_ZLIB
dropbear_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall
endif

$(STATEDIR)/dropbear.targetinstall: $(dropbear_targetinstall_deps)
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)/usr/bin
	install -d $(ROOTDIR)/usr/sbin

ifdef PTXCONF_DROPBEAR_DROPBEAR
	install $(DROPBEAR_DIR)/dropbear \
		$(ROOTDIR)/usr/sbin/dropbear
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/dropbear
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	install $(DROPBEAR_DIR)/dropbearkey \
		$(ROOTDIR)/usr/bin/dropbearkey
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/dropbearkey
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	install $(DROPBEAR_DIR)/dropbearconvert \
		$(ROOTDIR)/usr/sbin/dropbearconvert
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/dropbearconvert
endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dropbear_clean:
	rm -rf $(STATEDIR)/dropbear.*
	rm -rf $(DROPBEAR_DIR)

# vim: syntax=make

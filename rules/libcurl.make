# -*-makefile-*-
#
# Copyright (C) 2008 by Daniel Schnell
#		2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCURL) += libcurl

#
# Paths and names
#
LIBCURL_VERSION	:= 7.38.0
LIBCURL_MD5	:= b6e3ea55bb718f2270489581efa50a8a
LIBCURL		:= curl-$(LIBCURL_VERSION)
LIBCURL_SUFFIX	:= tar.gz
LIBCURL_URL	:= http://curl.haxx.se/download/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_SOURCE	:= $(SRCDIR)/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_DIR	:= $(BUILDDIR)/$(LIBCURL)
LIBCURL_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCURL_PATH	:= PATH=$(CROSS_PATH)
LIBCURL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCURL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--with-random=/dev/urandom \
	--with-zlib=$(SYSROOT) \
	\
	--disable-ldap \
	--disable-ldaps \
	--disable-dict \
	--disable-telnet \
	--disable-manual \
	\
	--disable-ares \
	--disable-sspi \
	--disable-debug \
	--disable-verbose \
	\
	--enable-thread \
	--enable-nonblocking\
	--enable-hidden-symbols \
	\
	--without-krb4 \
	--without-spnego \
	--without-gssapi \
	--without-gnutls \
	--without-nss \
	--without-libidn \
	--without-axtls \
	--without-cyassl \
	\
	--$(call ptx/endis, PTXCONF_LIBCURL_HTTP)-http \
	--$(call ptx/endis, PTXCONF_LIBCURL_COOKIES)-cookies \
	--$(call ptx/endis, PTXCONF_LIBCURL_FTP)-ftp \
	--$(call ptx/endis, PTXCONF_LIBCURL_TFTP)-tftp \
	--$(call ptx/endis, PTXCONF_LIBCURL_FILE)-file \
	--$(call ptx/endis, PTXCONF_LIBCURL_CRYPTO_AUTH)-crypto-auth \
	--$(call ptx/endis, PTXCONF_LIBCURL_LIBSSH2)-libssh2

ifdef PTXCONF_LIBCURL_SSL
LIBCURL_AUTOCONF += --with-ssl=$(SYSROOT)
ifdef PTXCONF_LIBCURL_SSL_CABUNDLE
LIBCURL_AUTOCONF += \
	--with-ca-bundle=$(PTXCONF_LIBCURL_SSL_CABUNDLE_PATH) \
	--without-ca-path
else
ifdef PTXCONF_LIBCURL_SSL_CAPATH
LIBCURL_AUTOCONF += \
	--with-ca-path=$(PTXCONF_LIBCURL_SSL_CAPATH_PATH) \
	--without-ca-bundle
else
LIBCURL_AUTOCONF += \
	--without-ca-bundle \
	--without-ca-path
endif
endif
else
LIBCURL_AUTOCONF += --without-ssl \
	--without-ca-bundle \
	--without-ca-path
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcurl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcurl)
	@$(call install_fixup, libcurl,PRIORITY,optional)
	@$(call install_fixup, libcurl,SECTION,base)
	@$(call install_fixup, libcurl,AUTHOR,"Daniel Schnell <daniel.schnell@marel.com>")
	@$(call install_fixup, libcurl,DESCRIPTION,missing)

ifdef PTXCONF_LIBCURL_CURL
	@$(call install_copy, libcurl, 0, 0, 0755, -, /usr/bin/curl)
endif
	@$(call install_lib, libcurl, 0, 0, 0644, libcurl)

	@$(call install_finish, libcurl)

	@$(call touch)

# vim: syntax=make

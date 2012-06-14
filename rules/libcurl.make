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
LIBCURL_VERSION	:= 7.21.0
LIBCURL_MD5	:= 6dfb911a254a1b5ca8b534b98f2196aa
LIBCURL		:= curl-$(LIBCURL_VERSION)
LIBCURL_SUFFIX	:= tar.gz
LIBCURL_URL	:= http://curl.haxx.se/download/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_SOURCE	:= $(SRCDIR)/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_DIR	:= $(BUILDDIR)/$(LIBCURL)

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
	--disable-tftp \
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
	--without-ca-bundle \
	--without-ca-path \
	--without-libidn

ifdef PTXCONF_LIBCURL_HTTP
LIBCURL_AUTOCONF += --enable-http
else
LIBCURL_AUTOCONF += --disable-http
endif

ifdef PTXCONF_LIBCURL_COOKIES
LIBCURL_AUTOCONF += --enable-cookies
else
LIBCURL_AUTOCONF += --disable-cookies
endif

ifdef PTXCONF_LIBCURL_FTP
LIBCURL_AUTOCONF += --enable-ftp
else
LIBCURL_AUTOCONF += --disable-ftp
endif

ifdef PTXCONF_LIBCURL_FILE
LIBCURL_AUTOCONF += --enable-file
else
LIBCURL_AUTOCONF += --disable-file
endif

ifdef PTXCONF_LIBCURL_SSL
LIBCURL_AUTOCONF += --with-ssl=$(SYSROOT)
else
LIBCURL_AUTOCONF += --without-ssl
endif

ifdef PTXCONF_LIBCURL_CRYPTO_AUTH
LIBCURL_AUTOCONF += --enable-crypto-auth
else
LIBCURL_AUTOCONF += --disable-crypto-auth
endif

ifdef PTXCONF_LIBCURL_LIBSSH2
LIBCURL_AUTOCONF += --with-libssh2
else
LIBCURL_AUTOCONF += --without-libssh2
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

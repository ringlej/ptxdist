# -*-makefile-*-
#
# $Id$
#
# Copyright (C) 2008 by Daniel Schnell
#		2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBCURL_VERSION	:= 7.19.7
LIBCURL		:= curl-$(LIBCURL_VERSION)
LIBCURL_SUFFIX	:= tar.gz
LIBCURL_URL	:= http://curl.haxx.se/download/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_SOURCE	:= $(SRCDIR)/$(LIBCURL).$(LIBCURL_SUFFIX)
LIBCURL_DIR	:= $(BUILDDIR)/$(LIBCURL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCURL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCURL)

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
	--without-libssh2 \
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

ifdef PTXCONF_LIBCURL_IPV6
LIBCURL_AUTOCONF += --enable-ipv6
else
LIBCURL_AUTOCONF += --disable-ipv6
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcurl.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libcurl)
	@$(call install_fixup, libcurl,PACKAGE,libcurl)
	@$(call install_fixup, libcurl,PRIORITY,optional)
	@$(call install_fixup, libcurl,VERSION,$(LIBCURL_VERSION))
	@$(call install_fixup, libcurl,SECTION,base)
	@$(call install_fixup, libcurl,AUTHOR,"Daniel Schnell <daniel.schnell@marel.com>")
	@$(call install_fixup, libcurl,DEPENDS,)
	@$(call install_fixup, libcurl,DESCRIPTION,missing)

ifdef PTXCONF_LIBCURL_CURL
	@$(call install_copy, libcurl, 0, 0, 0755, -, /usr/bin/curl)
endif

	@$(call install_copy, libcurl, 0, 0, 0644, -, /usr/lib/libcurl.so.4.1.1)
	@$(call install_link, libcurl, libcurl.so.4.1.1, /usr/lib/libcurl.so.4)
	@$(call install_link, libcurl, libcurl.so.4, /usr/lib/libcurl.so)

	@$(call install_finish, libcurl)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcurl_clean:
	rm -rf $(STATEDIR)/libcurl.*
	rm -rf $(PKGDIR)/libcurl_*
	rm -rf $(LIBCURL_DIR)

# vim: syntax=make

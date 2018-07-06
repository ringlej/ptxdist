# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBCURL) += host-libcurl

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBCURL_CONF_TOOL	:= autoconf
HOST_LIBCURL_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--with-random=/dev/urandom \
	--without-zlib \
	\
	--disable-ldap \
	--disable-ldaps \
	--disable-rtsp \
	--disable-dict \
	--disable-telnet \
	--disable-pop3 \
	--disable-imap \
	--disable-smb \
	--disable-smtp \
	--disable-gopher \
	--disable-manual \
	\
	--disable-sspi \
	--disable-ntlm-wb \
	--disable-debug \
	--disable-verbose \
	\
	--enable-thread \
	--enable-nonblocking\
	--enable-hidden-symbols \
	--enable-proxy \
	\
	--without-krb4 \
	--without-spnego \
	--without-gssapi \
	--without-winssl \
	--without-darwinssl \
	--without-gnutls \
	--without-nss \
	--without-winidn \
	--without-libidn \
	--without-axtls \
	--without-polarssl \
	--without-cyassl \
	--without-librtmp \
	\
	--disable-ares \
	--disable-http \
	--disable-nghttp2 \
	--disable-cookies \
	--disable-ftp \
	--disable-tftp \
	--disable-file \
	--disable-crypto-auth \
	--disable-libssh2 \
	--without-ssl

# vim: syntax=make

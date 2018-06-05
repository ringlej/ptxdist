# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUTLS) += gnutls

#
# Paths and names
#
GNUTLS_VERSION	:= 3.6.0
GNUTLS_MD5	:= 296f8d61333851b9326bd18484e6135e
GNUTLS		:= gnutls-$(GNUTLS_VERSION)
GNUTLS_SUFFIX	:= tar.xz
GNUTLS_URL	:= ftp://ftp.gnutls.org/gcrypt/gnutls/v$(basename $(GNUTLS_VERSION))/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_SOURCE	:= $(SRCDIR)/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_DIR	:= $(BUILDDIR)/$(GNUTLS)
GNUTLS_LICENSE	:= LGPL-3.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GNUTLS_CONF_TOOL	:= autoconf
GNUTLS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-code-coverage \
	--disable-doc \
	--disable-manpages \
	--disable-tools \
	--enable-cxx \
	--enable-hardware-acceleration \
	--enable-padlock \
	--enable-sha1-support \
	--disable-ssl3-support \
	--enable-ssl2-support \
	--enable-dtls-srtp-support \
	--enable-alpn-support \
	--enable-heartbeat-support \
	--enable-srp-authentication \
	--enable-psk-authentication \
	--enable-anon-authentication \
	--enable-dhe \
	--enable-ecdhe \
	--disable-cryptodev \
	--enable-ocsp \
	--enable-session-tickets \
	--$(call ptx/endis, PTXCONF_GNUTLS_OPENSSL)-openssl-compatibility \
	--disable-tests \
	--disable-fuzzer-target \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-nls \
	--disable-rpath \
	--disable-seccomp-tests \
	--disable-valgrind-tests \
	--disable-full-test-suite \
	--disable-gcc-warnings \
	--disable-static \
	--enable-shared \
	--disable-fips140-mode \
	--enable-non-suiteb-curves \
	--disable-libdane \
	--enable-local-libopts \
	--disable-libopts-install \
	--enable-optional-args \
	--disable-guile \
	--with-nettle-mini \
	--without-included-libtasn1 \
	--with-included-unistring \
	--without-fips140-key \
	--without-idn \
	--without-p11-kit \
	--without-tpm \
	--without-trousers-lib \
	--without-libregex \
	--with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnutls.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnutls)
	@$(call install_fixup, gnutls,PRIORITY,optional)
	@$(call install_fixup, gnutls,SECTION,base)
	@$(call install_fixup, gnutls,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, gnutls,DESCRIPTION,missing)

	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls)
ifdef PTXCONF_GNUTLS_CXX
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutlsxx)
endif

ifdef PTXCONF_GNUTLS_OPENSSL
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls-openssl)
endif

	@$(call install_finish, gnutls)

	@$(call touch)

# vim: syntax=make

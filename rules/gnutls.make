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
GNUTLS_VERSION	:= 3.3.24
GNUTLS_MD5	:= 4057aa38fcceda709b73f4179ca0a21a
GNUTLS		:= gnutls-$(GNUTLS_VERSION)
GNUTLS_SUFFIX	:= tar.xz
GNUTLS_URL	:= ftp://ftp.gnutls.org/gcrypt/gnutls/v$(basename $(GNUTLS_VERSION))/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_SOURCE	:= $(SRCDIR)/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_DIR	:= $(BUILDDIR)/$(GNUTLS)
GNUTLS_LICENSE	:= LGPL-3.0+

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
	--enable-cxx \
	--enable-hardware-acceleration \
	--enable-padlock \
	--enable-dtls-srtp-support \
	--enable-alpn-support \
	--enable-rsa-export \
	--enable-heartbeat-support \
	--enable-srp-authentication \
	--enable-psk-authentication \
	--enable-anon-authentication \
	--enable-dhe \
	--enable-ecdhe \
	--enable-openpgp-authentication \
	--enable-ocsp \
	--enable-session-tickets \
	--$(call ptx/endis, PTXCONF_GNUTLS_OPENSSL)-openssl-compatibility \
	--disable-doc \
	--disable-tests \
	--disable-gtk-doc \
	--disable-nls \
	--disable-rpath \
	--disable-valgrind-tests \
	--disable-gcc-warnings \
	--enable-shared \
	--disable-static \
	--disable-self-checks \
	--disable-fips140-mode \
	--enable-non-suiteb-curves \
	--disable-libdane \
	--enable-local-libopts \
	--disable-libopts-install \
	--disable-guile \
	--disable-crywrap \
	--without-p11-kit \
	--without-tpm \
	--without-librt-prefix \
	--without-libregex \
	--with-zlib \
	--without-libz-prefix \
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
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutlsxx)

ifdef PTXCONF_GNUTLS_OPENSSL
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls-openssl)
endif

	@$(call install_finish, gnutls)

	@$(call touch)

# vim: syntax=make

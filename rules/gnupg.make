# -*-makefile-*-
#
# Copyright (C) 2005 by Jiri Nesladek
# Copyright (C) 2018 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUPG) += gnupg

#
# Paths and names
#
GNUPG_VERSION	:= 2.2.9
GNUPG_MD5	:= 52c895a81f514a65e08923736c38654a
GNUPG		:= gnupg-$(GNUPG_VERSION)
GNUPG_SUFFIX	:= tar.bz2
GNUPG_URL	:= ftp://ftp.gnupg.org/gcrypt/gnupg/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_SOURCE	:= $(SRCDIR)/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_DIR	:= $(BUILDDIR)/$(GNUPG)
GNUPG_LICENSE	:= GPL-3.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GNUPG_CONF_TOOL := autoconf
GNUPG_CONF_OPT := $(CROSS_AUTOCONF_USR) \
	--enable-gpg \
	--disable-gpgsm \
	--disable-scdaemon \
	--disable-g13 \
	--disable-dirmngr \
	--disable-doc \
	--disable-symcryptrun \
	--disable-gpgtar \
	--disable-wks-tools \
	--disable-gpg-is-gpg2 \
	--$(call ptx/endis, PTXCONF_GLOBAL_SELINUX)-selinux-support \
	--disable-large-secmem \
	--enable-trust-models \
	--disable-tofu \
	--disable-libdns \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_RSA)-gpg-rsa \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_ECDH)-gpg-ecdh \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_ECDSA)-gpg-ecdsa \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_EDDSA)-gpg-eddsa \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_IDEA)-gpg-idea \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_CAST5)-gpg-cast5 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_BLOWFISH)-gpg-blowfish \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_AES)-gpg-aes128 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_AES)-gpg-aes192 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_AES)-gpg-aes256 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_TWOFISH)-gpg-twofish \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_CAMELLIA)-gpg-camellia128 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_CAMELLIA)-gpg-camellia192 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_CAMELLIA)-gpg-camellia256 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_MD5)-gpg-md5 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_RMD160)-gpg-rmd160 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_SHA)-gpg-sha224 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_SHA)-gpg-sha384 \
	--$(call ptx/endis, PTXCONF_GNUPG_GPG_SHA)-gpg-sha512 \
	--disable-zip \
	--disable-bzip2 \
	--disable-exec \
	--disable-photo-viewers \
	--disable-card-support \
	--disable-ccid-driver \
	--disable-dirmngr-auto-start \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-sqlite \
	--disable-npth-debug \
	--disable-ntbtls \
	--disable-gnutls \
	--disable-ldap \
	--disable-rpath \
	--disable-nls \
	--enable-endian-check \
	--disable-regex \
	--enable-optimization \
	--disable-werror \
	--disable-all-tests \
	--disable-run-gnupg-user-socket \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)"

ifndef PTXCONF_ICONV
GNUPG_CONF_OPT += --without-libiconv-prefix
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnupg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnupg)
	@$(call install_fixup, gnupg,PRIORITY,optional)
	@$(call install_fixup, gnupg,SECTION,base)
	@$(call install_fixup, gnupg,AUTHOR,"Jiri Nesladek <nesladek@2n.cz>")
	@$(call install_fixup, gnupg,DESCRIPTION,missing)

ifdef PTXCONF_GNUPG_GPG
	@$(call install_copy, gnupg, 0, 0, 0755, -, /usr/bin/gpg)
	@$(call install_link, gnupg, gpg, /usr/bin/gpg2)
endif
ifdef PTXCONF_GNUPG_GPGV
	@$(call install_copy, gnupg, 0, 0, 0755, -, /usr/bin/gpgv)
	@$(call install_link, gnupg, gpgv, /usr/bin/gpgv2)
endif

	@$(call install_finish, gnupg)

	@$(call touch)

# vim: syntax=make

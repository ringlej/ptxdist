# -*-makefile-*-
#
# Copyright (C) 2005 by Jiri Nesladek
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
GNUPG_VERSION	:= 1.4.10
GNUPG		:= gnupg-$(GNUPG_VERSION)
GNUPG_SUFFIX	:= tar.bz2
GNUPG_URL	:= ftp://ftp.gnupg.org/gcrypt/gnupg/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_SOURCE	:= $(SRCDIR)/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_DIR	:= $(BUILDDIR)/$(GNUPG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GNUPG_SOURCE):
	@$(call targetinfo)
	@$(call get, GNUPG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GNUPG_PATH	= PATH=$(CROSS_PATH)
GNUPG_ENV 	= $(CROSS_ENV)

#
# autoconf
#
GNUPG_AUTOCONF = $(CROSS_AUTOCONF_USR) \
	--disable-asm \
	--disable-card-support \
	--disable-exec \
	--disable-idea \
	--enable-cast5 \
	--enable-blowfish \
	--enable-aes \
	--enable-twofish \
	--enable-sha256 \
	--enable-sha512 \
	--disable-exec \
	--disable-photo-viewers \
	--disable-keyserver-helpers \
	--disable-ldap \
	--disable-hkp \
	--disable-http \
	--disable-finger \
	--disable-ftp \
	--disable-keyserver-path \
	--disable-largefile \
	--disable-dns-srv \
	--disable-nls \
	--disable-rpath \
	--disable-regex

ifdef PTXCONF_ICONV
GNUPG_AUTOCONF += --enable-gnupg-iconv
else
GNUPG_AUTOCONF += --disable-gnupg-iconv
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnupg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnupg)
	@$(call install_fixup, gnupg,PACKAGE,gnupg)
	@$(call install_fixup, gnupg,PRIORITY,optional)
	@$(call install_fixup, gnupg,VERSION,$(GNUPG_VERSION))
	@$(call install_fixup, gnupg,SECTION,base)
	@$(call install_fixup, gnupg,AUTHOR,"Jiri Nesladek <nesladek@2n.cz>")
	@$(call install_fixup, gnupg,DEPENDS,)
	@$(call install_fixup, gnupg,DESCRIPTION,missing)

	@$(call install_copy, gnupg, 0, 0, 0755, -, /usr/bin/gpg)

	@$(call install_finish, gnupg)

	@$(call touch)

# vim: syntax=make

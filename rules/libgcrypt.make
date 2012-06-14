# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGCRYPT) += libgcrypt

#
# Paths and names
#
LIBGCRYPT_VERSION	:= 1.4.5
LIBGCRYPT_MD5		:= cc2017ad09b4543f8b3b5e9a53cfd89d
LIBGCRYPT		:= libgcrypt-$(LIBGCRYPT_VERSION)
LIBGCRYPT_SUFFIX	:= tar.bz2
LIBGCRYPT_URL		:= ftp://ftp.gnupg.org/gcrypt/libgcrypt/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_SOURCE	:= $(SRCDIR)/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_DIR		:= $(BUILDDIR)/$(LIBGCRYPT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGCRYPT_PATH	:= PATH=$(CROSS_PATH)
LIBGCRYPT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGCRYPT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-optimization \
	--disable-random-daemon \
	--disable-asm
#
# ASM needs MPI, which we don't have
#
# using --enable-asm will result in lost of;
# ../src/.libs/libgcrypt.so: undefined reference to `_gcry_mpih_add_n'
# ../src/.libs/libgcrypt.so: undefined reference to `_gcry_mpih_submul_1'
#

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgcrypt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgcrypt)
	@$(call install_fixup, libgcrypt,PRIORITY,optional)
	@$(call install_fixup, libgcrypt,SECTION,base)
	@$(call install_fixup, libgcrypt,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgcrypt,DESCRIPTION,missing)

	@$(call install_lib, libgcrypt, 0, 0, 0644, libgcrypt)

	@$(call install_finish, libgcrypt)

	@$(call touch)

# vim: syntax=make

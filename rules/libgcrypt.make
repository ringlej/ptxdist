# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010, 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBGCRYPT_VERSION	:= 1.5.3
LIBGCRYPT_MD5		:= 993159b2924ae7b0e4eaff0743c2db35
LIBGCRYPT		:= libgcrypt-$(LIBGCRYPT_VERSION)
LIBGCRYPT_SUFFIX	:= tar.bz2
LIBGCRYPT_URL		:= http://artfiles.org/gnupg.org/libgcrypt/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX) ftp://ftp.gnupg.org/gcrypt/libgcrypt/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_SOURCE	:= $(SRCDIR)/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_DIR		:= $(BUILDDIR)/$(LIBGCRYPT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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

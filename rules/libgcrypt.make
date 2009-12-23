# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
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
LIBGCRYPT		:= libgcrypt-$(LIBGCRYPT_VERSION)
LIBGCRYPT_SUFFIX	:= tar.bz2
LIBGCRYPT_URL		:= ftp://ftp.gnupg.org/gcrypt/libgcrypt/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_SOURCE	:= $(SRCDIR)/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_DIR		:= $(BUILDDIR)/$(LIBGCRYPT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGCRYPT_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGCRYPT)

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
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgcrypt.install:
	@$(call targetinfo)
	@$(call install, LIBGCRYPT)

	cp $(LIBGCRYPT_DIR)/src/libgcrypt-config $(PTXCONF_SYSROOT_CROSS)/bin/libgcrypt-config
	chmod a+x $(PTXCONF_SYSROOT_CROSS)/bin/libgcrypt-config

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgcrypt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgcrypt)
	@$(call install_fixup, libgcrypt,PACKAGE,libgcrypt)
	@$(call install_fixup, libgcrypt,PRIORITY,optional)
	@$(call install_fixup, libgcrypt,VERSION,$(LIBGCRYPT_VERSION))
	@$(call install_fixup, libgcrypt,SECTION,base)
	@$(call install_fixup, libgcrypt,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgcrypt,DEPENDS,)
	@$(call install_fixup, libgcrypt,DESCRIPTION,missing)

	@$(call install_copy, libgcrypt, 0, 0, 0644, -, \
		/usr/lib/libgcrypt.so.11.5.3)
	@$(call install_link, libgcrypt, libgcrypt.so.11.5.3, /usr/lib/libgcrypt.so.11)
	@$(call install_link, libgcrypt, libgcrypt.so.11.5.3, /usr/lib/libgcrypt.so)

	@$(call install_finish, libgcrypt)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgcrypt_clean:
	rm -rf $(STATEDIR)/libgcrypt.*
	rm -rf $(PKGDIR)/libgcrypt_*
	rm -rf $(LIBGCRYPT_DIR)

# vim: syntax=make

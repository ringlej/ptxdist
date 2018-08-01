# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CRYPTSETUP) += cryptsetup

#
# Paths and names
#
CRYPTSETUP_VERSION	:= 2.0.3
CRYPTSETUP_MD5		:= 9161132f69e97018b39ab592d7831f61
CRYPTSETUP		:= cryptsetup-$(CRYPTSETUP_VERSION)
CRYPTSETUP_SUFFIX	:= tar.gz
CRYPTSETUP_URL		:= https://www.kernel.org/pub/linux/utils/cryptsetup/v$(basename $(CRYPTSETUP_VERSION))/$(CRYPTSETUP).$(CRYPTSETUP_SUFFIX)
CRYPTSETUP_SOURCE	:= $(SRCDIR)/$(CRYPTSETUP).$(CRYPTSETUP_SUFFIX)
CRYPTSETUP_DIR		:= $(BUILDDIR)/$(CRYPTSETUP)
CRYPTSETUP_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CRYPTSETUP_CONF_TOOL	:= autoconf
CRYPTSETUP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-keyring \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--disable-fips \
	--disable-pwquality \
	--disable-static-cryptsetup \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPTSETUP)-cryptsetup \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_VERITYSETUP)-veritysetup \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPTSETUP)-cryptsetup-reencrypt \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_INTEGRITYSETUP)-integritysetup \
	--disable-selinux \
	--enable-udev \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPT_BACKEND_KERNEL)-kernel_crypto \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPT_BACKEND_GCRYPT)-gcrypt-pbkdf2 \
	--enable-internal-argon2 \
	--disable-libargon2 \
	--enable-dev-random \
	--disable-python \
	--with-crypto_backend=$(PTXCONF_CRYPTSETUP_CRYPT_BACKEND) \
	--with-luks2-lock-path=/run/cryptsetup

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cryptsetup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cryptsetup)
	@$(call install_fixup, cryptsetup,PRIORITY,optional)
	@$(call install_fixup, cryptsetup,SECTION,base)
	@$(call install_fixup, cryptsetup,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, cryptsetup,DESCRIPTION,missing)

	@$(call install_lib, cryptsetup, 0, 0, 0644, libcryptsetup)

ifdef PTXCONF_CRYPTSETUP_CRYPTSETUP
	@$(call install_copy, cryptsetup, 0, 0, 0755, -, /usr/sbin/cryptsetup)
endif
ifdef PTXCONF_CRYPTSETUP_INTEGRITYSETUP
	@$(call install_copy, cryptsetup, 0, 0, 0755, -, /usr/sbin/integritysetup)
endif
ifdef PTXCONF_CRYPTSETUP_VERITYSETUP
	@$(call install_copy, cryptsetup, 0, 0, 0755, -, /usr/sbin/veritysetup)
endif

	@$(call install_finish, cryptsetup)

	@$(call touch)

# vim: syntax=make

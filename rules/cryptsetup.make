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
CRYPTSETUP_VERSION	:= 1.7.5
CRYPTSETUP_MD5		:= dde798a883b06a2903379dcd593480e1
CRYPTSETUP		:= cryptsetup-$(CRYPTSETUP_VERSION)
CRYPTSETUP_SUFFIX	:= tar.gz
CRYPTSETUP_URL		:= https://www.kernel.org/pub/linux/utils/cryptsetup/v1.7//$(CRYPTSETUP).$(CRYPTSETUP_SUFFIX)
CRYPTSETUP_SOURCE	:= $(SRCDIR)/$(CRYPTSETUP).$(CRYPTSETUP_SUFFIX)
CRYPTSETUP_DIR		:= $(BUILDDIR)/$(CRYPTSETUP)
CRYPTSETUP_LICENSE	:= GPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CRYPTSETUP_CONF_TOOL	:= autoconf
CRYPTSETUP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--disable-pwquality \
	--disable-static-cryptsetup \
	--enable-veritysetup \
	--enable-cryptsetup-reencrypt \
	--disable-selinux \
	--enable-udev \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPT_BACKEND_KERNEL)-kernel_crypto \
	--$(call ptx/endis, PTXCONF_CRYPTSETUP_CRYPT_BACKEND_GCRYPT)-gcrypt-pbkdf2 \
	--enable-dev-random \
	--disable-python \
	--with-crypto_backend=$(PTXCONF_CRYPTSETUP_CRYPT_BACKEND)

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

ifdef PTXCONF_CRYPTSETUP_VERITYSETUP
	@$(call install_copy, cryptsetup, 0, 0, 0755, -, /usr/sbin/veritysetup)
endif
ifdef PTXCONF_CRYPTSETUP_CRYPTSETUP
	@$(call install_copy, cryptsetup, 0, 0, 0755, -, /usr/sbin/cryptsetup)
endif

	@$(call install_finish, cryptsetup)

	@$(call touch)

# vim: syntax=make

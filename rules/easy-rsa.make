# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EASY_RSA) += easy-rsa

#
# Paths and names
#
EASY_RSA_VERSION	:= 2.2.2
EASY_RSA_MD5		:= 040238338980617bc9c2df4274349593
EASY_RSA		:= easy-rsa-$(EASY_RSA_VERSION)
EASY_RSA_SUFFIX		:= tar.gz
EASY_RSA_TARBALL	:= $(EASY_RSA_VERSION).$(EASY_RSA_SUFFIX)
EASY_RSA_URL		:= https://github.com/OpenVPN/easy-rsa/archive/$(EASY_RSA_TARBALL)
EASY_RSA_SOURCE		:= $(SRCDIR)/$(EASY_RSA).$(EASY_RSA_SUFFIX)
EASY_RSA_DIR		:= $(BUILDDIR)/$(EASY_RSA)
EASY_RSA_LICENSE	:= GPL-2.0-only

EASY_RSA_INSTALL_SCRIPTS := \
	build-ca build-dh build-inter build-key build-key-pass build-key-pkcs12 \
	build-key-server build-req build-req-pass clean-all inherit-inter \
	list-crl pkitool revoke-full sign-req whichopensslcnf

EASY_RSA_INSTALL_FILES := \
	openssl-1.0.0.cnf vars

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/easy-rsa.targetinstall:
	@$(call targetinfo)

	@$(call install_init, easy-rsa)
	@$(call install_fixup, easy-rsa,PRIORITY,optional)
	@$(call install_fixup, easy-rsa,SECTION,base)
	@$(call install_fixup, easy-rsa,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, easy-rsa,DESCRIPTION,missing)

	@$(foreach script,$(EASY_RSA_INSTALL_SCRIPTS), \
		$(call install_copy, easy-rsa, 0, 0, 0755, -, \
		/usr/share/easy-rsa/$(script));)

	@$(foreach file,$(EASY_RSA_INSTALL_FILES), \
		$(call install_copy, easy-rsa, 0, 0, 0644, -, \
		/usr/share/easy-rsa/$(file));)

	@$(call install_finish, easy-rsa)

	@$(call touch)

# vim: syntax=make

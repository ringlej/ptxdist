# -*-makefile-*-
#
# Copyright (C) 2014 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBZIP) += libzip

#
# Paths and names
#
LIBZIP_VERSION	:= 1.5.1
LIBZIP_MD5	:= ca72a4c93bef1595e5ff45eaf534d4da
LIBZIP		:= libzip-$(LIBZIP_VERSION)
LIBZIP_SUFFIX	:= tar.gz
LIBZIP_URL	:= http://www.nih.at/libzip/$(LIBZIP).$(LIBZIP_SUFFIX)
LIBZIP_SOURCE	:= $(SRCDIR)/$(LIBZIP).$(LIBZIP_SUFFIX)
LIBZIP_DIR	:= $(BUILDDIR)/$(LIBZIP)
LIBZIP_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBZIP_CONF_TOOL	:= cmake
LIBZIP_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DENABLE_GNUTLS=OFF \
	-DENABLE_OPENSSL=OFF \
	-DENABLE_COMMONCRYPTO=OFF \
	-DBZIP2_LIBRARIES:STRING=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libzip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libzip)
	@$(call install_fixup, libzip, PRIORITY, optional)
	@$(call install_fixup, libzip, SECTION, base)
	@$(call install_fixup, libzip, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, libzip, DESCRIPTION, missing)

	@$(call install_lib, libzip, 0, 0, 0644, libzip)

	@$(call install_finish, libzip)

	@$(call touch)

# vim: syntax=make

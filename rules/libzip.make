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
LIBZIP_VERSION	:= 1.1.2
LIBZIP_MD5	:= 0820a1ae5733518f5d6e289cb642c08e
LIBZIP		:= libzip-$(LIBZIP_VERSION)
LIBZIP_SUFFIX	:= tar.gz
LIBZIP_URL	:= http://www.nih.at/libzip/$(LIBZIP).$(LIBZIP_SUFFIX)
LIBZIP_SOURCE	:= $(SRCDIR)/$(LIBZIP).$(LIBZIP_SUFFIX)
LIBZIP_DIR	:= $(BUILDDIR)/$(LIBZIP)
LIBZIP_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBZIP_CONF_TOOL	:= autoconf
LIBZIP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libzip.install.pack:
	@$(call targetinfo)
	@$(call world/install.pack, LIBZIP)
	@sed -i -e 's,libincludedir=/usr/lib,libincludedir=$${libdir},g' \
		'$(LIBZIP_PKGDIR)/usr/lib/pkgconfig/libzip.pc'
	@$(call touch)

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

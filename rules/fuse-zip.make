# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FUSE_ZIP) += fuse-zip

#
# Paths and names
#
FUSE_ZIP_VERSION	:= 0.4.2
FUSE_ZIP_MD5	:= 673a351e4116d5576a92d62d21208afe
FUSE_ZIP	:= fuse-zip-$(FUSE_ZIP_VERSION)
FUSE_ZIP_SUFFIX	:= tar.gz
FUSE_ZIP_URL	:= https://bitbucket.org/agalanin/fuse-zip/downloads/$(FUSE_ZIP).$(FUSE_ZIP_SUFFIX)
FUSE_ZIP_SOURCE	:= $(SRCDIR)/$(FUSE_ZIP).$(FUSE_ZIP_SUFFIX)
FUSE_ZIP_DIR	:= $(BUILDDIR)/$(FUSE_ZIP)
FUSE_ZIP_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FUSE_ZIP_CONF_TOOL	:= NO
FUSE_ZIP_MAKE_ENV	:= $(CROSS_ENV)
FUSE_ZIP_INSTALL_OPT	:= 'prefix=/usr' install


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fuse-zip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fuse-zip)
	@$(call install_fixup, fuse-zip, PRIORITY,optional)
	@$(call install_fixup, fuse-zip, SECTION,base)
	@$(call install_fixup, fuse-zip, AUTHOR,"Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, fuse-zip, DESCRIPTION,missing)

	@$(call install_copy, fuse-zip, 0, 0, 0755, -, /usr/bin/fuse-zip)

	@$(call install_finish, fuse-zip)

	@$(call touch)

# vim: syntax=make

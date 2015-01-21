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
PACKAGES-$(PTXCONF_FUSE_ZIP) += fuse-zip

#
# Paths and names
#
FUSE_ZIP_VERSION	:= 0.4.0
FUSE_ZIP_MD5	:= da2d85c5b28ccd153c928f8030e3f729
FUSE_ZIP		:= fuse-zip-$(FUSE_ZIP_VERSION)
FUSE_ZIP_SUFFIX	:= tar.gz
FUSE_ZIP_URL	:= http://fuse-zip.googlecode.com/files/$(FUSE_ZIP).$(FUSE_ZIP_SUFFIX)
FUSE_ZIP_SOURCE	:= $(SRCDIR)/$(FUSE_ZIP).$(FUSE_ZIP_SUFFIX)
FUSE_ZIP_DIR	:= $(BUILDDIR)/$(FUSE_ZIP)
FUSE_ZIP_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FUSE_ZIP_CONF_TOOL	:= NO
FUSE_ZIP_MAKE_ENV	:= $(CROSS_ENV)

# Makefile ignores DESTDIR
FUSE_ZIP_INSTALL_OPT	:= 'INSTALLPREFIX=$(FUSE_ZIP_PKGDIR)/usr' install


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

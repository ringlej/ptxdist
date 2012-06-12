# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_FS) += xorg-lib-fs

#
# Paths and names
#
XORG_LIB_FS_VERSION	:= 1.0.4
XORG_LIB_FS_MD5		:= 645f83160cf7b562734e2038045106d1
XORG_LIB_FS		:= libFS-$(XORG_LIB_FS_VERSION)
XORG_LIB_FS_SUFFIX	:= tar.bz2
XORG_LIB_FS_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX))
XORG_LIB_FS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX)
XORG_LIB_FS_DIR		:= $(BUILDDIR)/$(XORG_LIB_FS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_FS_CONF_TOOL	:= autoconf
XORG_LIB_FS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-fs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-fs)
	@$(call install_fixup, xorg-lib-fs,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fs,SECTION,base)
	@$(call install_fixup, xorg-lib-fs,AUTHOR,"Erwin rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fs,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-fs, 0, 0, 0644, libFS)

	@$(call install_finish, xorg-lib-fs)

	@$(call touch)

# vim: syntax=make

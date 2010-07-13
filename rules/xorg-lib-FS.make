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
XORG_LIB_FS_VERSION	:= 1.0.2
XORG_LIB_FS		:= libFS-$(XORG_LIB_FS_VERSION)
XORG_LIB_FS_SUFFIX	:= tar.bz2
XORG_LIB_FS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX)
XORG_LIB_FS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX)
XORG_LIB_FS_DIR		:= $(BUILDDIR)/$(XORG_LIB_FS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_FS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_FS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_FS_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_FS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_FS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-fs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-fs)
	@$(call install_fixup, xorg-lib-fs,PACKAGE,xorg-lib-fs)
	@$(call install_fixup, xorg-lib-fs,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fs,VERSION,$(XORG_LIB_FS_VERSION))
	@$(call install_fixup, xorg-lib-fs,SECTION,base)
	@$(call install_fixup, xorg-lib-fs,AUTHOR,"Erwin rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fs,DEPENDS,)
	@$(call install_fixup, xorg-lib-fs,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-fs, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libFS.so.6.0.0)

	@$(call install_link, xorg-lib-fs, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so.6)

	@$(call install_link, xorg-lib-fs, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so)

	@$(call install_finish, xorg-lib-fs)

	@$(call touch)

# vim: syntax=make

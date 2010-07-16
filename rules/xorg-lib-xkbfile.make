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
PACKAGES-$(PTXCONF_XORG_LIB_XKBFILE) += xorg-lib-xkbfile

#
# Paths and names
#
XORG_LIB_XKBFILE_VERSION	:= 1.0.6
XORG_LIB_XKBFILE		:= libxkbfile-$(XORG_LIB_XKBFILE_VERSION)
XORG_LIB_XKBFILE_SUFFIX		:= tar.bz2
XORG_LIB_XKBFILE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX)
XORG_LIB_XKBFILE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX)
XORG_LIB_XKBFILE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XKBFILE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XKBFILE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XKBFILE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XKBFILE_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XKBFILE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XKBFILE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xkbfile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xkbfile)
	@$(call install_fixup, xorg-lib-xkbfile,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xkbfile,SECTION,base)
	@$(call install_fixup, xorg-lib-xkbfile,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xkbfile,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xkbfile, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libxkbfile.so.1.0.2)

	@$(call install_link, xorg-lib-xkbfile, \
		libxkbfile.so.1.0.2, \
		$(XORG_LIBDIR)/libxkbfile.so.1)

	@$(call install_link, xorg-lib-xkbfile, \
		libxkbfile.so.1.0.2, \
		$(XORG_LIBDIR)/libxkbfile.so)

	@$(call install_finish, xorg-lib-xkbfile)

	@$(call touch)

# vim: syntax=make

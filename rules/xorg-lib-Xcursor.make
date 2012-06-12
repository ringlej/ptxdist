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
PACKAGES-$(PTXCONF_XORG_LIB_XCURSOR) += xorg-lib-xcursor

#
# Paths and names
#
XORG_LIB_XCURSOR_VERSION	:= 1.1.13
XORG_LIB_XCURSOR_MD5		:= 52efa81b7f26c8eda13510a2fba98eea
XORG_LIB_XCURSOR		:= libXcursor-$(XORG_LIB_XCURSOR_VERSION)
XORG_LIB_XCURSOR_SUFFIX		:= tar.bz2
XORG_LIB_XCURSOR_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX))
XORG_LIB_XCURSOR_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCURSOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XCURSOR_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xcursor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-xcursor,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xcursor,SECTION,base)
	@$(call install_fixup, xorg-lib-xcursor,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xcursor,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xcursor, 0, 0, 0644, libXcursor)

	@$(call install_finish, xorg-lib-xcursor)

	@$(call touch)

# vim: syntax=make

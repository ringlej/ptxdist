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
PACKAGES-$(PTXCONF_XORG_LIB_XFT) += xorg-lib-xft

#
# Paths and names
#
XORG_LIB_XFT_VERSION	:= 2.3.2
XORG_LIB_XFT_MD5	:= 331b3a2a3a1a78b5b44cfbd43f86fcfe
XORG_LIB_XFT		:= libXft-$(XORG_LIB_XFT_VERSION)
XORG_LIB_XFT_SUFFIX	:= tar.bz2
XORG_LIB_XFT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX))
XORG_LIB_XFT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX)
XORG_LIB_XFT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XFT_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xft.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xft)
	@$(call install_fixup, xorg-lib-xft,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xft,SECTION,base)
	@$(call install_fixup, xorg-lib-xft,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xft,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xft, 0, 0, 0644, libXft)

	@$(call install_finish, xorg-lib-xft)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XP) += xorg-lib-xp

#
# Paths and names
#
XORG_LIB_XP_VERSION	:= 1.0.1
XORG_LIB_XP_MD5		:= 7ae1d63748e79086bd51a633da1ff1a9
XORG_LIB_XP		:= libXp-$(XORG_LIB_XP_VERSION)
XORG_LIB_XP_SUFFIX	:= tar.bz2
XORG_LIB_XP_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX))
XORG_LIB_XP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX)
XORG_LIB_XP_DIR		:= $(BUILDDIR)/$(XORG_LIB_XP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XP_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xp)
	@$(call install_fixup, xorg-lib-xp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xp,SECTION,base)
	@$(call install_fixup, xorg-lib-xp,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xp,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xp, 0, 0, 0644, libXp)

	@$(call install_finish, xorg-lib-xp)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XINERAMA) += xorg-lib-xinerama

#
# Paths and names
#
XORG_LIB_XINERAMA_VERSION	:= 1.1.2
XORG_LIB_XINERAMA_MD5		:= cb45d6672c93a608f003b6404f1dd462
XORG_LIB_XINERAMA		:= libXinerama-$(XORG_LIB_XINERAMA_VERSION)
XORG_LIB_XINERAMA_SUFFIX	:= tar.bz2
XORG_LIB_XINERAMA_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX))
XORG_LIB_XINERAMA_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX)
XORG_LIB_XINERAMA_DIR		:= $(BUILDDIR)/$(XORG_LIB_XINERAMA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XINERAMA_CONF_TOOL	:= autoconf
XORG_LIB_XINERAMA_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xinerama.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xinerama)
	@$(call install_fixup, xorg-lib-xinerama,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xinerama,SECTION,base)
	@$(call install_fixup, xorg-lib-xinerama,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xinerama,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xinerama, 0, 0, 0644, libXinerama)

	@$(call install_finish, xorg-lib-xinerama)

	@$(call touch)

# vim: syntax=make

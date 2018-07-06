# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XI) += xorg-lib-xi

#
# Paths and names
#
XORG_LIB_XI_VERSION	:= 1.7.4
XORG_LIB_XI_MD5		:= 9c4a69c34b19ec1e4212e849549544cb
XORG_LIB_XI		:= libXi-$(XORG_LIB_XI_VERSION)
XORG_LIB_XI_SUFFIX	:= tar.bz2
XORG_LIB_XI_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX))
XORG_LIB_XI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_DIR		:= $(BUILDDIR)/$(XORG_LIB_XI)
XORG_LIB_XI_LICENSE	:= X11 AND MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XI_CONF_TOOL	:= autoconf
XORG_LIB_XI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-docs \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xi)
	@$(call install_fixup, xorg-lib-xi,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xi,SECTION,base)
	@$(call install_fixup, xorg-lib-xi,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xi,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xi, 0, 0, 0644, libXi)

	@$(call install_finish, xorg-lib-xi)

	@$(call touch)

# vim: syntax=make

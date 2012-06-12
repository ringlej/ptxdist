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
PACKAGES-$(PTXCONF_XORG_LIB_XT) += xorg-lib-xt

#
# Paths and names
#
XORG_LIB_XT_VERSION	:= 1.1.3
XORG_LIB_XT_MD5		:= a6f137ae100e74ebe3b71eb4a38c40b3
XORG_LIB_XT		:= libXt-$(XORG_LIB_XT_VERSION)
XORG_LIB_XT_SUFFIX	:= tar.bz2
XORG_LIB_XT_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX))
XORG_LIB_XT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX)
XORG_LIB_XT_DIR		:= $(BUILDDIR)/$(XORG_LIB_XT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XT_CONF_TOOL	:= autoconf
XORG_LIB_XT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-specs \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_XKB)-xkb \
	$(XORG_OPTIONS_DOCS) \
	--without-perl \
	--without-glib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xt)
	@$(call install_fixup, xorg-lib-xt,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xt,SECTION,base)
	@$(call install_fixup, xorg-lib-xt,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xt,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xt, 0, 0, 0644, libXt)

	@$(call install_finish, xorg-lib-xt)

	@$(call touch)

# vim: syntax=make

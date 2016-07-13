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
PACKAGES-$(PTXCONF_XORG_LIB_XCOMPOSITE) += xorg-lib-xcomposite

#
# Paths and names
#
XORG_LIB_XCOMPOSITE_VERSION	:= 0.4.4
XORG_LIB_XCOMPOSITE_MD5		:= f7a218dcbf6f0848599c6c36fc65c51a
XORG_LIB_XCOMPOSITE		:= libXcomposite-$(XORG_LIB_XCOMPOSITE_VERSION)
XORG_LIB_XCOMPOSITE_SUFFIX	:= tar.bz2
XORG_LIB_XCOMPOSITE_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX))
XORG_LIB_XCOMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCOMPOSITE)
XORG_LIB_XCOMPOSITE_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XCOMPOSITE_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xcomposite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xcomposite)
	@$(call install_fixup, xorg-lib-xcomposite,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xcomposite,SECTION,base)
	@$(call install_fixup, xorg-lib-xcomposite,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xcomposite,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xcomposite, 0, 0, 0644, libXcomposite)

	@$(call install_finish, xorg-lib-xcomposite)

	@$(call touch)

# vim: syntax=make

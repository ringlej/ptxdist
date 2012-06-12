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
PACKAGES-$(PTXCONF_XORG_LIB_ICE) += xorg-lib-ice

#
# Paths and names
#
XORG_LIB_ICE_VERSION	:= 1.0.8
XORG_LIB_ICE_MD5	:= 471b5ca9f5562ac0d6eac7a0bf650738
XORG_LIB_ICE		:= libICE-$(XORG_LIB_ICE_VERSION)
XORG_LIB_ICE_SUFFIX	:= tar.bz2
XORG_LIB_ICE_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX))
XORG_LIB_ICE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_DIR	:= $(BUILDDIR)/$(XORG_LIB_ICE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_ICE_CONF_TOOL	:= autoconf
XORG_LIB_ICE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-specs \
	$(XORG_OPTIONS_TRANS) \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-ice.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-ice,SECTION,base)
	@$(call install_fixup, xorg-lib-ice,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-ice,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-ice, 0, 0, 0644, libICE)

	@$(call install_finish, xorg-lib-ice)

	@$(call touch)

# vim: syntax=make

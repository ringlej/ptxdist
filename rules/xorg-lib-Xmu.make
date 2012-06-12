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
PACKAGES-$(PTXCONF_XORG_LIB_XMU) += xorg-lib-xmu

#
# Paths and names
#
XORG_LIB_XMU_VERSION	:= 1.1.1
XORG_LIB_XMU_MD5	:= a4efff8de85bd45dd3da124285d10c00
XORG_LIB_XMU		:= libXmu-$(XORG_LIB_XMU_VERSION)
XORG_LIB_XMU_SUFFIX	:= tar.bz2
XORG_LIB_XMU_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX))
XORG_LIB_XMU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XMU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XMU_CONF_TOOL	:= autoconf
XORG_LIB_XMU_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(XORG_OPTIONS_TRANS) \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xmu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xmu)
	@$(call install_fixup, xorg-lib-xmu,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xmu,SECTION,base)
	@$(call install_fixup, xorg-lib-xmu,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xmu,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xmu, 0, 0, 0644, libXmu)
	@$(call install_lib, xorg-lib-xmu, 0, 0, 0644, libXmuu)

	@$(call install_finish, xorg-lib-xmu)

	@$(call touch)

# vim: syntax=make

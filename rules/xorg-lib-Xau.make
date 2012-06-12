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
PACKAGES-$(PTXCONF_XORG_LIB_XAU) += xorg-lib-xau

#
# Paths and names
#
XORG_LIB_XAU_VERSION	:= 1.0.7
XORG_LIB_XAU_MD5	:= 2d241521df40d27034413436d1a1465c
XORG_LIB_XAU		:= libXau-$(XORG_LIB_XAU_VERSION)
XORG_LIB_XAU_SUFFIX	:= tar.bz2
XORG_LIB_XAU_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX))
XORG_LIB_XAU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XAU_CONF_TOOL	:= autoconf
XORG_LIB_XAU_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XAU_THREAD)-xthreads

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xau.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xau)
	@$(call install_fixup, xorg-lib-xau,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xau,SECTION,base)
	@$(call install_fixup, xorg-lib-xau,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xau,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xau, 0, 0, 0644, libXau)

	@$(call install_finish, xorg-lib-xau)

	@$(call touch)

# vim: syntax=make

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
XORG_LIB_XMU_VERSION	:= 1.1.0
XORG_LIB_XMU_MD5	:= 6836883a0120e8346cf7f58dc42e465a
XORG_LIB_XMU		:= libXmu-$(XORG_LIB_XMU_VERSION)
XORG_LIB_XMU_SUFFIX	:= tar.bz2
XORG_LIB_XMU_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX))
XORG_LIB_XMU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XMU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XMU_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XMU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XMU_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XMU_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XMU_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS)

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

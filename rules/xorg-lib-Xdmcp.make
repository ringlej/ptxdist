# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XDMCP) += xorg-lib-xdmcp

#
# Paths and names
#
XORG_LIB_XDMCP_VERSION	:= 1.1.0
XORG_LIB_XDMCP_MD5	:= 762b6bbaff7b7d0831ddb4f072f939a5
XORG_LIB_XDMCP		:= libXdmcp-$(XORG_LIB_XDMCP_VERSION)
XORG_LIB_XDMCP_SUFFIX	:= tar.bz2
XORG_LIB_XDMCP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XDMCP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XDMCP_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XDMCP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XDMCP_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XDMCP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDMCP_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xdmcp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xdmcp)
	@$(call install_fixup, xorg-lib-xdmcp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdmcp,SECTION,base)
	@$(call install_fixup, xorg-lib-xdmcp,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdmcp,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xdmcp, 0, 0, 0644, libXdmcp)

	@$(call install_finish, xorg-lib-xdmcp)

	@$(call touch)

# vim: syntax=make

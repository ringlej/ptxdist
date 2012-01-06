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
PACKAGES-$(PTXCONF_XORG_LIB_XPRINTAPPUTIL) += xorg-lib-xprintapputil

#
# Paths and names
#
XORG_LIB_XPRINTAPPUTIL_VERSION	:= 1.0.1
XORG_LIB_XPRINTAPPUTIL_MD5	:= d2de510570aa6714681109b2ba178365
XORG_LIB_XPRINTAPPUTIL		:= libXprintAppUtil-$(XORG_LIB_XPRINTAPPUTIL_VERSION)
XORG_LIB_XPRINTAPPUTIL_SUFFIX	:= tar.bz2
XORG_LIB_XPRINTAPPUTIL_URL	:= $(call ptx/mirror, XORG, individual/lib//$(XORG_LIB_XPRINTAPPUTIL).$(XORG_LIB_XPRINTAPPUTIL_SUFFIX))
XORG_LIB_XPRINTAPPUTIL_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPRINTAPPUTIL).$(XORG_LIB_XPRINTAPPUTIL_SUFFIX)
XORG_LIB_XPRINTAPPUTIL_DIR	:= $(BUILDDIR)/$(XORG_LIB_XPRINTAPPUTIL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XPRINTAPPUTIL_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XPRINTAPPUTIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XPRINTAPPUTIL_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XPRINTAPPUTIL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPRINTAPPUTIL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xprintapputil.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xprintapputil)
	@$(call install_fixup, xorg-lib-xprintapputil,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xprintapputil,SECTION,base)
	@$(call install_fixup, xorg-lib-xprintapputil,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xprintapputil,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xprintapputil, 0, 0, 0644, libXprintAppUtil)

	@$(call install_finish, xorg-lib-xprintapputil)

	@$(call touch)

# vim: syntax=make

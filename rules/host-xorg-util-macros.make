# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_UTIL_MACROS) += host-xorg-util-macros

#
# Paths and names
#
HOST_XORG_UTIL_MACROS_VERSION	:= 1.11.0
HOST_XORG_UTIL_MACROS_MD5	:= 22d5cdff672450cb6902e0d68c200dcb
HOST_XORG_UTIL_MACROS		:= util-macros-$(HOST_XORG_UTIL_MACROS_VERSION)
HOST_XORG_UTIL_MACROS_SUFFIX	:= tar.bz2
HOST_XORG_UTIL_MACROS_URL	:= $(call ptx/mirror, XORG, individual/util/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX))
HOST_XORG_UTIL_MACROS_SOURCE	:= $(SRCDIR)/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX)
HOST_XORG_UTIL_MACROS_DIR	:= $(HOST_BUILDDIR)/$(HOST_XORG_UTIL_MACROS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_XORG_UTIL_MACROS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_XORG_UTIL_MACROS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_UTIL_MACROS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_UTIL_MACROS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_UTIL_MACROS_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

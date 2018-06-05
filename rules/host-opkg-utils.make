# -*-makefile-*-
#
# Copyright (C) 2011 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPKG_UTILS) += host-opkg-utils

#
# Paths and names
#
HOST_OPKG_UTILS_VERSION	:= 0.3.5
HOST_OPKG_UTILS_MD5	:= 4696b1381d9fd2a5df9ca7f5c079588a
HOST_OPKG_UTILS		:= opkg-utils-$(HOST_OPKG_UTILS_VERSION)
HOST_OPKG_UTILS_SUFFIX	:= tar.bz2
HOST_OPKG_UTILS_URL	:= https://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils/snapshot/$(HOST_OPKG_UTILS).$(HOST_OPKG_UTILS_SUFFIX)
HOST_OPKG_UTILS_SOURCE	:= $(SRCDIR)/$(HOST_OPKG_UTILS).$(HOST_OPKG_UTILS_SUFFIX)
HOST_OPKG_UTILS_DIR	:= $(HOST_BUILDDIR)/$(HOST_OPKG_UTILS)
HOST_OPKG_UTILS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPKG_UTILS_CONF_TOOL	:= NO
HOST_OPKG_UTILS_MAKE_ENV	:= PREFIX=

# vim: syntax=make

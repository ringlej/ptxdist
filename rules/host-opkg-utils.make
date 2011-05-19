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
HOST_OPKG_UTILS_VERSION	:= r4747
HOST_OPKG_UTILS_MD5	:= 0dfe19a4a127bcea8e91a1735580841d
HOST_OPKG_UTILS		:= opkg-utils-$(HOST_OPKG_UTILS_VERSION)
HOST_OPKG_UTILS_SUFFIX	:= tar.gz
HOST_OPKG_UTILS_URL	:= http://www.novatech-llc.com/files/$(HOST_OPKG_UTILS).$(HOST_OPKG_UTILS_SUFFIX)
HOST_OPKG_UTILS_SOURCE	:= $(SRCDIR)/$(HOST_OPKG_UTILS).$(HOST_OPKG_UTILS_SUFFIX)
HOST_OPKG_UTILS_DIR	:= $(HOST_BUILDDIR)/$(HOST_OPKG_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPKG_UTILS_CONF_TOOL	:= NO
HOST_OPKG_UTILS_MAKE_OPT	:= PREFIX= $(HOST_ENV_CC)
HOST_OPKG_UTILS_INSTALL_OPT	:= $(HOST_OPKG_UTILS_MAKE_OPT) install

# vim: syntax=make

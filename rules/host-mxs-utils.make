# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MXS_UTILS) += host-mxs-utils

#
# Paths and names
#
HOST_MXS_UTILS_VERSION	:= 2011.08.0
HOST_MXS_UTILS_MD5	:= 2266e2cde13bcb43a76dab6ae2b4ef03
HOST_MXS_UTILS		:= mxs-utils-$(HOST_MXS_UTILS_VERSION)
HOST_MXS_UTILS_SUFFIX	:= tar.bz2
HOST_MXS_UTILS_URL	:= http://www.pengutronix.de/software/mxs-utils/download/$(HOST_MXS_UTILS).$(HOST_MXS_UTILS_SUFFIX)
HOST_MXS_UTILS_SOURCE	:= $(SRCDIR)/$(HOST_MXS_UTILS).$(HOST_MXS_UTILS_SUFFIX)
HOST_MXS_UTILS_DIR	:= $(HOST_BUILDDIR)/$(HOST_MXS_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_MXS_UTILS_CONF_TOOL	:= autoconf

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2006-2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PKG_CONFIG) += host-pkg-config

#
# Paths and names
#
HOST_PKG_CONFIG_VERSION	:= 0.25
HOST_PKG_CONFIG		:= pkg-config-$(HOST_PKG_CONFIG_VERSION)
HOST_PKG_CONFIG_SUFFIX	:= tar.gz
HOST_PKG_CONFIG_URL	:= http://pkgconfig.freedesktop.org/releases/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_SOURCE	:= $(SRCDIR)/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_DIR	:= $(HOST_BUILDDIR)/$(HOST_PKG_CONFIG)
HOST_PKG_CONFIG_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_PKG_CONFIG_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_PKG_CONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PKG_CONFIG_CONFTOOL := autoconf

# vim: syntax=make

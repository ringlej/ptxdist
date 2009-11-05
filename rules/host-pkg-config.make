# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_PKG_CONFIG_VERSION	:= 0.23
HOST_PKG_CONFIG		:= pkg-config-$(HOST_PKG_CONFIG_VERSION)
HOST_PKG_CONFIG_SUFFIX	:= tar.gz
HOST_PKG_CONFIG_URL	:= http://pkgconfig.freedesktop.org/releases/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_SOURCE	:= $(SRCDIR)/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_DIR	:= $(HOST_BUILDDIR)/$(HOST_PKG_CONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_PKG_CONFIG_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_PKG_CONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PKG_CONFIG_PATH	:= PATH=$(HOST_PATH)
HOST_PKG_CONFIG_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PKG_CONFIG_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pkg-config_clean:
	rm -rf $(STATEDIR)/host-pkg-config.*
	rm -rf $(HOST_PKG_CONFIG_DIR)

# vim: syntax=make

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
HOST_PKG_CONFIG_VERSION	:= 0.28
HOST_PKG_CONFIG_MD5	:= aa3c86e67551adc3ac865160e34a2a0d
HOST_PKG_CONFIG		:= pkg-config-$(HOST_PKG_CONFIG_VERSION)
HOST_PKG_CONFIG_SUFFIX	:= tar.gz
HOST_PKG_CONFIG_URL	:= http://pkgconfig.freedesktop.org/releases/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_SOURCE	:= $(SRCDIR)/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_DIR	:= $(HOST_BUILDDIR)/$(HOST_PKG_CONFIG)
HOST_PKG_CONFIG_DEVPKG	:= NO
HOST_PKG_CONFIG_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PKG_CONFIG_CONF_TOOL	:= autoconf
HOST_PKG_CONFIG_CONF_OPT	:= \
	$(HOST_AUTOCONF_SYSROOT) \
	--disable-host-tool \
	--with-internal-glib

# vim: syntax=make

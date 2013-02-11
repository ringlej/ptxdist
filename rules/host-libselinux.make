# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBSELINUX) += host-libselinux

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBSELINUX_CONF_TOOL := NO
HOST_LIBSELINUX_MAKE_ENV := \
	$(HOST_ENV) \
	CFLAGS="-O2 -Wall -g"
HOST_LIBSELINUX_MAKE_OPT := PREFIX=$(PTXDIST_SYSROOT_HOST)
# no ':=' here
HOST_LIBSELINUX_INSTALL_OPT = \
	PREFIX=$(HOST_LIBSELINUX_PKGDIR) \
	install

# vim: syntax=make

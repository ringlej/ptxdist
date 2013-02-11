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
HOST_PACKAGES-$(PTXCONF_HOST_LIBSEPOL) += host-libsepol

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBSEPOL_CONF_TOOL := NO
HOST_LIBSEPOL_MAKE_ENV := \
	$(HOST_ENV) \
	CFLAGS="-O2 -Wall -g"
HOST_LIBSEPOL_MAKE_OPT := PREFIX=$(PTXDIST_SYSROOT_HOST)
# no ':=' here
HOST_LIBSEPOL_INSTALL_OPT = \
	PREFIX=$(HOST_LIBSEPOL_PKGDIR) \
	install

# vim: syntax=make

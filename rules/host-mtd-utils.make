# -*-makefile-*-
#
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MTD_UTILS) += host-mtd-utils

#
# Paths and names
#
HOST_MTD_UTILS_DIR	= $(HOST_BUILDDIR)/$(MTD_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MTD_UTILS_COMPILE_ENV := \
	$(HOST_ENV) \
	WITHOUT_XATTR=1

# don't use := here
HOST_MTD_UTILS_MAKEVARS	= \
	PREFIX=/ \
	BUILDDIR=$(HOST_MTD_UTILS_DIR) \
	DESTDIR=$(HOST_MTD_UTILS_PKGDIR)

# vim: syntax=make

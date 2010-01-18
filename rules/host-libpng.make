# -*-makefile-*-
#
# Copyright (C) 2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBPNG) += host-libpng

#
# Paths and names
#
HOST_LIBPNG_DIR	= $(HOST_BUILDDIR)/$(LIBPNG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBPNG_PATH	:= PATH=$(HOST_PATH)
HOST_LIBPNG_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBPNG_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBLZO) += host-liblzo

#
# Paths and names
#
HOST_LIBLZO_DIR	= $(HOST_BUILDDIR)/$(LIBLZO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBLZO_PATH	:= PATH=$(HOST_PATH)
HOST_LIBLZO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBLZO_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PANGOMM) += host-pangomm

#
# Paths and names
#
HOST_PANGOMM_DIR	= $(HOST_BUILDDIR)/$(PANGOMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PANGOMM_PATH	:= PATH=$(HOST_PATH)
HOST_PANGOMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PANGOMM_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

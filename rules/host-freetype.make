# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FREETYPE) += host-freetype

#
# Paths and names
#
HOST_FREETYPE_DIR	= $(HOST_BUILDDIR)/$(FREETYPE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FREETYPE_PATH	:= PATH=$(HOST_PATH)
HOST_FREETYPE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_FREETYPE_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

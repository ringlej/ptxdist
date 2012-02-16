# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

#
# Paths and names
#
HOST_E2FSPROGS		= $(E2FSPROGS)
HOST_E2FSPROGS_DIR	= $(HOST_BUILDDIR)/$(HOST_E2FSPROGS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_E2FSPROGS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_E2FSPROGS_AUTOCONF := $(HOST_AUTOCONF)
HOST_E2FSPROGS_INSTALL_OPT := install

# vim: syntax=make


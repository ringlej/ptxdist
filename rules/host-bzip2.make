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
HOST_PACKAGES-$(PTXCONF_HOST_BZIP2) += host-bzip2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_BZIP2_INSTALL_OPT := install PREFIX=

# vim: syntax=make

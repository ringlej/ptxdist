# -*-makefile-*-
#
# Copyright (C) 2016 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBAIO) += host-libaio

# ----------------------------------------------------------------------------
# Prepare + Compile
# ----------------------------------------------------------------------------

HOST_LIBAIO_CONF_TOOL	:= NO
HOST_LIBAIO_MAKE_ENV	:= $(HOST_ENV)
HOST_LIBAIO_MAKEVARS	:= prefix=

# vim: syntax=make

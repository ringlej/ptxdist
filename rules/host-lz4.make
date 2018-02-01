# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LZ4) += host-lz4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LZ4_CONF_TOOL	:= NO
HOST_LZ4_MAKE_ENV	:= PREFIX=
HOST_LZ4_MAKE_OPT	:= BUILD_STATIC=no lz4
HOST_LZ4_INSTALL_OPT	:= BUILD_STATIC=no install

# vim: syntax=make

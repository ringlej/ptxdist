# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBCAP) += host-libcap

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBCAP_CONF_TOOL := autoconf
HOST_LIBCAP_MAKE_OPT := prefix= PAM_CAP=no LIBATTR=no lib=lib
HOST_LIBCAP_INSTALL_OPT := $(HOST_LIBCAP_MAKE_OPT) install

# vim: syntax=make

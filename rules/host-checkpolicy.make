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
HOST_PACKAGES-$(PTXCONF_HOST_CHECKPOLICY) += host-checkpolicy

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CHECKPOLICY_CONF_TOOL := NO
HOST_CHECKPOLICY_MAKE_ENV := \
	$(HOST_ENV) \
	CFLAGS="-O2 -Wall -g"
HOST_CHECKPOLICY_MAKE_OPT := LIBDIR=$(PTXDIST_SYSROOT_HOST)/lib
# no ":=" here
HOST_CHECKPOLICY_INSTALL_OPT = \
	PREFIX=$(HOST_CHECKPOLICY_PKGDIR) \
	install

# vim: syntax=make

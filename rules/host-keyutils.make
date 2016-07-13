# -*-makefile-*-
#
# Copyright (C) 2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_KEYUTILS) += host-keyutils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_KEYUTILS_CONF_TOOL := NO
HOST_KEYUTILS_MAKE_OPT := \
	$(HOST_ENV_CC) \
	CFLAGS="-O2 -g3 -Wall" \
	BUILDFOR="" \
	LIBDIR=/lib \
	USRLIBDIR=/lib \
	INCLUDEDIR=/include

HOST_KEYUTILS_INSTALL_OPT := \
	$(HOST_KEYUTILS_MAKE_OPT) \
	install

# vim: syntax=make

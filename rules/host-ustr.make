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
HOST_PACKAGES-$(PTXCONF_HOST_USTR) += host-ustr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_USTR_CONF_TOOL := NO
HOST_USTR_MAKE_OPT := \
	all-shared \
	prefix=
HOST_USTR_INSTALL_OPT := \
	$(HOST_USTR_MAKE_OPT) \
	install

# vim: syntax=make

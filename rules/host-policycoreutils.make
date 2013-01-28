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
HOST_PACKAGES-$(PTXCONF_HOST_POLICYCOREUTILS) += host-policycoreutils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_POLICYCOREUTILS_CONF_TOOL := NO
HOST_POLICYCOREUTILS_MAKE_ENV := $(HOST_ENV)
HOST_POLICYCOREUTILS_MAKE_OPT := \
	SUBDIRS="setfiles semodule semodule_package"
# no ":=" here
HOST_POLICYCOREUTILS_INSTALL_OPT = \
	$(HOST_POLICYCOREUTILS_MAKE_OPT) \
	PREFIX=$(HOST_POLICYCOREUTILS_PKGDIR) \
	install

# vim: syntax=make

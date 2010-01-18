# -*-makefile-*-
#
# Copyright (C) 2009 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ATTR) += host-attr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ATTR_ENV := $(HOST_ENV)

HOST_ATTR_INSTALL_OPT := \
	install \
	install-lib \
	install-dev

HOST_ATTR_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--libexecdir=$(PTXDIST_SYSROOT_HOST)/lib \
	--enable-shared

# vim: syntax=make

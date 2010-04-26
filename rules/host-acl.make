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
HOST_PACKAGES-$(PTXCONF_HOST_ACL) += host-acl

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ACL_ENV := $(HOST_ENV)

HOST_ACL_INSTALL_OPT := \
	DIST_ROOT=$(HOST_ACL_PKGDIR) \
	install \
	install-lib \
	install-dev

HOST_ACL_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--libexecdir=/lib \
	--enable-shared

# vim: syntax=make

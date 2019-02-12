# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBASSUAN) += host-libassuan

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBASSUAN_CONF_ENV	:= \
	$(HOST_ENV) \
	LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/lib"
#
# autoconf
#
HOST_LIBASSUAN_CONF_TOOL	:= autoconf
HOST_LIBASSUAN_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)" \
	--disable-doc

# vim: syntax=make

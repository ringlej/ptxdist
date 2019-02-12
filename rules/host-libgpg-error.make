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
HOST_PACKAGES-$(PTXCONF_HOST_LIBGPG_ERROR) += host-libgpg-error

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBGPG_ERROR_CONF_TOOL	:= autoconf
HOST_LIBGPG_ERROR_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-threads=posix \
	--disable-nls \
	--disable-rpath \
	--disable-log-clock \
	--disable-werror \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)" \
	--disable-languages \
	--disable-doc \
	--disable-tests

# vim: syntax=make

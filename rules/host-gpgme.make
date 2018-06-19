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
HOST_PACKAGES-$(PTXCONF_HOST_GPGME) += host-gpgme

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GPGME_CONF_ENV	:= \
	$(HOST_ENV) \
	LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/lib"
#
# autoconf
#
HOST_GPGME_CONF_TOOL	:= autoconf
HOST_GPGME_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-glibtest \
	--disable-w32-glib \
	--enable-fixed-path="" \
	--enable-languages=cpp \
	--enable-build-timestamp="$(PTXDIST_VERSION_YEAR)-$(PTXDIST_VERSION_MONTH)-01T00:00+0000" \
	--disable-gpgconf-test \
	--disable-gpg-test \
	--disable-gpgsm-test \
	--disable-g13-test


# vim: syntax=make

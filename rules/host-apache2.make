# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_APACHE2) += host-apache2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_APACHE2_CONF_TOOL := autoconf
HOST_APACHE2_CONF_OPT := \
	--prefix=/ \
	--with-apr=$(PTXDIST_SYSROOT_HOST)/bin/apr-config \
	--with-apr-util=$(PTXDIST_SYSROOT_HOST)/bin/apu-config

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.compile:
	@$(call targetinfo)
	@make -C $(HOST_APACHE2_DIR)/server gen_test_char
	@make -C $(HOST_APACHE2_DIR)/srclib/pcre dftables
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.install:
	@$(call targetinfo)
	@install -D -m 755 ${HOST_APACHE2_DIR}/server/gen_test_char \
		${HOST_APACHE2_PKGDIR}/bin/gen_test_char
	@install -D -m 755 ${HOST_APACHE2_DIR}/srclib/pcre/dftables \
		${HOST_APACHE2_PKGDIR}/bin/dftables
	@$(call touch)

# vim: syntax=make

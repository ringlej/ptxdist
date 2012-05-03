# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_APR) += host-apr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_APR_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apr.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_APR)
	@sed -i -e "s~@SYSROOT@~$(PTXDIST_SYSROOT_HOST)~g" \
		$(PTXDIST_SYSROOT_HOST)/build/apr_rules.mk \
		$(PTXDIST_SYSROOT_HOST)/bin/apr-config
	@$(call touch)

# vim: syntax=make

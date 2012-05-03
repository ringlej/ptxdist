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
HOST_PACKAGES-$(PTXCONF_HOST_APR_UTIL) += host-apr-util

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_APR_UTIL_CONF_TOOL := autoconf
HOST_APR_UTIL_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--with-apr=$(PTXDIST_SYSROOT_HOST)/bin/apr-config

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apr-util.install:
	@$(call targetinfo)
	@$(call world/install, HOST_APR_UTIL)
	@install $(HOST_APR_UTIL_DIR)/uri/gen_uri_delims $(HOST_APR_UTIL_PKGDIR)/bin
	@$(call touch)

# vim: syntax=make

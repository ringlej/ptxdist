# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TIMEOUT) += host-timeout

#
# Paths and names
#
HOST_TIMEOUT_DIR	= $(HOST_BUILDDIR)/$(TIMEOUT)
HOST_TIMEOUT_SUBDIR	:= src/misc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TIMEOUT_CONF_TOOL	:= NO
HOST_TIMEOUT_MAKE_OPT	:= ../../bin/timeout

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.install:
	@$(call targetinfo)
	@$(INSTALL) -v -m 755 -D $(HOST_TIMEOUT_DIR)/bin/timeout \
		$(PTXCONF_SYSROOT_HOST)/bin/timeout
	@$(call touch)

# vim: syntax=make

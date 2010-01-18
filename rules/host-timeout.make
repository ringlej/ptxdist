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

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TIMEOUT_PATH	:= PATH=$(HOST_PATH)
HOST_TIMEOUT_ENV 	:= $(HOST_ENV)

$(STATEDIR)/host-timeout.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.compile:
	@$(call targetinfo)
	cd $(HOST_TIMEOUT_DIR)/src/misc && $(HOST_TIMEOUT_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN) ../../bin/timeout
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-timeout.install:
	@$(call targetinfo)
	$(INSTALL) -m 755 -D $(HOST_TIMEOUT_DIR)/bin/timeout $(PTXCONF_SYSROOT_HOST)/bin/timeout
	@$(call touch)

# vim: syntax=make

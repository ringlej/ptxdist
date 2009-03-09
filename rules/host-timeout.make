# -*-makefile-*-
# $Id$
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
HOST_TIMEOUT_VERSION	:= 1.18
HOST_TIMEOUT		:= tct-$(HOST_TIMEOUT_VERSION)
HOST_TIMEOUT_SUFFIX	:= tar.gz
HOST_TIMEOUT_URL	:= http://www.porcupine.org/forensics/$(HOST_TIMEOUT).$(HOST_TIMEOUT_SUFFIX)
HOST_TIMEOUT_SOURCE	:= $(SRCDIR)/$(HOST_TIMEOUT).$(HOST_TIMEOUT_SUFFIX)
HOST_TIMEOUT_DIR	:= $(HOST_BUILDDIR)/$(HOST_TIMEOUT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_TIMEOUT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_TIMEOUT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TIMEOUT_PATH	:= PATH=$(HOST_PATH)
HOST_TIMEOUT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_TIMEOUT_AUTOCONF	:= $(HOST_AUTOCONF)

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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-timeout_clean:
	rm -rf $(STATEDIR)/host-timeout.*
	rm -rf $(HOST_TIMEOUT_DIR)

# vim: syntax=make

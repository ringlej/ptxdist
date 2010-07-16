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
PACKAGES-$(PTXCONF_TIMEOUT) += timeout

#
# Paths and names
#
TIMEOUT_VERSION	:= 1.18
TIMEOUT		:= tct-$(TIMEOUT_VERSION)
TIMEOUT_SUFFIX	:= tar.gz
TIMEOUT_URL	:= http://www.porcupine.org/forensics/$(TIMEOUT).$(TIMEOUT_SUFFIX)
TIMEOUT_SOURCE	:= $(SRCDIR)/$(TIMEOUT).$(TIMEOUT_SUFFIX)
TIMEOUT_DIR	:= $(BUILDDIR)/$(TIMEOUT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TIMEOUT_SOURCE):
	@$(call targetinfo)
	@$(call get, TIMEOUT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TIMEOUT_PATH	:= PATH=$(CROSS_PATH)

TIMEOUT_MAKEVARS := $(CROSS_ENV_CC)

$(STATEDIR)/timeout.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/timeout.compile:
	@$(call targetinfo)
	cd $(TIMEOUT_DIR)/src/misc && $(TIMEOUT_PATH) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN) $(TIMEOUT_MAKEVARS) \
		../../bin/timeout
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timeout.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timeout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, timeout)
	@$(call install_fixup, timeout,PRIORITY,optional)
	@$(call install_fixup, timeout,SECTION,base)
	@$(call install_fixup, timeout,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, timeout,DESCRIPTION,missing)

	@$(call install_copy, timeout, 0, 0, 0755, $(TIMEOUT_DIR)/bin/timeout, /usr/bin/timeout)

	@$(call install_finish, timeout)

	@$(call touch)

# vim: syntax=make

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
HOST_PACKAGES-$(PTXCONF_HOST_GPERF) += host-gperf

#
# Paths and names
#
HOST_GPERF_VERSION	:= 3.0.4
HOST_GPERF		:= gperf-$(HOST_GPERF_VERSION)
HOST_GPERF_SUFFIX	:= tar.gz
HOST_GPERF_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/gperf/$(HOST_GPERF).$(HOST_GPERF_SUFFIX)
HOST_GPERF_SOURCE	:= $(SRCDIR)/$(HOST_GPERF).$(HOST_GPERF_SUFFIX)
HOST_GPERF_DIR		:= $(HOST_BUILDDIR)/$(HOST_GPERF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_GPERF_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_GPERF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GPERF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GPERF_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gperf_clean:
	rm -rf $(STATEDIR)/host-gperf.*
	rm -rf $(HOST_GPERF_DIR)

# vim: syntax=make

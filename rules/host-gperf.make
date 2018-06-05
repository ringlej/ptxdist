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
HOST_GPERF_MD5		:= c1f1db32fb6598d6a93e6e88796a8632
HOST_GPERF		:= gperf-$(HOST_GPERF_VERSION)
HOST_GPERF_SUFFIX	:= tar.gz
HOST_GPERF_URL		:= $(call ptx/mirror, GNU, gperf/$(HOST_GPERF).$(HOST_GPERF_SUFFIX))
HOST_GPERF_SOURCE	:= $(SRCDIR)/$(HOST_GPERF).$(HOST_GPERF_SUFFIX)
HOST_GPERF_DIR		:= $(HOST_BUILDDIR)/$(HOST_GPERF)
HOST_GPERF_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GPERF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GPERF_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DTC) += host-dtc

#
# Paths and names
#
HOST_DTC_VERSION	:= $(call remove_quotes,$(PTXCONF_HOST_DTC_VERSION))
HOST_DTC		:= dtc-v$(HOST_DTC_VERSION)
HOST_DTC_SUFFIX		:= tgz
HOST_DTC_URL		:= http://www.jdl.com/software/$(HOST_DTC).$(HOST_DTC_SUFFIX)
HOST_DTC_SOURCE		:= $(SRCDIR)/$(HOST_DTC).$(HOST_DTC_SUFFIX)
HOST_DTC_DIR		:= $(HOST_BUILDDIR)/$(HOST_DTC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_DTC_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_DTC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dtc.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_DTC_DIR))
	@$(call extract, HOST_DTC, $(HOST_BUILDDIR))
	@$(call patchin, HOST_DTC, $(HOST_DTC_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DTC_PATH	:= PATH=$(HOST_PATH)
HOST_DTC_ENV 	:= $(HOST_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dtc.install:
	@$(call targetinfo)
	cp $(HOST_DTC_DIR)/dtc $(PTXCONF_SYSROOT_HOST)/bin/dtc
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-dtc_clean:
	rm -rf $(STATEDIR)/host-dtc.*
	rm -rf $(HOST_DTC_DIR)

# vim: syntax=make

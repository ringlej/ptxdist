# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Sascha Hauer
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

host-dtc_get: $(STATEDIR)/host-dtc.get

$(STATEDIR)/host-dtc.get: $(host-dtc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_DTC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_DTC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-dtc_extract: $(STATEDIR)/host-dtc.extract

$(STATEDIR)/host-dtc.extract: $(host-dtc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_DTC_DIR))
	@$(call extract, HOST_DTC, $(HOST_BUILDDIR))
	@$(call patchin, HOST_DTC, $(HOST_DTC_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-dtc_prepare: $(STATEDIR)/host-dtc.prepare

HOST_DTC_PATH	:= PATH=$(HOST_PATH)
HOST_DTC_ENV 	:= $(HOST_ENV)

$(STATEDIR)/host-dtc.prepare: $(host-dtc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-dtc_compile: $(STATEDIR)/host-dtc.compile

$(STATEDIR)/host-dtc.compile: $(host-dtc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_DTC_DIR) && $(HOST_DTC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-dtc_install: $(STATEDIR)/host-dtc.install

$(STATEDIR)/host-dtc.install: $(host-dtc_install_deps_default)
	@$(call targetinfo, $@)
	cp $(HOST_DTC_DIR)/dtc $(PTXCONF_SYSROOT_HOST)/bin/dtc
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-dtc_clean:
	rm -rf $(STATEDIR)/host-dtc.*
	rm -rf $(HOST_DTC_DIR)

# vim: syntax=make

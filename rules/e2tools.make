# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: make this a hosttool? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_E2TOOLS) += host-e2tools

#
# Paths and names
#
HOST_E2TOOLS_VERSION	= 0.0.15
HOST_E2TOOLS		= e2tools-$(HOST_E2TOOLS_VERSION)
HOST_E2TOOLS_SUFFIX		= tar.gz
HOST_E2TOOLS_URL		= http://home.earthlink.net/~k_sheff/sw/e2tools/$(HOST_E2TOOLS).$(HOST_E2TOOLS_SUFFIX)
HOST_E2TOOLS_SOURCE		= $(SRCDIR)/$(HOST_E2TOOLS).$(HOST_E2TOOLS_SUFFIX)
HOST_E2TOOLS_DIR		= $(BUILDDIR)/$(E2TOOLS)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-e2tools_get: $(STATEDIR)/host-e2tools.get

host-e2tools_get_deps = $(HOST_E2TOOLS_SOURCE)

$(STATEDIR)/host-e2tools.get: $(host-e2tools_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_E2TOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_E2TOOLS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-e2tools_extract: $(STATEDIR)/host-e2tools.extract

host-e2tools_extract_deps = $(STATEDIR)/host-e2tools.get

$(STATEDIR)/host-e2tools.extract: $(host-e2tools_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_E2TOOLS_DIR))
	@$(call extract, $(HOST_E2TOOLS_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-e2tools_prepare: $(STATEDIR)/host-e2tools.prepare

#
# dependencies
#
host-e2tools_prepare_deps = \
	$(STATEDIR)/host-e2tools.extract \
	$(STATEDIR)/host-e2fsprogs.install

HOST_E2TOOLS_PATH	=  PATH=$(CROSS_PATH)
HOST_E2TOOLS_ENV 	=  $(CROSS_ENV)
#HOST_E2TOOLS_ENV	+=

#
# autoconf
#
HOST_E2TOOLS_AUTOCONF = \
	--build=$(GNU_HOST)
	--host=$(GNU_HOST)
	--target=$(GNU_HOST)

$(STATEDIR)/host-e2tools.prepare: $(host-e2tools_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_E2TOOLS_DIR)/config.cache)
	cd $(HOST_E2TOOLS_DIR) && \
		$(HOST_E2TOOLS_PATH) $(HOST_E2TOOLS_ENV) \
		./configure $(HOST_E2TOOLS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-e2tools_compile: $(STATEDIR)/host-e2tools.compile

host-e2tools_compile_deps = $(STATEDIR)/host-e2tools.prepare

$(STATEDIR)/host-e2tools.compile: $(host-e2tools_compile_deps)
	@$(call targetinfo, $@)
	$(HOST_E2TOOLS_PATH) make -C $(HOST_E2TOOLS_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-e2tools_install: $(STATEDIR)/host-e2tools.install

$(STATEDIR)/host-e2tools.install: $(STATEDIR)/host-e2tools.compile
	@$(call targetinfo, $@)
	@$(call install, HOST_E2TOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-e2tools_targetinstall: $(STATEDIR)/host-e2tools.targetinstall

host-e2tools_targetinstall_deps = $(STATEDIR)/host-e2tools.compile

$(STATEDIR)/host-e2tools.targetinstall: $(host-e2tools_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-e2tools_clean:
	rm -rf $(STATEDIR)/host-e2tools.*
	rm -rf $(HOST_E2TOOLS_DIR)

# vim: syntax=make

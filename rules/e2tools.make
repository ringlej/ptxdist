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
ifdef PTXCONF_E2TOOLS
PACKAGES += hosttool-e2tools
endif

#
# Paths and names
#
HOSTTOOL_E2TOOLS_VERSION	= 0.0.15
HOSTTOOL_E2TOOLS		= e2tools-$(HOSTTOOL_E2TOOLS_VERSION)
HOSTTOOL_E2TOOLS_SUFFIX		= tar.gz
HOSTTOOL_E2TOOLS_URL		= http://home.earthlink.net/~k_sheff/sw/e2tools/$(E2TOOLS).$(HOSTTOOL_E2TOOLS_SUFFIX)
HOSTTOOL_E2TOOLS_SOURCE		= $(SRCDIR)/$(HOSTTOOL_E2TOOLS).$(HOSTTOOL_E2TOOLS_SUFFIX)
HOSTTOOL_E2TOOLS_DIR		= $(BUILDDIR)/$(E2TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-e2tools_get: $(STATEDIR)/hosttool-e2tools.get

hosttool-e2tools_get_deps = $(HOSTTOOL_E2TOOLS_SOURCE)

$(STATEDIR)/hosttool-e2tools.get: $(hosttool-e2tools_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(HOSTTOOL_E2TOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_E2TOOLS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-e2tools_extract: $(STATEDIR)/hosttool-e2tools.extract

hosttool-e2tools_extract_deps = $(STATEDIR)/hosttool-e2tools.get

$(STATEDIR)/hosttool-e2tools.extract: $(hosttool-e2tools_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_E2TOOLS_DIR))
	@$(call extract, $(HOSTTOOL_E2TOOLS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-e2tools_prepare: $(STATEDIR)/hosttool-e2tools.prepare

#
# dependencies
#
hosttool-e2tools_prepare_deps = \
	$(STATEDIR)/hosttool-e2tools.extract \
	$(STATEDIR)/hosttool-e2fsprogs.install

HOSTTOOL_E2TOOLS_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL_E2TOOLS_ENV 	=  $(CROSS_ENV)
#HOSTTOOL_E2TOOLS_ENV	+=

#
# autoconf
#
HOSTTOOL_E2TOOLS_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST)
	--host=$(GNU_HOST)
	--target=$(GNU_HOST)

$(STATEDIR)/hosttool-e2tools.prepare: $(hosttool-e2tools_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_E2TOOLS_DIR)/config.cache)
	cd $(HOSTTOOL_E2TOOLS_DIR) && \
		$(HOSTTOOL_E2TOOLS_PATH) $(HOSTTOOL_E2TOOLS_ENV) \
		./configure $(HOSTTOOL_E2TOOLS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-e2tools_compile: $(STATEDIR)/hosttool-e2tools.compile

hosttool-e2tools_compile_deps = $(STATEDIR)/hosttool-e2tools.prepare

$(STATEDIR)/hosttool-e2tools.compile: $(hosttool-e2tools_compile_deps)
	@$(call targetinfo, $@)
	$(HOSTTOOL_E2TOOLS_PATH) make -C $(HOSTTOOL_E2TOOLS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-e2tools_install: $(STATEDIR)/hosttool-e2tools.install

$(STATEDIR)/hosttool-e2tools.install: $(STATEDIR)/hosttool-e2tools.compile
	@$(call targetinfo, $@)
	$(HOSTTOOL_E2TOOLS_PATH) make -C $(HOSTTOOL_E2TOOLS_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-e2tools_targetinstall: $(STATEDIR)/hosttool-e2tools.targetinstall

hosttool-e2tools_targetinstall_deps = $(STATEDIR)/hosttool-e2tools.compile

$(STATEDIR)/hosttool-e2tools.targetinstall: $(hosttool-e2tools_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-e2tools_clean:
	rm -rf $(STATEDIR)/hosttool-e2tools.*
	rm -rf $(HOSTTOOL_E2TOOLS_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_PKG_CONFIG_WRAPPER) += cross-pkg-config-wrapper

#
# Paths and names
#
CROSS_PKG_CONFIG_WRAPPER_VERSION	:= 1.0.0
CROSS_PKG_CONFIG_WRAPPER		:= pkg-config-wrapper-$(CROSS_PKG_CONFIG_WRAPPER_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_get: $(STATEDIR)/cross-pkg-config-wrapper.get

$(STATEDIR)/cross-pkg-config-wrapper.get: $(cross-pkg-config-wrapper_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_extract: $(STATEDIR)/cross-pkg-config-wrapper.extract

$(STATEDIR)/cross-pkg-config-wrapper.extract: $(cross-pkg-config-wrapper_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_prepare: $(STATEDIR)/cross-pkg-config-wrapper.prepare

$(STATEDIR)/cross-pkg-config-wrapper.prepare: $(cross-pkg-config-wrapper_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_compile: $(STATEDIR)/cross-pkg-config-wrapper.compile

$(STATEDIR)/cross-pkg-config-wrapper.compile: $(cross-pkg-config-wrapper_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_install: $(STATEDIR)/cross-pkg-config-wrapper.install

$(STATEDIR)/cross-pkg-config-wrapper.install: $(cross-pkg-config-wrapper_install_deps_default)
	@$(call targetinfo, $@)
	install -m755 $(SCRIPTSDIR)/pkg-config-wrapper $(PTXCONF_CROSS_PREFIX)/bin/pkg-config
	install -m755 $(SCRIPTSDIR)/pkg-config-wrapper $(PTXCONF_CROSS_PREFIX)/bin/$(COMPILER_PREFIX)pkg-config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-pkg-config-wrapper_clean:
	rm -rf $(STATEDIR)/cross-pkg-config-wrapper.*
	rm -rf $(IMAGEDIR)/cross-pkg-config-wrapper_*
	rm -rf $(CROSS_PKG_CONFIG_WRAPPER_DIR)

# vim: syntax=make

# -*-makefile-*-
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
CROSS_PKG_CONFIG_WRAPPER_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_PKG_CONFIG_WRAPPER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-pkg-config-wrapper.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-pkg-config-wrapper.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-pkg-config-wrapper.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-pkg-config-wrapper.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-pkg-config-wrapper.install:
	@$(call targetinfo)
	install -D -m755 $(SCRIPTSDIR)/pkg-config-wrapper $(PTXCONF_SYSROOT_CROSS)/bin/pkg-config
	install -D -m755 $(SCRIPTSDIR)/pkg-config-wrapper $(PTXCONF_SYSROOT_CROSS)/bin/$(COMPILER_PREFIX)pkg-config
	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PKG_CONFIG) += host-pkg-config

#
# Paths and names
#
HOST_PKG_CONFIG_VERSION	:= 0.23
HOST_PKG_CONFIG		:= pkg-config-$(HOST_PKG_CONFIG_VERSION)
HOST_PKG_CONFIG_SUFFIX	:= tar.gz
HOST_PKG_CONFIG_URL	:= http://pkgconfig.freedesktop.org/releases/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_SOURCE	:= $(SRCDIR)/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_DIR	:= $(HOST_BUILDDIR)/$(HOST_PKG_CONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-pkg-config_get: $(STATEDIR)/host-pkg-config.get

$(STATEDIR)/host-pkg-config.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_PKG_CONFIG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_PKG_CONFIG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-pkg-config_extract: $(STATEDIR)/host-pkg-config.extract

$(STATEDIR)/host-pkg-config.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PKG_CONFIG_DIR))
	@$(call extract, HOST_PKG_CONFIG, $(HOST_BUILDDIR))
	@$(call patchin, HOST_PKG_CONFIG, $(HOST_PKG_CONFIG_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-pkg-config_prepare: $(STATEDIR)/host-pkg-config.prepare

HOST_PKG_CONFIG_PATH	:= PATH=$(HOST_PATH)
HOST_PKG_CONFIG_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PKG_CONFIG_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-pkg-config.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PKG_CONFIG_DIR)/config.cache)
	cd $(HOST_PKG_CONFIG_DIR) && \
		$(HOST_PKG_CONFIG_PATH) $(HOST_PKG_CONFIG_ENV) \
		./configure $(HOST_PKG_CONFIG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-pkg-config_compile: $(STATEDIR)/host-pkg-config.compile

$(STATEDIR)/host-pkg-config.compile:
	@$(call targetinfo, $@)
	cd $(HOST_PKG_CONFIG_DIR) && $(HOST_PKG_CONFIG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-pkg-config_install: $(STATEDIR)/host-pkg-config.install

$(STATEDIR)/host-pkg-config.install:
	@$(call targetinfo, $@)
	@$(call install, HOST_PKG_CONFIG,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pkg-config_clean:
	rm -rf $(STATEDIR)/host-pkg-config.*
	rm -rf $(HOST_PKG_CONFIG_DIR)

# vim: syntax=make

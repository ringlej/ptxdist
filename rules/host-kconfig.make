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
HOST_PACKAGES-$(PTXCONF_HOST_KCONFIG) += host-kconfig

#
# Paths and names
#
HOST_KCONFIG_VERSION	= 2.6.14
HOST_KCONFIG		= kconfig-$(HOST_KCONFIG_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-kconfig_get: $(STATEDIR)/host-kconfig.get

$(STATEDIR)/host-kconfig.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-kconfig_extract: $(STATEDIR)/host-kconfig.extract

host-kconfig_extract_deps = $(STATEDIR)/host-kconfig.get

$(STATEDIR)/host-kconfig.extract: $(host-kconfig_extract_deps)
	@$(call targetinfo, $@)

	# we may be in an out-of-tree workspace...
	if [ ! -d "$(PTXDIST_WORKSPACE)/scripts/kconfig" ]; then \
		mkdir -p $(PTXDIST_WORKSPACE)/scripts; \
		cp -a $(PTXDIST_TOPDIR)/scripts/kconfig $(PTXDIST_WORKSPACE)/scripts; \
	fi

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-kconfig_prepare: $(STATEDIR)/host-kconfig.prepare

#
# dependencies
#
host-kconfig_prepare_deps = \
	$(STATEDIR)/host-kconfig.extract

HOST_KCONFIG_PATH	=  PATH=$(HOST_PATH)
HOST_KCONFIG_ENV 	=  $(HOSTCC_ENV)

$(STATEDIR)/host-kconfig.prepare: $(host-kconfig_prepare_deps)
	@$(call targetinfo, $@, n)
	@$(call clean, $(HOST_KCONFIG_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-kconfig_compile: $(STATEDIR)/host-kconfig.compile

host-kconfig_compile_deps = $(STATEDIR)/host-kconfig.prepare

$(STATEDIR)/host-kconfig.compile: $(host-kconfig_compile_deps)
	@$(call targetinfo, $@, n)
	cd $(PTXDIST_WORKSPACE)/scripts/kconfig && \
		$(HOST_KCONFIG_ENV) $(HOST_KCONFIG_PATH) make libkconfig.so
	cd $(PTXDIST_WORKSPACE)/scripts/kconfig && \
		$(HOST_KCONFIG_ENV) $(HOST_KCONFIG_PATH) make conf
	cd $(PTXDIST_WORKSPACE)/scripts/kconfig && \
		$(HOST_KCONFIG_ENV) $(HOST_KCONFIG_PATH) make mconf
#	cd $(PTXDIST_WORKSPACE)/scripts/kconfig && \
#		$(HOST_KCONFIG_ENV) $(HOST_KCONFIG_PATH) make qconf
#	cd $(PTXDIST_WORKSPACE)/scripts/kconfig && \
#		$(HOST_KCONFIG_ENV) $(HOST_KCONFIG_PATH) make gconf
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-kconfig_install: $(STATEDIR)/host-kconfig.install

host-kconfig_install_deps = $(STATEDIR)/host-kconfig.compile

$(STATEDIR)/host-kconfig.install: $(host-kconfig_install_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-kconfig_clean:
	rm -rf $(STATEDIR)/host-kconfig.*
	rm -rf $(HOST_KCONFIG_DIR)

# vim: syntax=make

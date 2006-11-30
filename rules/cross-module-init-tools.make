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
CROSS_PACKAGES-$(PTXCONF_CROSS_MODULE_INIT_TOOLS) += cross-module-init-tools

#
# Paths and names
#
#CROSS_MODULE_INIT_TOOLS		= $(MODULE_INIT_TOOLS)
CROSS_MODULE_INIT_TOOLS_DIR	= $(CROSS_BUILDDIR)/$(MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cross-module-init-tools_get: $(STATEDIR)/cross-module-init-tools.get

$(STATEDIR)/cross-module-init-tools.get: $(STATEDIR)/module-init-tools.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cross-module-init-tools_extract: $(STATEDIR)/cross-module-init-tools.extract

$(STATEDIR)/cross-module-init-tools.extract: $(cross-module-init-tools_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_MODULE_INIT_TOOLS_DIR))
	@$(call extract, MODULE_INIT_TOOLS, $(CROSS_BUILDDIR))
	@$(call patchin, MODULE_INIT_TOOLS, $(CROSS_MODULE_INIT_TOOLS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cross-module-init-tools_prepare: $(STATEDIR)/cross-module-init-tools.prepare

CROSS_MODULE_INIT_TOOLS_PATH := PATH=$(CROSS_PATH)
CROSS_MODULE_INIT_TOOLS_ENV  := $(HOST_ENV)

#
# autoconf
#
CROSS_MODULE_INIT_TOOLS_AUTOCONF := \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/cross-module-init-tools.prepare: $(cross-module-init-tools_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_MODULE_INIT_TOOLS_DIR)/config.cache)
	cd $(CROSS_MODULE_INIT_TOOLS_DIR) && \
		$(CROSS_MODULE_INIT_TOOLS_PATH) $(CROSS_MODULE_INIT_TOOLS_ENV) \
		./configure $(CROSS_MODULE_INIT_TOOLS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cross-module-init-tools_compile: $(STATEDIR)/cross-module-init-tools.compile

$(STATEDIR)/cross-module-init-tools.compile: $(cross-module-init-tools_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CROSS_MODULE_INIT_TOOLS_DIR) && $(CROSS_MODULE_INIT_TOOLS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cross-module-init-tools_install: $(STATEDIR)/cross-module-init-tools.install

$(STATEDIR)/cross-module-init-tools.install: $(cross-module-init-tools_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CROSS_MODULE_INIT_TOOLS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-module-init-tools_clean:
	rm -rf $(STATEDIR)/cross-module-init-tools.*
	rm -rf $(IMAGEDIR)/cross-module-init-tools_*
	rm -rf $(CROSS_MODULE_INIT_TOOLS_DIR)

# vim: syntax=make

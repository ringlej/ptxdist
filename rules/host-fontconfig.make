# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FONTCONFIG) += host-fontconfig

#
# Paths and names
#
HOST_FONTCONFIG_DIR	= $(HOST_BUILDDIR)/$(FONTCONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-fontconfig_get: $(STATEDIR)/host-fontconfig.get

$(STATEDIR)/host-fontconfig.get: $(STATEDIR)/fontconfig.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-fontconfig_extract: $(STATEDIR)/host-fontconfig.extract

$(STATEDIR)/host-fontconfig.extract: $(host-fontconfig_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FONTCONFIG_DIR))
	@$(call extract, FONTCONFIG, $(HOST_BUILDDIR))
	@$(call patchin, FONTCONFIG, $(HOST_FONTCONFIG_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-fontconfig_prepare: $(STATEDIR)/host-fontconfig.prepare

HOST_FONTCONFIG_PATH	:= PATH=$(HOST_PATH)
HOST_FONTCONFIG_ENV 	:= \
	$(HOST_ENV) \
	ac_cv_prog_HASDOCBOOK=no

#
# autoconf
#
HOST_FONTCONFIG_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-docs \
	--with-cache-dir=$(PTXCONF_SYSROOT_HOST)/var/cache/fontconfig \
	--with-default-fonts=$(XORG_FONTDIR) \
	--with-arch=$(PTXCONF_ARCH_STRING)

$(STATEDIR)/host-fontconfig.prepare: $(host-fontconfig_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FONTCONFIG_DIR)/config.cache)
	cd $(HOST_FONTCONFIG_DIR) && \
		$(HOST_FONTCONFIG_PATH) $(HOST_FONTCONFIG_ENV) \
		./configure $(HOST_FONTCONFIG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-fontconfig_compile: $(STATEDIR)/host-fontconfig.compile

$(STATEDIR)/host-fontconfig.compile: $(host-fontconfig_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_FONTCONFIG_DIR) && $(HOST_FONTCONFIG_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-fontconfig_install: $(STATEDIR)/host-fontconfig.install

$(STATEDIR)/host-fontconfig.install: $(host-fontconfig_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_FONTCONFIG,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-fontconfig_clean:
	rm -rf $(STATEDIR)/host-fontconfig.*
	rm -rf $(HOST_FONTCONFIG_DIR)

# vim: syntax=make

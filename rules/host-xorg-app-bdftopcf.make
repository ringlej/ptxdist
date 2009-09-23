# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_BDFTOPCF) += host-xorg-app-bdftopcf

#
# Paths and names
#
HOST_XORG_APP_BDFTOPCF_VERSION	:= 1.0.2
HOST_XORG_APP_BDFTOPCF		:= bdftopcf-$(HOST_XORG_APP_BDFTOPCF_VERSION)
HOST_XORG_APP_BDFTOPCF_SUFFIX	:= tar.bz2
HOST_XORG_APP_BDFTOPCF_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(HOST_XORG_APP_BDFTOPCF).$(HOST_XORG_APP_BDFTOPCF_SUFFIX)
HOST_XORG_APP_BDFTOPCF_SOURCE	:= $(SRCDIR)/$(HOST_XORG_APP_BDFTOPCF).$(HOST_XORG_APP_BDFTOPCF_SUFFIX)
HOST_XORG_APP_BDFTOPCF_DIR	:= $(HOST_BUILDDIR)/$(HOST_XORG_APP_BDFTOPCF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_get: $(STATEDIR)/host-xorg-app-bdftopcf.get

$(STATEDIR)/host-xorg-app-bdftopcf.get: $(host-xorg-app-bdftopcf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_XORG_APP_BDFTOPCF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_XORG_APP_BDFTOPCF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_extract: $(STATEDIR)/host-xorg-app-bdftopcf.extract

$(STATEDIR)/host-xorg-app-bdftopcf.extract: $(host-xorg-app-bdftopcf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_BDFTOPCF_DIR))
	@$(call extract, HOST_XORG_APP_BDFTOPCF, $(HOST_BUILDDIR))
	@$(call patchin, HOST_XORG_APP_BDFTOPCF, $(HOST_XORG_APP_BDFTOPCF_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_prepare: $(STATEDIR)/host-xorg-app-bdftopcf.prepare

HOST_XORG_APP_BDFTOPCF_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_APP_BDFTOPCF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_BDFTOPCF_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-app-bdftopcf.prepare: $(host-xorg-app-bdftopcf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_BDFTOPCF_DIR)/config.cache)
	cd $(HOST_XORG_APP_BDFTOPCF_DIR) && \
		$(HOST_XORG_APP_BDFTOPCF_PATH) $(HOST_XORG_APP_BDFTOPCF_ENV) \
		./configure $(HOST_XORG_APP_BDFTOPCF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_compile: $(STATEDIR)/host-xorg-app-bdftopcf.compile

$(STATEDIR)/host-xorg-app-bdftopcf.compile: $(host-xorg-app-bdftopcf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_APP_BDFTOPCF_DIR) && $(HOST_XORG_APP_BDFTOPCF_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_install: $(STATEDIR)/host-xorg-app-bdftopcf.install

$(STATEDIR)/host-xorg-app-bdftopcf.install: $(host-xorg-app-bdftopcf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_APP_BDFTOPCF,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-app-bdftopcf_clean:
	rm -rf $(STATEDIR)/host-xorg-app-bdftopcf.*
	rm -rf $(HOST_XORG_APP_BDFTOPCF_DIR)

# vim: syntax=make

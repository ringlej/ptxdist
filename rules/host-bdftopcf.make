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
HOST_PACKAGES-$(PTXCONF_HOST_BDFTOPCF) += host-bdftopcf

#
# Paths and names
#
HOST_BDFTOPCF_VERSION	:= 1.0.0
HOST_BDFTOPCF		:= bdftopcf-$(HOST_BDFTOPCF_VERSION)
HOST_BDFTOPCF_SUFFIX		:= tar.bz2
HOST_BDFTOPCF_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(HOST_BDFTOPCF).$(HOST_BDFTOPCF_SUFFIX)
HOST_BDFTOPCF_SOURCE		:= $(SRCDIR)/$(HOST_BDFTOPCF).$(HOST_BDFTOPCF_SUFFIX)
HOST_BDFTOPCF_DIR		:= $(HOST_BUILDDIR)/$(HOST_BDFTOPCF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-bdftopcf_get: $(STATEDIR)/host-bdftopcf.get

$(STATEDIR)/host-bdftopcf.get: $(host-bdftopcf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_BDFTOPCF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_BDFTOPCF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-bdftopcf_extract: $(STATEDIR)/host-bdftopcf.extract

$(STATEDIR)/host-bdftopcf.extract: $(host-bdftopcf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_BDFTOPCF_DIR))
	@$(call extract, HOST_BDFTOPCF, $(HOST_BUILDDIR))
	@$(call patchin, HOST_BDFTOPCF, $(HOST_BDFTOPCF_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-bdftopcf_prepare: $(STATEDIR)/host-bdftopcf.prepare

HOST_BDFTOPCF_PATH	:= PATH=$(HOST_PATH)
HOST_BDFTOPCF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_BDFTOPCF_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-bdftopcf.prepare: $(host-bdftopcf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_BDFTOPCF_DIR)/config.cache)
	cd $(HOST_BDFTOPCF_DIR) && \
		$(HOST_BDFTOPCF_PATH) $(HOST_BDFTOPCF_ENV) \
		./configure $(HOST_BDFTOPCF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-bdftopcf_compile: $(STATEDIR)/host-bdftopcf.compile

$(STATEDIR)/host-bdftopcf.compile: $(host-bdftopcf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_BDFTOPCF_DIR) && $(HOST_BDFTOPCF_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-bdftopcf_install: $(STATEDIR)/host-bdftopcf.install

$(STATEDIR)/host-bdftopcf.install: $(host-bdftopcf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_BDFTOPCF,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-bdftopcf_clean:
	rm -rf $(STATEDIR)/host-bdftopcf.*
	rm -rf $(HOST_BDFTOPCF_DIR)

# vim: syntax=make

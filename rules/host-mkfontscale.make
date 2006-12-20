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
HOST_PACKAGES-$(PTXCONF_HOST_MKFONTSCALE) += host-mkfontscale

#
# Paths and names
#
HOST_MKFONTSCALE_DIR		= $(HOST_BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mkfontscale_get: $(STATEDIR)/host-mkfontscale.get

$(STATEDIR)/host-mkfontscale.get: $(STATEDIR)/xorg-app-mkfontdir.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mkfontscale_extract: $(STATEDIR)/host-mkfontscale.extract

$(STATEDIR)/host-mkfontscale.extract: $(host-mkfontscale_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKFONTSCALE_DIR))
	@$(call extract, XORG_APP_MKFONTDIR, $(HOST_BUILDDIR))
	@$(call patchin, XORG_APP_MKFONTDIR, $(HOST_MKFONTSCALE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mkfontscale_prepare: $(STATEDIR)/host-mkfontscale.prepare

HOST_MKFONTSCALE_PATH	:= PATH=$(HOST_PATH)
HOST_MKFONTSCALE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MKFONTSCALE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-mkfontscale.prepare: $(host-mkfontscale_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKFONTSCALE_DIR)/config.cache)
	cd $(HOST_MKFONTSCALE_DIR) && \
		$(HOST_MKFONTSCALE_PATH) $(HOST_MKFONTSCALE_ENV) \
		./configure $(HOST_MKFONTSCALE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mkfontscale_compile: $(STATEDIR)/host-mkfontscale.compile

$(STATEDIR)/host-mkfontscale.compile: $(host-mkfontscale_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MKFONTSCALE_DIR) && $(HOST_MKFONTSCALE_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mkfontscale_install: $(STATEDIR)/host-mkfontscale.install

$(STATEDIR)/host-mkfontscale.install: $(host-mkfontscale_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MKFONTSCALE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mkfontscale_clean:
	rm -rf $(STATEDIR)/host-mkfontscale.*
	rm -rf $(HOST_MKFONTSCALE_DIR)

# vim: syntax=make

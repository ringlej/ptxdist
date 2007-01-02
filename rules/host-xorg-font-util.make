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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_FONT_UTIL) += host-xorg-font-util

#
# Paths and names
#
HOST_XORG_FONT_UTIL_DIR	= $(HOST_BUILDDIR)/$(XORG_FONT_UTIL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-font-util_get: $(STATEDIR)/host-xorg-font-util.get

$(STATEDIR)/host-xorg-font-util.get: $(STATEDIR)/xorg-font-util.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-font-util_extract: $(STATEDIR)/host-xorg-font-util.extract

$(STATEDIR)/host-xorg-font-util.extract: $(host-xorg-font-util_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_FONT_UTIL_DIR))
	@$(call extract, XORG_FONT_UTIL, $(HOST_BUILDDIR))
	@$(call patchin, XORG_FONT_UTIL, $(HOST_XORG_FONT_UTIL_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-font-util_prepare: $(STATEDIR)/host-xorg-font-util.prepare

HOST_XORG_FONT_UTIL_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_FONT_UTIL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_FONT_UTIL_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-font-util.prepare: $(host-xorg-font-util_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_FONT_UTIL_DIR)/config.cache)
	cd $(HOST_XORG_FONT_UTIL_DIR) && \
		$(HOST_XORG_FONT_UTIL_PATH) $(HOST_XORG_FONT_UTIL_ENV) \
		./configure $(HOST_XORG_FONT_UTIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-font-util_compile: $(STATEDIR)/host-xorg-font-util.compile

$(STATEDIR)/host-xorg-font-util.compile: $(host-xorg-font-util_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_FONT_UTIL_DIR) && $(HOST_XORG_FONT_UTIL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-font-util_install: $(STATEDIR)/host-xorg-font-util.install

$(STATEDIR)/host-xorg-font-util.install: $(host-xorg-font-util_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_FONT_UTIL,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-font-util_clean:
	rm -rf $(STATEDIR)/host-xorg-font-util.*
	rm -rf $(HOST_XORG_FONT_UTIL_DIR)

# vim: syntax=make

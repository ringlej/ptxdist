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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_FONTS) += host-xorg-proto-fonts

#
# Paths and names
#
HOST_XORG_PROTO_FONTS_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_FONTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_get: $(STATEDIR)/host-xorg-proto-fonts.get

$(STATEDIR)/host-xorg-proto-fonts.get: $(STATEDIR)/xorg-proto-fonts.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_extract: $(STATEDIR)/host-xorg-proto-fonts.extract

$(STATEDIR)/host-xorg-proto-fonts.extract: $(host-xorg-proto-fonts_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_FONTS_DIR))
	@$(call extract, XORG_PROTO_FONTS, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_FONTS, $(HOST_XORG_PROTO_FONTS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_prepare: $(STATEDIR)/host-xorg-proto-fonts.prepare

HOST_XORG_PROTO_FONTS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_FONTS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_FONTS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-fonts.prepare: $(host-xorg-proto-fonts_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_FONTS_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_FONTS_DIR) && \
		$(HOST_XORG_PROTO_FONTS_PATH) $(HOST_XORG_PROTO_FONTS_ENV) \
		./configure $(HOST_XORG_PROTO_FONTS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_compile: $(STATEDIR)/host-xorg-proto-fonts.compile

$(STATEDIR)/host-xorg-proto-fonts.compile: $(host-xorg-proto-fonts_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_FONTS_DIR) && $(HOST_XORG_PROTO_FONTS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_install: $(STATEDIR)/host-xorg-proto-fonts.install

$(STATEDIR)/host-xorg-proto-fonts.install: $(host-xorg-proto-fonts_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_FONTS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-fonts_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-fonts.*
	rm -rf $(HOST_XORG_PROTO_FONTS_DIR)

# vim: syntax=make

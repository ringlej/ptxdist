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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_INPUT) += host-xorg-proto-input

#
# Paths and names
#
HOST_XORG_PROTO_INPUT_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_INPUT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-input_get: $(STATEDIR)/host-xorg-proto-input.get

$(STATEDIR)/host-xorg-proto-input.get: $(STATEDIR)/xorg-proto-input.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-input_extract: $(STATEDIR)/host-xorg-proto-input.extract

$(STATEDIR)/host-xorg-proto-input.extract: $(host-xorg-proto-input_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_INPUT_DIR))
	@$(call extract, XORG_PROTO_INPUT, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_INPUT, $(HOST_XORG_PROTO_INPUT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-input_prepare: $(STATEDIR)/host-xorg-proto-input.prepare

HOST_XORG_PROTO_INPUT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_INPUT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_INPUT_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-input.prepare: $(host-xorg-proto-input_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_INPUT_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_INPUT_DIR) && \
		$(HOST_XORG_PROTO_INPUT_PATH) $(HOST_XORG_PROTO_INPUT_ENV) \
		./configure $(HOST_XORG_PROTO_INPUT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-input_compile: $(STATEDIR)/host-xorg-proto-input.compile

$(STATEDIR)/host-xorg-proto-input.compile: $(host-xorg-proto-input_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_INPUT_DIR) && $(HOST_XORG_PROTO_INPUT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-input_install: $(STATEDIR)/host-xorg-proto-input.install

$(STATEDIR)/host-xorg-proto-input.install: $(host-xorg-proto-input_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_INPUT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-input_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-input.*
	rm -rf $(HOST_XORG_PROTO_INPUT_DIR)

# vim: syntax=make

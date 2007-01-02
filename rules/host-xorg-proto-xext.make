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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_XEXT) += host-xorg-proto-xext

#
# Paths and names
#
HOST_XORG_PROTO_XEXT		= $(XORG_PROTO_XEXT)
HOST_XORG_PROTO_XEXT_DIR	= $(HOST_BUILDDIR)/$(HOST_XORG_PROTO_XEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-xext_get: $(STATEDIR)/host-xorg-proto-xext.get

$(STATEDIR)/host-xorg-proto-xext.get: $(STATEDIR)/xorg-proto-xext.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-xext_extract: $(STATEDIR)/host-xorg-proto-xext.extract

$(STATEDIR)/host-xorg-proto-xext.extract: $(host-xorg-proto-xext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XEXT_DIR))
	@$(call extract, XORG_PROTO_XEXT, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_XEXT, $(HOST_XORG_PROTO_XEXT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-xext_prepare: $(STATEDIR)/host-xorg-proto-xext.prepare

HOST_XORG_PROTO_XEXT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_XEXT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_XEXT_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-xext.prepare: $(host-xorg-proto-xext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XEXT_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_XEXT_DIR) && \
		$(HOST_XORG_PROTO_XEXT_PATH) $(HOST_XORG_PROTO_XEXT_ENV) \
		./configure $(HOST_XORG_PROTO_XEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-xext_compile: $(STATEDIR)/host-xorg-proto-xext.compile

$(STATEDIR)/host-xorg-proto-xext.compile: $(host-xorg-proto-xext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_XEXT_DIR) && $(HOST_XORG_PROTO_XEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-xext_install: $(STATEDIR)/host-xorg-proto-xext.install

$(STATEDIR)/host-xorg-proto-xext.install: $(host-xorg-proto-xext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_XEXT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-xext_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-xext.*
	rm -rf $(HOST_XORG_PROTO_XEXT_DIR)

# vim: syntax=make

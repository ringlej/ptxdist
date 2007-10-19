# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XCB_PROTO) += host-xcb-proto

#
# Paths and names
#
HOST_XCB_PROTO_DIR	= $(HOST_BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xcb-proto_get: $(STATEDIR)/host-xcb-proto.get

$(STATEDIR)/host-xcb-proto.get: $(STATEDIR)/xcb-proto.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xcb-proto_extract: $(STATEDIR)/host-xcb-proto.extract

$(STATEDIR)/host-xcb-proto.extract: $(host-xcb-proto_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XCB_PROTO_DIR))
	@$(call extract, XCB_PROTO, $(HOST_BUILDDIR))
	@$(call patchin, XCB_PROTO, $(HOST_XCB_PROTO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xcb-proto_prepare: $(STATEDIR)/host-xcb-proto.prepare

HOST_XCB_PROTO_PATH	:= PATH=$(HOST_PATH)
HOST_XCB_PROTO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XCB_PROTO_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xcb-proto.prepare: $(host-xcb-proto_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XCB_PROTO_DIR)/config.cache)
	cd $(HOST_XCB_PROTO_DIR) && \
		$(HOST_XCB_PROTO_PATH) $(HOST_XCB_PROTO_ENV) \
		./configure $(HOST_XCB_PROTO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xcb-proto_compile: $(STATEDIR)/host-xcb-proto.compile

$(STATEDIR)/host-xcb-proto.compile: $(host-xcb-proto_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XCB_PROTO_DIR) && $(HOST_XCB_PROTO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xcb-proto_install: $(STATEDIR)/host-xcb-proto.install

$(STATEDIR)/host-xcb-proto.install: $(host-xcb-proto_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XCB_PROTO,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xcb-proto_clean:
	rm -rf $(STATEDIR)/host-xcb-proto.*
	rm -rf $(HOST_XCB_PROTO_DIR)

# vim: syntax=make

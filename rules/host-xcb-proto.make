# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by Robert Schwebel
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

$(STATEDIR)/host-xcb-proto.get: $(STATEDIR)/xcb-proto.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xcb-proto.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XCB_PROTO_DIR))
	@$(call extract, XCB_PROTO, $(HOST_BUILDDIR))
	@$(call patchin, XCB_PROTO, $(HOST_XCB_PROTO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XCB_PROTO_PATH	:= PATH=$(HOST_PATH)
HOST_XCB_PROTO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XCB_PROTO_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xcb-proto.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XCB_PROTO_DIR)/config.cache)
	cd $(HOST_XCB_PROTO_DIR) && \
		$(HOST_XCB_PROTO_PATH) $(HOST_XCB_PROTO_ENV) \
		./configure $(HOST_XCB_PROTO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xcb-proto.compile:
	@$(call targetinfo, $@)
	cd $(HOST_XCB_PROTO_DIR) && $(HOST_XCB_PROTO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xcb-proto.install:
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

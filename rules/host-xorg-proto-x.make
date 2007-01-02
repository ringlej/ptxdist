# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_X) += host-xorg-proto-x

#
# Paths and names
#
HOST_XORG_PROTO_X_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_X)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-x_get: $(STATEDIR)/host-xorg-proto-x.get

$(STATEDIR)/host-xorg-proto-x.get: $(STATEDIR)/xorg-proto-x.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-x_extract: $(STATEDIR)/host-xorg-proto-x.extract

$(STATEDIR)/host-xorg-proto-x.extract: $(host-xorg-proto-x_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_X_DIR))
	@$(call extract, XORG_PROTO_X, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_X, $(HOST_XORG_PROTO_X_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-x_prepare: $(STATEDIR)/host-xorg-proto-x.prepare

HOST_XORG_PROTO_X_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_X_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_X_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-x.prepare: $(host-xorg-proto-x_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_X_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_X_DIR) && \
		$(HOST_XORG_PROTO_X_PATH) $(HOST_XORG_PROTO_X_ENV) \
		./configure $(HOST_XORG_PROTO_X_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-x_compile: $(STATEDIR)/host-xorg-proto-x.compile

$(STATEDIR)/host-xorg-proto-x.compile: $(host-xorg-proto-x_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_X_DIR) && $(HOST_XORG_PROTO_X_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-x_install: $(STATEDIR)/host-xorg-proto-x.install

$(STATEDIR)/host-xorg-proto-x.install: $(host-xorg-proto-x_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_X,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-x_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-x.*
	rm -rf $(HOST_XORG_PROTO_X_DIR)

# vim: syntax=make

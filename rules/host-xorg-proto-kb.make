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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_KB) += host-xorg-proto-kb

#
# Paths and names
#
HOST_XORG_PROTO_KB_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_KB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-kb_get: $(STATEDIR)/host-xorg-proto-kb.get

$(STATEDIR)/host-xorg-proto-kb.get: $(STATEDIR)/xorg-proto-kb.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-kb_extract: $(STATEDIR)/host-xorg-proto-kb.extract

$(STATEDIR)/host-xorg-proto-kb.extract: $(host-xorg-proto-kb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_KB_DIR))
	@$(call extract, XORG_PROTO_KB, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_KB, $(HOST_XORG_PROTO_KB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-kb_prepare: $(STATEDIR)/host-xorg-proto-kb.prepare

HOST_XORG_PROTO_KB_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_KB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_KB_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-kb.prepare: $(host-xorg-proto-kb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_KB_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_KB_DIR) && \
		$(HOST_XORG_PROTO_KB_PATH) $(HOST_XORG_PROTO_KB_ENV) \
		./configure $(HOST_XORG_PROTO_KB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-kb_compile: $(STATEDIR)/host-xorg-proto-kb.compile

$(STATEDIR)/host-xorg-proto-kb.compile: $(host-xorg-proto-kb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_KB_DIR) && $(HOST_XORG_PROTO_KB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-kb_install: $(STATEDIR)/host-xorg-proto-kb.install

$(STATEDIR)/host-xorg-proto-kb.install: $(host-xorg-proto-kb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_KB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-kb_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-kb.*
	rm -rf $(HOST_XORG_PROTO_KB_DIR)

# vim: syntax=make

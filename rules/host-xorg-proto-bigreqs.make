# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_BIGREQS) += host-xorg-proto-bigreqs

#
# Paths and names
#
HOST_XORG_PROTO_BIGREQS_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_BIGREQS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_get: $(STATEDIR)/host-xorg-proto-bigreqs.get

$(STATEDIR)/host-xorg-proto-bigreqs.get: $(STATEDIR)/xorg-proto-bigreqs.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_extract: $(STATEDIR)/host-xorg-proto-bigreqs.extract

$(STATEDIR)/host-xorg-proto-bigreqs.extract: $(host-xorg-proto-bigreqs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_BIGREQS_DIR))
	@$(call extract, XORG_PROTO_BIGREQS, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_BIGREQS, $(HOST_XORG_PROTO_BIGREQS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_prepare: $(STATEDIR)/host-xorg-proto-bigreqs.prepare

HOST_XORG_PROTO_BIGREQS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_BIGREQS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_BIGREQS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-bigreqs.prepare: $(host-xorg-proto-bigreqs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_BIGREQS_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_BIGREQS_DIR) && \
		$(HOST_XORG_PROTO_BIGREQS_PATH) $(HOST_XORG_PROTO_BIGREQS_ENV) \
		./configure $(HOST_XORG_PROTO_BIGREQS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_compile: $(STATEDIR)/host-xorg-proto-bigreqs.compile

$(STATEDIR)/host-xorg-proto-bigreqs.compile: $(host-xorg-proto-bigreqs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_BIGREQS_DIR) && $(HOST_XORG_PROTO_BIGREQS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_install: $(STATEDIR)/host-xorg-proto-bigreqs.install

$(STATEDIR)/host-xorg-proto-bigreqs.install: $(host-xorg-proto-bigreqs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_BIGREQS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-bigreqs_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-bigreqs.*
	rm -rf $(HOST_XORG_PROTO_BIGREQS_DIR)

# vim: syntax=make

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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_BIGREQS) += host-proto-xorg-bigreqs

#
# Paths and names
#
HOST_XORG_PROTO_BIGREQS		= $(XORG_PROTO_BIGREQS)
HOST_XORG_PROTO_BIGREQS_DIR	= $(HOST_BUILDDIR)/$(HOST_XORG_PROTO_BIGREQS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_get: $(STATEDIR)/host-proto-xorg-bigreqs.get

$(STATEDIR)/host-proto-xorg-bigreqs.get: $(STATEDIR)/xorg-proto-xext.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_extract: $(STATEDIR)/host-proto-xorg-bigreqs.extract

$(STATEDIR)/host-proto-xorg-bigreqs.extract: $(host-proto-xorg-bigreqs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_BIGREQS_DIR))
	@$(call extract, XORG_PROTO_BIGREQS, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_BIGREQS, $(HOST_XORG_PROTO_BIGREQS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_prepare: $(STATEDIR)/host-proto-xorg-bigreqs.prepare

HOST_XORG_PROTO_BIGREQS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_BIGREQS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_BIGREQS_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-proto-xorg-bigreqs.prepare: $(host-proto-xorg-bigreqs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_BIGREQS_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_BIGREQS_DIR) && \
		$(HOST_XORG_PROTO_BIGREQS_PATH) $(HOST_XORG_PROTO_BIGREQS_ENV) \
		./configure $(HOST_XORG_PROTO_BIGREQS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_compile: $(STATEDIR)/host-proto-xorg-bigreqs.compile

$(STATEDIR)/host-proto-xorg-bigreqs.compile: $(host-proto-xorg-bigreqs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_BIGREQS_DIR) && $(HOST_XORG_PROTO_BIGREQS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_install: $(STATEDIR)/host-proto-xorg-bigreqs.install

$(STATEDIR)/host-proto-xorg-bigreqs.install: $(host-proto-xorg-bigreqs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_BIGREQS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-proto-xorg-bigreqs_clean:
	rm -rf $(STATEDIR)/host-proto-xorg-bigreqs.*
	rm -rf $(HOST_XORG_PROTO_BIGREQS_DIR)

# vim: syntax=make

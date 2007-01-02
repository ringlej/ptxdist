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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_XCMISC) += host-proto-xorg-xcmisc

#
# Paths and names
#
HOST_XORG_PROTO_XCMISC		= $(XORG_PROTO_XCMISC)
HOST_XORG_PROTO_XCMISC_DIR	= $(HOST_BUILDDIR)/$(HOST_XORG_PROTO_XCMISC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_get: $(STATEDIR)/host-proto-xorg-xcmisc.get

$(STATEDIR)/host-proto-xorg-xcmisc.get: $(STATEDIR)/xorg-proto-xext.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_extract: $(STATEDIR)/host-proto-xorg-xcmisc.extract

$(STATEDIR)/host-proto-xorg-xcmisc.extract: $(host-proto-xorg-xcmisc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XCMISC_DIR))
	@$(call extract, XORG_PROTO_XCMISC, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_XCMISC, $(HOST_XORG_PROTO_XCMISC_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_prepare: $(STATEDIR)/host-proto-xorg-xcmisc.prepare

HOST_XORG_PROTO_XCMISC_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_XCMISC_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_XCMISC_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-proto-xorg-xcmisc.prepare: $(host-proto-xorg-xcmisc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XCMISC_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_XCMISC_DIR) && \
		$(HOST_XORG_PROTO_XCMISC_PATH) $(HOST_XORG_PROTO_XCMISC_ENV) \
		./configure $(HOST_XORG_PROTO_XCMISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_compile: $(STATEDIR)/host-proto-xorg-xcmisc.compile

$(STATEDIR)/host-proto-xorg-xcmisc.compile: $(host-proto-xorg-xcmisc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_XCMISC_DIR) && $(HOST_XORG_PROTO_XCMISC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_install: $(STATEDIR)/host-proto-xorg-xcmisc.install

$(STATEDIR)/host-proto-xorg-xcmisc.install: $(host-proto-xorg-xcmisc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_XCMISC,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-proto-xorg-xcmisc_clean:
	rm -rf $(STATEDIR)/host-proto-xorg-xcmisc.*
	rm -rf $(HOST_XORG_PROTO_XCMISC_DIR)

# vim: syntax=make

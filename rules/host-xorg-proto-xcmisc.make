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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_XCMISC) += host-xorg-proto-xcmisc

#
# Paths and names
#
HOST_XORG_PROTO_XCMISC_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_XCMISC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_get: $(STATEDIR)/host-xorg-proto-xcmisc.get

$(STATEDIR)/host-xorg-proto-xcmisc.get: $(STATEDIR)/xorg-proto-xcmisc.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_extract: $(STATEDIR)/host-xorg-proto-xcmisc.extract

$(STATEDIR)/host-xorg-proto-xcmisc.extract: $(host-xorg-proto-xcmisc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XCMISC_DIR))
	@$(call extract, XORG_PROTO_XCMISC, $(HOST_BUILDDIR))
	@$(call patchin, XORG_PROTO_XCMISC, $(HOST_XORG_PROTO_XCMISC_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_prepare: $(STATEDIR)/host-xorg-proto-xcmisc.prepare

HOST_XORG_PROTO_XCMISC_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_XCMISC_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_XCMISC_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-proto-xcmisc.prepare: $(host-xorg-proto-xcmisc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_PROTO_XCMISC_DIR)/config.cache)
	cd $(HOST_XORG_PROTO_XCMISC_DIR) && \
		$(HOST_XORG_PROTO_XCMISC_PATH) $(HOST_XORG_PROTO_XCMISC_ENV) \
		./configure $(HOST_XORG_PROTO_XCMISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_compile: $(STATEDIR)/host-xorg-proto-xcmisc.compile

$(STATEDIR)/host-xorg-proto-xcmisc.compile: $(host-xorg-proto-xcmisc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_PROTO_XCMISC_DIR) && $(HOST_XORG_PROTO_XCMISC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_install: $(STATEDIR)/host-xorg-proto-xcmisc.install

$(STATEDIR)/host-xorg-proto-xcmisc.install: $(host-xorg-proto-xcmisc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_PROTO_XCMISC,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-xcmisc.*
	rm -rf $(HOST_XORG_PROTO_XCMISC_DIR)

# vim: syntax=make

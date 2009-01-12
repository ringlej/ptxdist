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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XDMCP) += host-xorg-lib-xdmcp

#
# Paths and names
#
HOST_XORG_LIB_XDMCP_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_XDMCP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_get: $(STATEDIR)/host-xorg-lib-xdmcp.get

$(STATEDIR)/host-xorg-lib-xdmcp.get: $(STATEDIR)/xorg-lib-xdmcp.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_extract: $(STATEDIR)/host-xorg-lib-xdmcp.extract

$(STATEDIR)/host-xorg-lib-xdmcp.extract: $(host-xorg-lib-xdmcp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XDMCP_DIR))
	@$(call extract, XORG_LIB_XDMCP, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_XDMCP, $(HOST_XORG_LIB_XDMCP_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_prepare: $(STATEDIR)/host-xorg-lib-xdmcp.prepare

HOST_XORG_LIB_XDMCP_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XDMCP_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XDMCP_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-lib-xdmcp.prepare: $(host-xorg-lib-xdmcp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XDMCP_DIR)/config.cache)
	cd $(HOST_XORG_LIB_XDMCP_DIR) && \
		$(HOST_XORG_LIB_XDMCP_PATH) $(HOST_XORG_LIB_XDMCP_ENV) \
		./configure $(HOST_XORG_LIB_XDMCP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_compile: $(STATEDIR)/host-xorg-lib-xdmcp.compile

$(STATEDIR)/host-xorg-lib-xdmcp.compile: $(host-xorg-lib-xdmcp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_LIB_XDMCP_DIR) && $(HOST_XORG_LIB_XDMCP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_install: $(STATEDIR)/host-xorg-lib-xdmcp.install

$(STATEDIR)/host-xorg-lib-xdmcp.install: $(host-xorg-lib-xdmcp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_XDMCP,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-xdmcp_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-xdmcp.*
	rm -rf $(HOST_XORG_LIB_XDMCP_DIR)

# vim: syntax=make

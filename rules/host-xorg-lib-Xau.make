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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XAU) += host-xorg-lib-xau

#
# Paths and names
#
HOST_XORG_LIB_XAU_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-xau_get: $(STATEDIR)/host-xorg-lib-xau.get

$(STATEDIR)/host-xorg-lib-xau.get: $(STATEDIR)/xorg-lib-xau.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-xau_extract: $(STATEDIR)/host-xorg-lib-xau.extract

$(STATEDIR)/host-xorg-lib-xau.extract: $(host-xorg-lib-xau_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XAU_DIR))
	@$(call extract, XORG_LIB_XAU, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_XAU, $(HOST_XORG_LIB_XAU_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-xau_prepare: $(STATEDIR)/host-xorg-lib-xau.prepare

HOST_XORG_LIB_XAU_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XAU_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XAU_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-lib-xau.prepare: $(host-xorg-lib-xau_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_XAU_DIR)/config.cache)
	cd $(HOST_XORG_LIB_XAU_DIR) && \
		$(HOST_XORG_LIB_XAU_PATH) $(HOST_XORG_LIB_XAU_ENV) \
		./configure $(HOST_XORG_LIB_XAU_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-xau_compile: $(STATEDIR)/host-xorg-lib-xau.compile

$(STATEDIR)/host-xorg-lib-xau.compile: $(host-xorg-lib-xau_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_LIB_XAU_DIR) && $(HOST_XORG_LIB_XAU_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-xau_install: $(STATEDIR)/host-xorg-lib-xau.install

$(STATEDIR)/host-xorg-lib-xau.install: $(host-xorg-lib-xau_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_XAU,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-xau_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-xau.*
	rm -rf $(HOST_XORG_LIB_XAU_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_MKFONTDIR) += host-xorg-app-mkfontdir

#
# Paths and names
#
HOST_XORG_APP_MKFONTDIR_DIR	= $(HOST_BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_get: $(STATEDIR)/host-xorg-app-mkfontdir.get

$(STATEDIR)/host-xorg-app-mkfontdir.get: $(STATEDIR)/xorg-app-mkfontdir.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_extract: $(STATEDIR)/host-xorg-app-mkfontdir.extract

$(STATEDIR)/host-xorg-app-mkfontdir.extract: $(host-xorg-app-mkfontdir_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_MKFONTDIR_DIR))
	@$(call extract, XORG_APP_MKFONTDIR, $(HOST_BUILDDIR))
	@$(call patchin, XORG_APP_MKFONTDIR, $(HOST_XORG_APP_MKFONTDIR_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_prepare: $(STATEDIR)/host-xorg-app-mkfontdir.prepare

HOST_XORG_APP_MKFONTDIR_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_APP_MKFONTDIR_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_APP_MKFONTDIR_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-xorg-app-mkfontdir.prepare: $(host-xorg-app-mkfontdir_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_APP_MKFONTDIR_DIR)/config.cache)
	cd $(HOST_XORG_APP_MKFONTDIR_DIR) && \
		$(HOST_XORG_APP_MKFONTDIR_PATH) $(HOST_XORG_APP_MKFONTDIR_ENV) \
		./configure $(HOST_XORG_APP_MKFONTDIR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_compile: $(STATEDIR)/host-xorg-app-mkfontdir.compile

$(STATEDIR)/host-xorg-app-mkfontdir.compile: $(host-xorg-app-mkfontdir_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_XORG_APP_MKFONTDIR_DIR) && $(HOST_XORG_APP_MKFONTDIR_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_install: $(STATEDIR)/host-xorg-app-mkfontdir.install

$(STATEDIR)/host-xorg-app-mkfontdir.install: $(host-xorg-app-mkfontdir_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_APP_MKFONTDIR,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-app-mkfontdir_clean:
	rm -rf $(STATEDIR)/host-xorg-app-mkfontdir.*
	rm -rf $(HOST_XORG_APP_MKFONTDIR_DIR)

# vim: syntax=make

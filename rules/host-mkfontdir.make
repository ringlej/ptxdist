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
HOST_PACKAGES-$(PTXCONF_HOST_MKFONTDIR) += host-mkfontdir

#
# Paths and names
#
HOST_MKFONTDIR_VERSION	:= 1.0.2
HOST_MKFONTDIR		:= mkfontdir-X11R7.1-$(HOST_MKFONTDIR_VERSION)
HOST_MKFONTDIR_SUFFIX		:= tar.bz2
HOST_MKFONTDIR_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/app/$(HOST_MKFONTDIR).$(HOST_MKFONTDIR_SUFFIX)
HOST_MKFONTDIR_SOURCE		:= $(SRCDIR)/$(HOST_MKFONTDIR).$(HOST_MKFONTDIR_SUFFIX)
HOST_MKFONTDIR_DIR		:= $(HOST_BUILDDIR)/$(HOST_MKFONTDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mkfontdir_get: $(STATEDIR)/host-mkfontdir.get

$(STATEDIR)/host-mkfontdir.get: $(host-mkfontdir_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_MKFONTDIR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_MKFONTDIR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mkfontdir_extract: $(STATEDIR)/host-mkfontdir.extract

$(STATEDIR)/host-mkfontdir.extract: $(host-mkfontdir_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKFONTDIR_DIR))
	@$(call extract, HOST_MKFONTDIR, $(HOST_BUILDDIR))
	@$(call patchin, HOST_MKFONTDIR, $(HOST_MKFONTDIR_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mkfontdir_prepare: $(STATEDIR)/host-mkfontdir.prepare

HOST_MKFONTDIR_PATH	:= PATH=$(HOST_PATH)
HOST_MKFONTDIR_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MKFONTDIR_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-mkfontdir.prepare: $(host-mkfontdir_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKFONTDIR_DIR)/config.cache)
	cd $(HOST_MKFONTDIR_DIR) && \
		$(HOST_MKFONTDIR_PATH) $(HOST_MKFONTDIR_ENV) \
		./configure $(HOST_MKFONTDIR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mkfontdir_compile: $(STATEDIR)/host-mkfontdir.compile

$(STATEDIR)/host-mkfontdir.compile: $(host-mkfontdir_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MKFONTDIR_DIR) && $(HOST_MKFONTDIR_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mkfontdir_install: $(STATEDIR)/host-mkfontdir.install

$(STATEDIR)/host-mkfontdir.install: $(host-mkfontdir_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MKFONTDIR,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mkfontdir_clean:
	rm -rf $(STATEDIR)/host-mkfontdir.*
	rm -rf $(HOST_MKFONTDIR_DIR)

# vim: syntax=make

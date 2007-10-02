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
HOST_PACKAGES-$(PTXCONF_HOST_GCONF) += host-gconf

#
# Paths and names
#
HOST_GCONF_VERSION	:= 2.19.1
HOST_GCONF		:= GConf-$(HOST_GCONF_VERSION)
HOST_GCONF_SUFFIX	:= tar.bz2
HOST_GCONF_URL		:= ftp://ftp.gnome.org/pub/gnome/sources/GConf/2.19/$(HOST_GCONF).$(HOST_GCONF_SUFFIX)
HOST_GCONF_SOURCE	:= $(SRCDIR)/$(HOST_GCONF).$(HOST_GCONF_SUFFIX)
HOST_GCONF_DIR		:= $(HOST_BUILDDIR)/$(HOST_GCONF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-gconf_get: $(STATEDIR)/host-gconf.get

$(STATEDIR)/host-gconf.get: $(host-gconf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_GCONF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_GCONF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-gconf_extract: $(STATEDIR)/host-gconf.extract

$(STATEDIR)/host-gconf.extract: $(host-gconf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GCONF_DIR))
	@$(call extract, HOST_GCONF, $(HOST_BUILDDIR))
	@$(call patchin, HOST_GCONF, $(HOST_GCONF_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-gconf_prepare: $(STATEDIR)/host-gconf.prepare

HOST_GCONF_PATH	:= PATH=$(HOST_PATH)
HOST_GCONF_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GCONF_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-gconf.prepare: $(host-gconf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GCONF_DIR)/config.cache)
	cd $(HOST_GCONF_DIR) && \
		$(HOST_GCONF_PATH) $(HOST_GCONF_ENV) \
		./configure $(HOST_GCONF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-gconf_compile: $(STATEDIR)/host-gconf.compile

$(STATEDIR)/host-gconf.compile: $(host-gconf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GCONF_DIR) && $(HOST_GCONF_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-gconf_install: $(STATEDIR)/host-gconf.install

$(STATEDIR)/host-gconf.install: $(host-gconf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GCONF,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gconf_clean:
	rm -rf $(STATEDIR)/host-gconf.*
	rm -rf $(HOST_GCONF_DIR)

# vim: syntax=make

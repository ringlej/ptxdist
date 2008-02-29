# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_INTLTOOL) += host-intltool

#
# Paths and names
#
HOST_INTLTOOL_VERSION	:= 0.37.0
HOST_INTLTOOL		:= intltool-$(HOST_INTLTOOL_VERSION)
HOST_INTLTOOL_SUFFIX	:= tar.bz2
HOST_INTLTOOL_URL	:= http://ftp.gnome.org/pub/gnome/sources/intltool/0.37/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_SOURCE	:= $(SRCDIR)/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_DIR	:= $(HOST_BUILDDIR)/$(HOST_INTLTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-intltool_get: $(STATEDIR)/host-intltool.get

$(STATEDIR)/host-intltool.get: $(host-intltool_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_INTLTOOL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_INTLTOOL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-intltool_extract: $(STATEDIR)/host-intltool.extract

$(STATEDIR)/host-intltool.extract: $(host-intltool_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_INTLTOOL_DIR))
	@$(call extract, HOST_INTLTOOL, $(HOST_BUILDDIR))
	@$(call patchin, HOST_INTLTOOL, $(HOST_INTLTOOL_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-intltool_prepare: $(STATEDIR)/host-intltool.prepare

HOST_INTLTOOL_PATH	:= PATH=$(HOST_PATH)
HOST_INTLTOOL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_INTLTOOL_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-intltool.prepare: $(host-intltool_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_INTLTOOL_DIR)/config.cache)
	cd $(HOST_INTLTOOL_DIR) && \
		$(HOST_INTLTOOL_PATH) $(HOST_INTLTOOL_ENV) \
		./configure $(HOST_INTLTOOL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-intltool_compile: $(STATEDIR)/host-intltool.compile

$(STATEDIR)/host-intltool.compile: $(host-intltool_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_INTLTOOL_DIR) && $(HOST_INTLTOOL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-intltool_install: $(STATEDIR)/host-intltool.install

$(STATEDIR)/host-intltool.install: $(host-intltool_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_INTLTOOL,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-intltool_clean:
	rm -rf $(STATEDIR)/host-intltool.*
	rm -rf $(HOST_INTLTOOL_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHTOOL) += ethtool

#
# Paths and names
#
ETHTOOL_VERSION	:= 6
ETHTOOL		:= ethtool-$(ETHTOOL_VERSION)
ETHTOOL_SUFFIX	:= tar.gz
ETHTOOL_URL	:= $(PTXCONF_SETUP_SFMIRROR)/gkernel/$(ETHTOOL).$(ETHTOOL_SUFFIX)
ETHTOOL_SOURCE	:= $(SRCDIR)/$(ETHTOOL).$(ETHTOOL_SUFFIX)
ETHTOOL_DIR	:= $(BUILDDIR)/$(ETHTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ethtool_get: $(STATEDIR)/ethtool.get

$(STATEDIR)/ethtool.get: $(ethtool_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ETHTOOL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ETHTOOL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ethtool_extract: $(STATEDIR)/ethtool.extract

$(STATEDIR)/ethtool.extract: $(ethtool_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHTOOL_DIR))
	@$(call extract, ETHTOOL)
	@$(call patchin, ETHTOOL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ethtool_prepare: $(STATEDIR)/ethtool.prepare

ETHTOOL_PATH	:= PATH=$(CROSS_PATH)
ETHTOOL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ETHTOOL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/ethtool.prepare: $(ethtool_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHTOOL_DIR)/config.cache)
	cd $(ETHTOOL_DIR) && \
		$(ETHTOOL_PATH) $(ETHTOOL_ENV) \
		./configure $(ETHTOOL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ethtool_compile: $(STATEDIR)/ethtool.compile

$(STATEDIR)/ethtool.compile: $(ethtool_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ETHTOOL_DIR) && $(ETHTOOL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ethtool_install: $(STATEDIR)/ethtool.install

$(STATEDIR)/ethtool.install: $(ethtool_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ethtool_targetinstall: $(STATEDIR)/ethtool.targetinstall

$(STATEDIR)/ethtool.targetinstall: $(ethtool_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ethtool)
	@$(call install_fixup, ethtool,PACKAGE,ethtool)
	@$(call install_fixup, ethtool,PRIORITY,optional)
	@$(call install_fixup, ethtool,VERSION,$(ETHTOOL_VERSION))
	@$(call install_fixup, ethtool,SECTION,base)
	@$(call install_fixup, ethtool,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ethtool,DEPENDS,)
	@$(call install_fixup, ethtool,DESCRIPTION,missing)

	@$(call install_copy, ethtool, 0, 0, 0755, $(ETHTOOL_DIR)/ethtool, /usr/sbin/ethtool)

	@$(call install_finish, ethtool)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ethtool_clean:
	rm -rf $(STATEDIR)/ethtool.*
	rm -rf $(PKGDIR)/ethtool_*
	rm -rf $(ETHTOOL_DIR)

# vim: syntax=make

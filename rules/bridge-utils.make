# -*-makefile-*-
# $Id: template 2224 2005-01-20 15:19:18Z rsc $
#
# Copyright (C) 2005 by Gary Thomas <gary@mlbassoc.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BRIDGE_UTILS) += bridge-utils

#
# Paths and names
#
BRIDGE_UTILS_VERSION	= 1.1
BRIDGE_UTILS		= bridge-utils-$(BRIDGE_UTILS_VERSION)
BRIDGE_UTILS_SUFFIX	= tar.gz
BRIDGE_UTILS_URL	= $(PTXCONF_SETUP_SFMIRROR)/bridge/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_SOURCE	= $(SRCDIR)/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_DIR	= $(BUILDDIR)/$(BRIDGE_UTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bridge-utils_get: $(STATEDIR)/bridge-utils.get

$(STATEDIR)/bridge-utils.get: $(bridge-utils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BRIDGE_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BRIDGE_UTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bridge-utils_extract: $(STATEDIR)/bridge-utils.extract

$(STATEDIR)/bridge-utils.extract: $(bridge-utils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BRIDGE_UTILS_DIR))
	@$(call extract, BRIDGE_UTILS)
	@$(call patchin, BRIDGE_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bridge-utils_prepare: $(STATEDIR)/bridge-utils.prepare

BRIDGE_UTILS_PATH	=  PATH=$(CROSS_PATH)
BRIDGE_UTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
BRIDGE_UTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/bridge-utils.prepare: $(bridge-utils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BRIDGE_UTILS_DIR)/config.cache)
	cd $(BRIDGE_UTILS_DIR) && \
		$(BRIDGE_UTILS_PATH) $(BRIDGE_UTILS_ENV) \
		./configure $(BRIDGE_UTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bridge-utils_compile: $(STATEDIR)/bridge-utils.compile

$(STATEDIR)/bridge-utils.compile: $(bridge-utils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BRIDGE_UTILS_DIR) && $(BRIDGE_UTILS_ENV) $(BRIDGE_UTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bridge-utils_install: $(STATEDIR)/bridge-utils.install

$(STATEDIR)/bridge-utils.install: $(bridge-utils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BRIDGE_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bridge-utils_targetinstall: $(STATEDIR)/bridge-utils.targetinstall

$(STATEDIR)/bridge-utils.targetinstall: $(bridge-utils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,   bridge-utils)
	@$(call install_fixup,  bridge-utils,PACKAGE,bridge-utils)
	@$(call install_fixup,  bridge-utils,PRIORITY,optional)
	@$(call install_fixup,  bridge-utils,VERSION,$(BRIDGE_UTILS_VERSION))
	@$(call install_fixup,  bridge-utils,SECTION,base)
	@$(call install_fixup,  bridge-utils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,  bridge-utils,DEPENDS,)
	@$(call install_fixup,  bridge-utils,DESCRIPTION,missing)
	@$(call install_copy,   bridge-utils, 0, 0, 0755, $(BRIDGE_UTILS_DIR)/brctl/brctl, /usr/sbin/brctl)
	@$(call install_finish, bridge-utils)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bridge-utils_clean:
	rm -rf $(STATEDIR)/bridge-utils.*
	rm -rf $(BRIDGE_UTILS_DIR)

# vim: syntax=make

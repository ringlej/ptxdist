# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: ipkgize

#
# We provide this package
#
PACKAGES-$(PTXCONF_SUDO) += sudo

#
# Paths and names
#
SUDO_VERSION	= 1.6.8
SUDO		= sudo-$(SUDO_VERSION)
SUDO_SUFFIX	= tar.gz
SUDO_URL	= http://www.courtesan.com/sudo/dist/$(SUDO).$(SUDO_SUFFIX)
SUDO_SOURCE	= $(SRCDIR)/$(SUDO).$(SUDO_SUFFIX)
SUDO_DIR	= $(BUILDDIR)/$(SUDO)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sudo_get: $(STATEDIR)/sudo.get

$(STATEDIR)/sudo.get: $(sudo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SUDO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SUDO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sudo_extract: $(STATEDIR)/sudo.extract

$(STATEDIR)/sudo.extract: $(sudo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR))
	@$(call extract, $(SUDO_SOURCE))
	@$(call patchin, $(SUDO))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sudo_prepare: $(STATEDIR)/sudo.prepare

SUDO_PATH	=  PATH=$(CROSS_PATH)
SUDO_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
SUDO_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sudo.prepare: $(sudo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR)/config.cache)
	cd $(SUDO_DIR) && \
		$(SUDO_PATH) $(SUDO_ENV) \
		./configure $(SUDO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sudo_compile: $(STATEDIR)/sudo.compile

$(STATEDIR)/sudo.compile: $(sudo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SUDO_DIR) && $(SUDO_ENV) $(SUDO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sudo_install: $(STATEDIR)/sudo.install

$(STATEDIR)/sudo.install: $(sudo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SUDO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sudo_targetinstall: $(STATEDIR)/sudo.targetinstall

$(STATEDIR)/sudo.targetinstall: $(sudo_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sudo_clean:
	rm -rf $(STATEDIR)/sudo.*
	rm -rf $(SUDO_DIR)

# vim: syntax=make

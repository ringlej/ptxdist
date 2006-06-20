# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSUTILS) += sysutils

#
# Paths and names
#
SYSUTILS_VERSION	= 0.1.0
SYSUTILS		= sysutils-$(SYSUTILS_VERSION)
SYSUTILS_SUFFIX		= tar.gz
SYSUTILS_URL		= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(SYSUTILS).$(SYSUTILS_SUFFIX)
SYSUTILS_SOURCE		= $(SRCDIR)/$(SYSUTILS).$(SYSUTILS_SUFFIX)
SYSUTILS_DIR		= $(BUILDDIR)/$(SYSUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysutils_get: $(STATEDIR)/sysutils.get

$(STATEDIR)/sysutils.get: $(sysutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SYSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SYSUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysutils_extract: $(STATEDIR)/sysutils.extract

$(STATEDIR)/sysutils.extract: $(sysutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSUTILS_DIR))
	@$(call extract, SYSUTILS)
	@$(call patchin, SYSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysutils_prepare: $(STATEDIR)/sysutils.prepare

SYSUTILS_PATH	=  PATH=$(CROSS_PATH)
SYSUTILS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/sysutils.prepare: $(sysutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysutils_compile: $(STATEDIR)/sysutils.compile

$(STATEDIR)/sysutils.compile: $(sysutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SYSUTILS_DIR) && $(SYSUTILS_ENV) $(SYSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysutils_install: $(STATEDIR)/sysutils.install

$(STATEDIR)/sysutils.install: $(sysutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysutils_targetinstall: $(STATEDIR)/sysutils.targetinstall

$(STATEDIR)/sysutils.targetinstall: $(sysutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sysutils)
	@$(call install_fixup, sysutils,PACKAGE,sysutils)
	@$(call install_fixup, sysutils,PRIORITY,optional)
	@$(call install_fixup, sysutils,VERSION,$(SYSUTILS_VERSION))
	@$(call install_fixup, sysutils,SECTION,base)
	@$(call install_fixup, sysutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, sysutils,DEPENDS,)
	@$(call install_fixup, sysutils,DESCRIPTION,missing)

ifdef PTXCONF_SYSUTILS_LSBUS
	@$(call install_copy, sysutils, 0, 0, 0755, $(SYSUTILS_DIR)/cmd/lsbus, /usr/sbin/lsbus)
endif
ifdef PTXCONF_SYSUTILS_SYSTOOL
	@$(call install_copy, sysutils, 0, 0, 0755, $(SYSUTILS_DIR)/cmd/systool, /usr/sbin/systool)
endif
	@$(call install_finish, sysutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysutils_clean:
	rm -rf $(STATEDIR)/sysutils.*
	rm -rf $(SYSUTILS_DIR)

# vim: syntax=make

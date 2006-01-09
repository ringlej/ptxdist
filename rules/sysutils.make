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
SYSUTILS_URL		= http://www.de.kernel.org/pub/linux/utils/kernel/hotplug/$(SYSUTILS).$(SYSUTILS_SUFFIX)
SYSUTILS_SOURCE		= $(SRCDIR)/$(SYSUTILS).$(SYSUTILS_SUFFIX)
SYSUTILS_DIR		= $(BUILDDIR)/$(SYSUTILS)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysutils_get: $(STATEDIR)/sysutils.get

sysutils_get_deps = $(SYSUTILS_SOURCE)

$(STATEDIR)/sysutils.get: $(sysutils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(SYSUTILS))
	@$(call touch, $@)

$(SYSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SYSUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysutils_extract: $(STATEDIR)/sysutils.extract

sysutils_extract_deps = $(STATEDIR)/sysutils.get

$(STATEDIR)/sysutils.extract: $(sysutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSUTILS_DIR))
	@$(call extract, $(SYSUTILS_SOURCE))
	@$(call patchin, $(SYSUTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysutils_prepare: $(STATEDIR)/sysutils.prepare

#
# dependencies
#
sysutils_prepare_deps = \
	$(STATEDIR)/sysutils.extract \
	$(STATEDIR)/virtual-xchain.install

SYSUTILS_PATH	=  PATH=$(CROSS_PATH)
SYSUTILS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/sysutils.prepare: $(sysutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysutils_compile: $(STATEDIR)/sysutils.compile

sysutils_compile_deps = $(STATEDIR)/sysutils.prepare

$(STATEDIR)/sysutils.compile: $(sysutils_compile_deps)
	@$(call targetinfo, $@)
	cd $(SYSUTILS_DIR) && $(SYSUTILS_ENV) $(SYSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysutils_install: $(STATEDIR)/sysutils.install

$(STATEDIR)/sysutils.install: $(STATEDIR)/sysutils.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysutils_targetinstall: $(STATEDIR)/sysutils.targetinstall

sysutils_targetinstall_deps = $(STATEDIR)/sysutils.compile

$(STATEDIR)/sysutils.targetinstall: $(sysutils_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sysutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SYSUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_SYSUTILS_LSBUS
	@$(call install_copy, 0, 0, 0755, $(SYSUTILS_DIR)/cmd/lsbus, /usr/sbin/lsbus)
endif
ifdef PTXCONF_SYSUTILS_SYSTOOL
	@$(call install_copy, 0, 0, 0755, $(SYSUTILS_DIR)/cmd/systool, /usr/sbin/systool)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysutils_clean:
	rm -rf $(STATEDIR)/sysutils.*
	rm -rf $(SYSUTILS_DIR)

# vim: syntax=make

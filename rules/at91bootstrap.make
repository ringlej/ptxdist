# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Remy Bohmer <linux@bohmer.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AT91BOOTSTRAP) += at91bootstrap

#
# Paths and names
#
AT91BOOTSTRAP_VERSION	:= $(call remove_quotes,$(PTXCONF_AT91BOOTSTRAP_VERSION))
AT91BOOTSTRAP		:= AT91Bootstrap$(AT91BOOTSTRAP_VERSION)
AT91BOOTSTRAP_EXTRACT	:= Bootstrap-v$(AT91BOOTSTRAP_VERSION)
AT91BOOTSTRAP_SUFFIX	:= zip
AT91BOOTSTRAP_URL	:= http://www.atmel.com/dyn/resources/prod_documents/$(AT91BOOTSTRAP).$(AT91BOOTSTRAP_SUFFIX)
AT91BOOTSTRAP_SOURCE	:= $(SRCDIR)/$(AT91BOOTSTRAP).$(AT91BOOTSTRAP_SUFFIX)
AT91BOOTSTRAP_DIR	:= $(BUILDDIR)/$(AT91BOOTSTRAP_EXTRACT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

at91bootstrap_get: $(STATEDIR)/at91bootstrap.get

$(STATEDIR)/at91bootstrap.get: $(at91bootstrap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(AT91BOOTSTRAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, AT91BOOTSTRAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

at91bootstrap_extract: $(STATEDIR)/at91bootstrap.extract

$(STATEDIR)/at91bootstrap.extract: $(at91bootstrap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(AT91BOOTSTRAP_DIR))
	@$(call extract, AT91BOOTSTRAP)
	@$(call patchin, AT91BOOTSTRAP_EXTRACT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

at91bootstrap_prepare: $(STATEDIR)/at91bootstrap.prepare

$(STATEDIR)/at91bootstrap.prepare: $(at91bootstrap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

at91bootstrap_compile: $(STATEDIR)/at91bootstrap.compile

AT91BOOTSTRAP_PATH	:= PATH=$(CROSS_PATH)
AT91BOOTSTRAP_ENV 	:= CROSS_COMPILE=$(COMPILER_PREFIX)

ifdef PTXCONF_AT91BOOTSTRAP_BOOT_DATAFLASH
AT91BOOTSTRAP_BOOTMEDIA := dataflash
endif
ifdef PTXCONF_AT91BOOTSTRAP_BOOT_NAND
AT91BOOTSTRAP_BOOTMEDIA := nandflash
endif

AT91BOOTSTRAP_BOARDDIR  := $(AT91BOOTSTRAP_DIR)/board/${PTXCONF_AT91BOOTSTRAP_CONFIG}/$(AT91BOOTSTRAP_BOOTMEDIA)

$(STATEDIR)/at91bootstrap.compile: $(at91bootstrap_compile_deps_default)
	@$(call targetinfo, $@)
	@cd $(AT91BOOTSTRAP_BOARDDIR) && $(AT91BOOTSTRAP_PATH) $(AT91BOOTSTRAP_ENV) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

at91bootstrap_install: $(STATEDIR)/at91bootstrap.install

$(STATEDIR)/at91bootstrap.install: $(at91bootstrap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

at91bootstrap_targetinstall: $(STATEDIR)/at91bootstrap.targetinstall

$(STATEDIR)/at91bootstrap.targetinstall: $(at91bootstrap_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@cp $(AT91BOOTSTRAP_BOARDDIR)/$(AT91BOOTSTRAP_BOOTMEDIA)_${PTXCONF_AT91BOOTSTRAP_CONFIG}.bin \
				$(IMAGEDIR)/at91bootstrap.bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

at91bootstrap_clean:
	@rm -rf $(STATEDIR)/at91bootstrap.*
	@rm -rf $(IMAGEDIR)/at91bootstrap_*
	@rm -rf $(AT91BOOTSTRAP_DIR)

# vim: syntax=make

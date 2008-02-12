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
ifdef PTXCONF_ARCH_PPC
PACKAGES-$(PTXCONF_DTC) += dtc
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dtc_get: $(STATEDIR)/dtc.get

$(STATEDIR)/dtc.get: $(dtc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DTC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DTC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dtc_extract: $(STATEDIR)/dtc.extract

$(STATEDIR)/dtc.extract: $(dtc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dtc_prepare: $(STATEDIR)/dtc.prepare

$(STATEDIR)/dtc.prepare: $(dtc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dtc_compile: $(STATEDIR)/dtc.compile

$(STATEDIR)/dtc.compile: $(dtc_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dtc_install: $(STATEDIR)/dtc.install

$(STATEDIR)/dtc.install: $(dtc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dtc_targetinstall: $(STATEDIR)/dtc.targetinstall

$(STATEDIR)/dtc.targetinstall: $(dtc_targetinstall_deps_default)
	@$(call targetinfo, $@)
	PATH=$(HOST_PATH) dtc $(PTXCONF_DTC_EXTRA_ARGS) -I dts -O dtb \
		$(PTXCONF_DTC_OFTREE_DTS) > $(IMAGEDIR)/oftree
	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dtc_clean:
	rm -rf $(STATEDIR)/dtc.*
	rm -rf $(IMAGEDIR)/dtc_*
	rm -rf $(DTC_DIR)

# vim: syntax=make

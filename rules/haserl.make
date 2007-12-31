# -*-makefile-*-
#
# Copyright (C) 2007 by University of Illinois
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HASERL) += haserl

#
# Paths and names
#
HASERL_VERSION	:= 0.9.21
HASERL		:= haserl-$(HASERL_VERSION)
HASERL_SUFFIX	:= tar.gz
HASERL_URL	:= $(PTXCONF_SETUP_SFMIRROR)/haserl/$(HASERL).$(HASERL_SUFFIX)
HASERL_SOURCE	:= $(SRCDIR)/$(HASERL).$(HASERL_SUFFIX)
HASERL_DIR	:= $(BUILDDIR)/$(HASERL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

haserl_get: $(STATEDIR)/haserl.get

$(STATEDIR)/haserl.get: $(haserl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HASERL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HASERL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

haserl_extract: $(STATEDIR)/haserl.extract

$(STATEDIR)/haserl.extract: $(haserl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HASERL_DIR))
	@$(call extract, HASERL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

haserl_prepare: $(STATEDIR)/haserl.prepare

HASERL_PATH	:=  PATH=$(CROSS_PATH)
HASERL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
HASERL_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/haserl.prepare: $(haserl_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HASERL_DIR)/config.cache)
	cd $(HASERL_DIR) && \
		$(HASERL_PATH) $(HASERL_ENV) \
		./configure $(HASERL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

haserl_compile: $(STATEDIR)/haserl.compile

$(STATEDIR)/haserl.compile: $(haserl_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HASERL_DIR) && $(HASERL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

haserl_install: $(STATEDIR)/haserl.install

$(STATEDIR)/haserl.install: $(haserl_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HASERL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

haserl_targetinstall: $(STATEDIR)/haserl.targetinstall

$(STATEDIR)/haserl.targetinstall: $(haserl_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, haserl)
	@$(call install_fixup,haserl,PACKAGE,haserl)
	@$(call install_fixup,haserl,PRIORITY,optional)
	@$(call install_fixup,haserl,VERSION,$(HASERL_VERSION))
	@$(call install_fixup,haserl,SECTION,base)
	@$(call install_fixup,haserl,AUTHOR,"N. Angelacos; PTXDist rule: Tom St")
	@$(call install_fixup,haserl,DEPENDS,)
	@$(call install_fixup,haserl,DESCRIPTION,missing)

	@$(call install_copy, haserl, 0, 0, 0755, $(HASERL_DIR)/src/haserl, /usr/bin/haserl)

	@$(call install_finish,haserl)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

haserl_clean:
	rm -rf $(STATEDIR)/haserl.*
	rm -rf $(IMAGEDIR)/haserl_*
	rm -rf $(HASERL_DIR)

# vim: syntax=make


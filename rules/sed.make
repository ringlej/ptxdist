# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by KOAN sas, by Marco Cavallini <m.cavallini@koansoftware.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SED) += sed

#
# Paths and names
#
SED_VERSION	:= 4.1.5
SED		:= sed-$(SED_VERSION)
SED_SUFFIX	:= tar.gz
SED_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/sed/$(SED).$(SED_SUFFIX)
SED_SOURCE	:= $(SRCDIR)/$(SED).$(SED_SUFFIX)
SED_DIR		:= $(BUILDDIR)/$(SED)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sed_get: $(STATEDIR)/sed.get

$(STATEDIR)/sed.get: $(sed_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SED_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SED)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sed_extract: $(STATEDIR)/sed.extract

$(STATEDIR)/sed.extract: $(sed_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SED_DIR))
	@$(call extract, SED)
	@$(call patchin, SED)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sed_prepare: $(STATEDIR)/sed.prepare

SED_PATH	:= PATH=$(CROSS_PATH)
SED_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SED_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sed.prepare: $(sed_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SED_DIR)/config.cache)
	cd $(SED_DIR) && \
		$(SED_PATH) $(SED_ENV) \
		./configure $(SED_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sed_compile: $(STATEDIR)/sed.compile

$(STATEDIR)/sed.compile: $(sed_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SED_DIR) && $(SED_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sed_install: $(STATEDIR)/sed.install

$(STATEDIR)/sed.install: $(sed_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SED)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sed_targetinstall: $(STATEDIR)/sed.targetinstall

$(STATEDIR)/sed.targetinstall: $(sed_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sed)
	@$(call install_fixup, sed,PACKAGE,sed)
	@$(call install_fixup, sed,PRIORITY,optional)
	@$(call install_fixup, sed,VERSION,$(SED_VERSION))
	@$(call install_fixup, sed,SECTION,base)
	@$(call install_fixup, sed,AUTHOR,"Marco Cavallini <m.cavallini\@koansoftware.com>")
	@$(call install_fixup, sed,DEPENDS,)
	@$(call install_fixup, sed,DESCRIPTION,missing)

	@$(call install_copy, sed, 0, 0, 0755, $(SED_DIR)/sed/sed, /usr/bin/sed)

	@$(call install_finish, sed)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sed_clean:
	rm -rf $(STATEDIR)/sed.*
	rm -rf $(IMAGEDIR)/sed_*
	rm -rf $(SED_DIR)

# vim: syntax=make

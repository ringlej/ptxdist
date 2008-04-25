# -*-makefile-*-
#
# Copyright (C) 2007 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NANOCOM) += nanocom

#
# Paths and names
#
NANOCOM_VERSION		:= 1.0
NANOCOM			:= nanocom-$(NANOCOM_VERSION)
NANOCOM_SUFFIX		:= tgz
NANOCOM_URL		:= http://downloads.sourceforge.net/nanocom/$(NANOCOM).$(NANOCOM_SUFFIX)
NANOCOM_SOURCE		:= $(SRCDIR)/$(NANOCOM).$(NANOCOM_SUFFIX)
NANOCOM_DIR		:= $(BUILDDIR)/$(NANOCOM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nanocom_get: $(STATEDIR)/nanocom.get

$(STATEDIR)/nanocom.get: $(nanocom_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NANOCOM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NANOCOM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nanocom_extract: $(STATEDIR)/nanocom.extract

$(STATEDIR)/nanocom.extract: $(nanocom_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NANOCOM_DIR))
	@$(call extract, NANOCOM)
	@$(call patchin, NANOCOM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nanocom_prepare: $(STATEDIR)/nanocom.prepare

NANOCOM_PATH	:= PATH=$(CROSS_PATH)
NANOCOM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
NANOCOM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/nanocom.prepare: $(nanocom_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nanocom_compile: $(STATEDIR)/nanocom.compile

$(STATEDIR)/nanocom.compile: $(nanocom_compile_deps_default)
	@$(call targetinfo, $@)
	@cd $(NANOCOM_DIR) && $(NANOCOM_PATH) $(NANOCOM_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nanocom_install: $(STATEDIR)/nanocom.install

$(STATEDIR)/nanocom.install: $(nanocom_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nanocom_targetinstall: $(STATEDIR)/nanocom.targetinstall

$(STATEDIR)/nanocom.targetinstall: $(nanocom_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, nanocom)
	@$(call install_fixup, nanocom,PACKAGE,nanocom)
	@$(call install_fixup, nanocom,PRIORITY,optional)
	@$(call install_fixup, nanocom,VERSION,$(NANOCOM_VERSION))
	@$(call install_fixup, nanocom,SECTION,base)
	@$(call install_fixup, nanocom,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, nanocom,DEPENDS,)
	@$(call install_fixup, nanocom,DESCRIPTION,missing)

	@$(call install_copy, nanocom, 0, 0, 0755, $(NANOCOM_DIR)/nanocom, /bin/nanocom)

	@$(call install_finish, nanocom)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nanocom_clean:
	rm -rf $(STATEDIR)/nanocom.*
	rm -rf $(IMAGEDIR)/nanocom_*
	rm -rf $(NANOCOM_DIR)

# vim: syntax=make

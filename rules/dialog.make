# -*-makefile-*-
# $Id: template 2078 2004-12-01 15:28:17Z rsc $
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
PACKAGES-$(PTXCONF_DIALOG) += dialog

#
# Paths and names
#
DIALOG_VERSION		= 1.0-20041118
DIALOG			= dialog-$(DIALOG_VERSION)
DIALOG_SUFFIX		= tgz
DIALOG_URL		= http://invisible-island.net/dialog/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_SOURCE		= $(SRCDIR)/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_DIR		= $(BUILDDIR)/$(DIALOG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dialog_get: $(STATEDIR)/dialog.get

dialog_get_deps = $(DIALOG_SOURCE)

$(STATEDIR)/dialog.get: $(dialog_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(DIALOG))
	@$(call touch, $@)

$(DIALOG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DIALOG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dialog_extract: $(STATEDIR)/dialog.extract

dialog_extract_deps = $(STATEDIR)/dialog.get

$(STATEDIR)/dialog.extract: $(dialog_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DIALOG_DIR))
	@$(call extract, $(DIALOG_SOURCE))
	@$(call patchin, $(DIALOG))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dialog_prepare: $(STATEDIR)/dialog.prepare

#
# dependencies
#
dialog_prepare_deps = \
	$(STATEDIR)/dialog.extract \
	$(STATEDIR)/virtual-xchain.install

DIALOG_PATH	=  PATH=$(CROSS_PATH)
DIALOG_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DIALOG_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/dialog.prepare: $(dialog_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DIALOG_DIR)/config.cache)
	cd $(DIALOG_DIR) && \
		$(DIALOG_PATH) $(DIALOG_ENV) \
		./configure $(DIALOG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dialog_compile: $(STATEDIR)/dialog.compile

dialog_compile_deps = $(STATEDIR)/dialog.prepare

$(STATEDIR)/dialog.compile: $(dialog_compile_deps)
	@$(call targetinfo, $@)
	cd $(DIALOG_DIR) && $(DIALOG_ENV) $(DIALOG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dialog_install: $(STATEDIR)/dialog.install

$(STATEDIR)/dialog.install: $(STATEDIR)/dialog.compile
	@$(call targetinfo, $@)
	@$(call install, DIALOG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dialog_targetinstall: $(STATEDIR)/dialog.targetinstall

dialog_targetinstall_deps = $(STATEDIR)/dialog.compile

$(STATEDIR)/dialog.targetinstall: $(dialog_targetinstall_deps)
	@$(call targetinfo, $@)
	# FIXME: RSC: nothing to do on targetinstall? 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dialog_clean:
	rm -rf $(STATEDIR)/dialog.*
	rm -rf $(DIALOG_DIR)

# vim: syntax=make

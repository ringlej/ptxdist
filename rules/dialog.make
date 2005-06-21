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
ifdef PTXCONF_DIALOG
PACKAGES += dialog
endif

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
	touch $@

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
	touch $@

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
#DIALOG_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#DIALOG_ENV	+=

#
# autoconf
#
DIALOG_AUTOCONF =  $(CROSS_AUTOCONF)
DIALOG_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/dialog.prepare: $(dialog_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DIALOG_DIR)/config.cache)
	cd $(DIALOG_DIR) && \
		$(DIALOG_PATH) $(DIALOG_ENV) \
		./configure $(DIALOG_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dialog_compile: $(STATEDIR)/dialog.compile

dialog_compile_deps = $(STATEDIR)/dialog.prepare

$(STATEDIR)/dialog.compile: $(dialog_compile_deps)
	@$(call targetinfo, $@)
	cd $(DIALOG_DIR) && $(DIALOG_ENV) $(DIALOG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dialog_install: $(STATEDIR)/dialog.install

$(STATEDIR)/dialog.install: $(STATEDIR)/dialog.compile
	@$(call targetinfo, $@)
	cd $(DIALOG_DIR) && $(DIALOG_ENV) $(DIALOG_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dialog_targetinstall: $(STATEDIR)/dialog.targetinstall

dialog_targetinstall_deps = $(STATEDIR)/dialog.compile

$(STATEDIR)/dialog.targetinstall: $(dialog_targetinstall_deps)
	@$(call targetinfo, $@)
	# FIXME: RSC: nothing to do on targetinstall? 
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dialog_clean:
	rm -rf $(STATEDIR)/dialog.*
	rm -rf $(DIALOG_DIR)

# vim: syntax=make

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
DIALOG_VERSION		= 1.0-20060221
DIALOG			= dialog_$(DIALOG_VERSION)
DIALOG_SUFFIX		= tar.gz
DIALOG_URL		= ftp://ftp.us.debian.org/debian/pool/main/d/dialog/$(DIALOG).orig.$(DIALOG_SUFFIX)
DIALOG_SOURCE		= $(SRCDIR)/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_DIR		= $(BUILDDIR)/$(DIALOG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dialog_get: $(STATEDIR)/dialog.get

$(STATEDIR)/dialog.get: $(dialog_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DIALOG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DIALOG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dialog_extract: $(STATEDIR)/dialog.extract

$(STATEDIR)/dialog.extract: $(dialog_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DIALOG_DIR))
	@$(call extract, DIALOG)
	@$(call patchin, DIALOG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dialog_prepare: $(STATEDIR)/dialog.prepare

DIALOG_PATH	=  PATH=$(CROSS_PATH)
DIALOG_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DIALOG_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/dialog.prepare: $(dialog_prepare_deps_default)
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

$(STATEDIR)/dialog.compile: $(dialog_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DIALOG_DIR) && $(DIALOG_ENV) $(DIALOG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dialog_install: $(STATEDIR)/dialog.install

$(STATEDIR)/dialog.install: $(dialog_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DIALOG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dialog_targetinstall: $(STATEDIR)/dialog.targetinstall

$(STATEDIR)/dialog.targetinstall: $(dialog_targetinstall_deps_default)
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

# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
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
PACKAGES-$(PTXCONF_EFAX) += efax

#
# Paths and names
#
EFAX_VERSION		= 0.9
EFAX			= efax-$(EFAX_VERSION)
EFAX_SUFFIX		= tar.gz
EFAX_URL		= ftp://ftp.metalab.unc.edu/pub/Linux/apps/serialcomm/fax/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE		= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR		= $(BUILDDIR)/$(EFAX)
EFAX_LICENSE		:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

efax_get: $(STATEDIR)/efax.get

$(STATEDIR)/efax.get: $(efax_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(EFAX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, EFAX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

efax_extract: $(STATEDIR)/efax.extract

$(STATEDIR)/efax.extract: $(efax_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR))
	@$(call extract, EFAX)
	@$(call patchin, EFAX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

efax_prepare: $(STATEDIR)/efax.prepare

EFAX_PATH	=  PATH=$(CROSS_PATH)
EFAX_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
EFAX_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/efax.prepare: $(efax_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

efax_compile: $(STATEDIR)/efax.compile

$(STATEDIR)/efax.compile: $(efax_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(EFAX_DIR) && $(EFAX_ENV) $(EFAX_PATH) make all CC=$(CROSS_CC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

efax_install: $(STATEDIR)/efax.install

$(STATEDIR)/efax.install: $(efax_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, EFAX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

efax_targetinstall: $(STATEDIR)/efax.targetinstall

$(STATEDIR)/efax.targetinstall: $(efax_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, efax)
	@$(call install_fixup, efax,PACKAGE,efax)
	@$(call install_fixup, efax,PRIORITY,optional)
	@$(call install_fixup, efax,VERSION,$(EFAX_VERSION))
	@$(call install_fixup, efax,SECTION,base)
	@$(call install_fixup, efax,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, efax,DEPENDS,)
	@$(call install_fixup, efax,DESCRIPTION,missing)

	@$(call install_copy, efax, 0, 0, 0755, $(EFAX_DIR)/efax, /usr/bin/efax)
	@$(call install_copy, efax, 0, 0, 0755, $(EFAX_DIR)/efix, /usr/bin/efix)

	@$(call install_finish, efax)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

efax_clean:
	rm -rf $(STATEDIR)/efax.*
	rm -rf $(PKGDIR)/efax_*
	rm -rf $(EFAX_DIR)

# vim: syntax=make

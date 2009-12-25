# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Roland Hostettler
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBGRAB) += fbgrab

#
# Paths and names
#
FBGRAB_VERSION	:= 1.0
FBGRAB		:= fbgrab-$(FBGRAB_VERSION)
FBGRAB_SUFFIX	:= tar.gz
FBGRAB_URL	:= http://hem.bredband.net/gmogmo/fbgrab/$(FBGRAB).$(FBGRAB_SUFFIX)
FBGRAB_SOURCE	:= $(SRCDIR)/$(FBGRAB).$(FBGRAB_SUFFIX)
FBGRAB_DIR	:= $(BUILDDIR)/$(FBGRAB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fbgrab_get: $(STATEDIR)/fbgrab.get

$(STATEDIR)/fbgrab.get: $(fbgrab_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FBGRAB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FBGRAB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fbgrab_extract: $(STATEDIR)/fbgrab.extract

$(STATEDIR)/fbgrab.extract: $(fbgrab_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FBGRAB_DIR))
	@$(call extract, FBGRAB)
	@$(call patchin, FBGRAB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fbgrab_prepare: $(STATEDIR)/fbgrab.prepare

FBGRAB_PATH	:= PATH=$(CROSS_PATH)
FBGRAB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FBGRAB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/fbgrab.prepare: $(fbgrab_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FBGRAB_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
# overwrite some vars in the makefile

FBGRAB_MAKEVARS = \
	CC=$(COMPILER_PREFIX)gcc \
	LDFLAGS='`pkg-config --libs libpng` `pkg-config --libs libz` $(CROSS_LDFLAGS)'

fbgrab_compile: $(STATEDIR)/fbgrab.compile

$(STATEDIR)/fbgrab.compile: $(fbgrab_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FBGRAB_DIR) && $(FBGRAB_PATH) $(MAKE) $(CROSS_ENV) $(FBGRAB_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fbgrab_install: $(STATEDIR)/fbgrab.install

$(STATEDIR)/fbgrab.install: $(fbgrab_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FBGRAB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fbgrab_targetinstall: $(STATEDIR)/fbgrab.targetinstall

$(STATEDIR)/fbgrab.targetinstall: $(fbgrab_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fbgrab)
	@$(call install_fixup, fbgrab,PACKAGE,fbgrab)
	@$(call install_fixup, fbgrab,PRIORITY,optional)
	@$(call install_fixup, fbgrab,VERSION,$(FBGRAB_VERSION))
	@$(call install_fixup, fbgrab,SECTION,base)
	@$(call install_fixup, fbgrab,AUTHOR,"Roland Hostettler <r.hostettler\@gmx.ch>")
	@$(call install_fixup, fbgrab,DEPENDS,)
	@$(call install_fixup, fbgrab,DESCRIPTION,missing)

	@$(call install_copy, fbgrab, 0, 0, 0755, $(FBGRAB_DIR)/fbgrab, /usr/bin/fbgrab)

	@$(call install_finish, fbgrab)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbgrab_clean:
	rm -rf $(STATEDIR)/fbgrab.*
	rm -rf $(PKGDIR)/fbgrab_*
	rm -rf $(FBGRAB_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Tom St
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SJINN) += sjinn

#
# Paths and names
#
SJINN_VERSION	:= 1.01
SJINN		:= sjinn-$(SJINN_VERSION)
SJINN_SUFFIX	:= tar.gz
SJINN_URL	:= http://downloads.sourceforge.net/sjinn/$(SJINN).$(SJINN_SUFFIX)
SJINN_SOURCE	:= $(SRCDIR)/$(SJINN).$(SJINN_SUFFIX)
SJINN_DIR	:= $(BUILDDIR)/$(SJINN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sjinn_get: $(STATEDIR)/sjinn.get

$(STATEDIR)/sjinn.get: $(sjinn_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SJINN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SJINN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sjinn_extract: $(STATEDIR)/sjinn.extract

$(STATEDIR)/sjinn.extract: $(sjinn_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SJINN_DIR))
	@$(call extract, SJINN)
	mv $(BUILDDIR)/sjinn $(BUILDDIR)/$(SJINN)
	@$(call patchin, SJINN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sjinn_prepare: $(STATEDIR)/sjinn.prepare

SJINN_PATH	:=  PATH=$(CROSS_PATH)
SJINN_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SJINN_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sjinn.prepare: $(sjinn_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sjinn_compile: $(STATEDIR)/sjinn.compile

$(STATEDIR)/sjinn.compile: $(sjinn_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SJINN_DIR) && $(SJINN_PATH) $(SJINN_ENV) make CC=$(CROSS_CC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sjinn_install: $(STATEDIR)/sjinn.install

$(STATEDIR)/sjinn.install: $(sjinn_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sjinn_targetinstall: $(STATEDIR)/sjinn.targetinstall

$(STATEDIR)/sjinn.targetinstall: $(sjinn_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sjinn)
	@$(call install_fixup,sjinn,PACKAGE,sjinn)
	@$(call install_fixup,sjinn,PRIORITY,optional)
	@$(call install_fixup,sjinn,VERSION,$(SJINN_VERSION))
	@$(call install_fixup,sjinn,SECTION,base)
	@$(call install_fixup,sjinn,AUTHOR,"Tom St")
	@$(call install_fixup,sjinn,DEPENDS,)
	@$(call install_fixup,sjinn,DESCRIPTION,missing)

	@$(call install_copy, sjinn, 0, 0, 0755, $(SJINN_DIR)/rs232, /usr/bin/rs232)

	@$(call install_finish,sjinn)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sjinn_clean:
	rm -rf $(STATEDIR)/sjinn.*
	rm -rf $(PKGDIR)/sjinn_*
	rm -rf $(SJINN_DIR)

# vim: syntax=make

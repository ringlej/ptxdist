# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FRODO) += frodo

#
# Paths and names
#
FRODO_VERSION	:= 4.1b
FRODO		:= Frodo-$(FRODO_VERSION)
FRODO_SUFFIX	:= Src.tar.gz
FRODO_URL	:= http://frodo.cebix.net/downloads/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_SOURCE	:= $(SRCDIR)/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_DIR	:= $(BUILDDIR)/$(FRODO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

frodo_get: $(STATEDIR)/frodo.get

$(STATEDIR)/frodo.get: $(frodo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FRODO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FRODO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

frodo_extract: $(STATEDIR)/frodo.extract

$(STATEDIR)/frodo.extract: $(frodo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FRODO_DIR))
	@$(call extract, FRODO)
	@$(call patchin, FRODO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

frodo_prepare: $(STATEDIR)/frodo.prepare

FRODO_PATH	:= PATH=$(CROSS_PATH)
FRODO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FRODO_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/frodo.prepare: $(frodo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FRODO_DIR)/config.cache)
	cd $(FRODO_DIR)/Src && \
		$(FRODO_PATH) $(FRODO_ENV) \
		./configure $(FRODO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

frodo_compile: $(STATEDIR)/frodo.compile

$(STATEDIR)/frodo.compile: $(frodo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FRODO_DIR)/Src && $(FRODO_ENV) $(FRODO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

frodo_install: $(STATEDIR)/frodo.install

$(STATEDIR)/frodo.install: $(frodo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FRODO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

frodo_targetinstall: $(STATEDIR)/frodo.targetinstall

$(STATEDIR)/frodo.targetinstall: $(frodo_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, frodo)
	@$(call install_fixup, frodo,PACKAGE,frodo)
	@$(call install_fixup, frodo,PRIORITY,optional)
	@$(call install_fixup, frodo,VERSION,$(FRODO_VERSION))
	@$(call install_fixup, frodo,SECTION,base)
	@$(call install_fixup, frodo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, frodo,DEPENDS,)
	@$(call install_fixup, frodo,DESCRIPTION,missing)

	@$(call install_copy, frodo, 0, 0, 0755, $(FRODO_DIR)/foobar, /dev/null)

	@$(call install_finish, frodo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

frodo_clean:
	rm -rf $(STATEDIR)/frodo.*
	rm -rf $(IMAGEDIR)/frodo_*
	rm -rf $(FRODO_DIR)

# vim: syntax=make

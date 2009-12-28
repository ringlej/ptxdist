# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HPANEL) += hpanel

#
# Paths and names
#
HPANEL_VERSION	:= 0.3.2
HPANEL		:= hpanel-$(HPANEL_VERSION)
HPANEL_SUFFIX	:= tar.gz
HPANEL_URL	:= http://www.phrat.de/$(HPANEL).$(HPANEL_SUFFIX)
HPANEL_SOURCE	:= $(SRCDIR)/$(HPANEL).$(HPANEL_SUFFIX)
HPANEL_DIR	:= $(BUILDDIR)/$(HPANEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hpanel_get: $(STATEDIR)/hpanel.get

$(STATEDIR)/hpanel.get: $(hpanel_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HPANEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HPANEL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hpanel_extract: $(STATEDIR)/hpanel.extract

$(STATEDIR)/hpanel.extract: $(hpanel_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call extract, HPANEL)
	@$(call patchin, HPANEL)
	rm -f $(HPANEL_DIR)/hpanel
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hpanel_prepare: $(STATEDIR)/hpanel.prepare

HPANEL_PATH	:= PATH=$(CROSS_PATH)
HPANEL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
HPANEL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hpanel.prepare: $(hpanel_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HPANEL_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
# overwrite some vars in the makefile

HPANEL_MAKEVARS = \
        CC=$(COMPILER_PREFIX)gcc \
	LDFLAGS='`pkg-config --libs xft` `pkg-config --libs xpm` $(CROSS_LDFLAGS)'

hpanel_compile: $(STATEDIR)/hpanel.compile

$(STATEDIR)/hpanel.compile: $(hpanel_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HPANEL_DIR) && $(HPANEL_PATH) $(MAKE) $(CROSS_ENV) $(HPANEL_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hpanel_install: $(STATEDIR)/hpanel.install

$(STATEDIR)/hpanel.install: $(hpanel_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hpanel_targetinstall: $(STATEDIR)/hpanel.targetinstall

$(STATEDIR)/hpanel.targetinstall: $(hpanel_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hpanel)
	@$(call install_fixup,hpanel,PACKAGE,hpanel)
	@$(call install_fixup,hpanel,PRIORITY,optional)
	@$(call install_fixup,hpanel,VERSION,$(HPANEL_VERSION))
	@$(call install_fixup,hpanel,SECTION,base)
	@$(call install_fixup,hpanel,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,hpanel,DEPENDS,)
	@$(call install_fixup,hpanel,DESCRIPTION,missing)

	@$(call install_copy, hpanel, 0, 0, 0755, $(HPANEL_DIR)/hpanel, /usr/bin/hpanel,y)

	@$(call install_finish,hpanel)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hpanel_clean:
	rm -rf $(STATEDIR)/hpanel.*
	rm -rf $(PKGDIR)/hpanel_*
	rm -rf $(HPANEL_DIR)

# vim: syntax=make

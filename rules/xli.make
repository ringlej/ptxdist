# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XLI) += xli

#
# Paths and names
#
XLI_VERSION	:= 1.17.0
XLI		:= xli-$(XLI_VERSION)
XLI_SUFFIX	:= tar.gz
XLI_URL		:= http://pantransit.reptiles.org/prog/$(XLI).$(XLI_SUFFIX)
XLI_SOURCE	:= $(SRCDIR)/$(XLI).$(XLI_SUFFIX)
XLI_DIR		:= $(BUILDDIR)/$(XLI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xli_get: $(STATEDIR)/xli.get

$(STATEDIR)/xli.get: $(xli_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XLI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XLI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xli_extract: $(STATEDIR)/xli.extract

$(STATEDIR)/xli.extract: $(xli_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLI_DIR))
	@$(call extract, XLI)
	@$(call patchin, XLI)
	cd $(XLI_DIR) && ln -sf Makefile.std Makefile
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xli_prepare: $(STATEDIR)/xli.prepare

XLI_PATH	:= PATH=$(CROSS_PATH)
XLI_ENV 	:= $(CROSS_ENV) EXTRAFLAGS="$(CROSS_CPPFLAGS) $(CROSS_LDFLAGS)"
XLI_AUTOCONF	:= $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xli.prepare: $(xli_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLI_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xli_compile: $(STATEDIR)/xli.compile

$(STATEDIR)/xli.compile: $(xli_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XLI_DIR) && $(XLI_PATH) $(XLI_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xli_install: $(STATEDIR)/xli.install

$(STATEDIR)/xli.install: $(xli_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xli_targetinstall: $(STATEDIR)/xli.targetinstall

$(STATEDIR)/xli.targetinstall: $(xli_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xli)
	@$(call install_fixup, xli,PACKAGE,xli)
	@$(call install_fixup, xli,PRIORITY,optional)
	@$(call install_fixup, xli,VERSION,$(XLI_VERSION))
	@$(call install_fixup, xli,SECTION,base)
	@$(call install_fixup, xli,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xli,DEPENDS,)
	@$(call install_fixup, xli,DESCRIPTION,missing)

	@$(call install_copy, xli, 0, 0, 0755, $(XLI_DIR)/xli, /usr/bin/xli)

	@$(call install_finish, xli)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xli_clean:
	rm -rf $(STATEDIR)/xli.*
	rm -rf $(IMAGEDIR)/xli_*
	rm -rf $(XLI_DIR)

# vim: syntax=make

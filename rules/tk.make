# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Bjoern Buerger <b.buerger@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TK) += tk

#
# Paths and names
#
TK_MAJOR	:= 8.4
TK_PL		:= 15
TK_VERSION	:= $(TK_MAJOR).$(TK_PL)
TK		:= tk$(TK_VERSION)
TK_SUFFIX	:= -src.tar.gz
TK_URL		:= $(PTXCONF_SETUP_SFMIRROR)/tcl/$(TK)$(TK_SUFFIX)
TK_SOURCE	:= $(SRCDIR)/$(TK)$(TK_SUFFIX)
TK_DIR		:= $(BUILDDIR)/$(TK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tk_get: $(STATEDIR)/tk.get

$(STATEDIR)/tk.get: $(tk_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tk_extract: $(STATEDIR)/tk.extract

$(STATEDIR)/tk.extract: $(tk_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TK_DIR))
	@$(call extract, TK)
	@$(call patchin, TK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tk_prepare: $(STATEDIR)/tk.prepare

TK_PATH	:= PATH=$(CROSS_PATH)
TK_ENV 	:= $(CROSS_ENV)
TK_MAKEVARS	 =  CROSS_COMPILE=$(COMPILER_PREFIX)

#
# autoconf
#
TK_AUTOCONF := $(CROSS_AUTOCONF_USR)
TK_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/tk.prepare: $(tk_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TK_DIR)/config.cache)
	cd $(TK_DIR)/unix && \
		$(TK_PATH) $(TK_ENV) \
		./configure $(TK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tk_compile: $(STATEDIR)/tk.compile

$(STATEDIR)/tk.compile: $(tk_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TK_DIR)/unix && $(TK_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tk_install: $(STATEDIR)/tk.install

$(STATEDIR)/tk.install: $(tk_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, TK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tk_targetinstall: $(STATEDIR)/tk.targetinstall

$(STATEDIR)/tk.targetinstall: $(tk_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, tk)
	@$(call install_fixup, tk,PACKAGE,tk)
	@$(call install_fixup, tk,PRIORITY,optional)
	@$(call install_fixup, tk,VERSION,$(TK_VERSION))
	@$(call install_fixup, tk,SECTION,base)
	@$(call install_fixup, tk,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, tk,DEPENDS,)
	@$(call install_fixup, tk,DESCRIPTION,missing)

	@$(call install_copy, tk, 0, 0, 0755, $(TK_DIR)/foobar, /dev/null)

	@$(call install_finish, tk)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tk_clean:
	rm -rf $(STATEDIR)/tk.*
	rm -rf $(IMAGEDIR)/tk_*
	rm -rf $(TK_DIR)

# vim: syntax=make

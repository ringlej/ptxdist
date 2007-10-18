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
PACKAGES-$(PTXCONF_LESS) += less

#
# Paths and names
#
LESS_VERSION		:= 406
LESS			:= less-$(LESS_VERSION)
LESS_SUFFIX		:= tar.gz
LESS_URL		:= http://www.greenwoodsoftware.com/less/$(LESS).$(LESS_SUFFIX)
LESS_SOURCE		:= $(SRCDIR)/$(LESS).$(LESS_SUFFIX)
LESS_DIR		:= $(BUILDDIR)/$(LESS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

less_get: $(STATEDIR)/less.get

$(STATEDIR)/less.get: $(less_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LESS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LESS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

less_extract: $(STATEDIR)/less.extract

$(STATEDIR)/less.extract: $(less_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LESS_DIR))
	@$(call extract, LESS)
	@$(call patchin, LESS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

less_prepare: $(STATEDIR)/less.prepare

LESS_PATH	:= PATH=$(CROSS_PATH)
LESS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LESS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/less.prepare: $(less_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LESS_DIR)/config.cache)
	cd $(LESS_DIR) && \
		$(LESS_PATH) $(LESS_ENV) \
		./configure $(LESS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

less_compile: $(STATEDIR)/less.compile

$(STATEDIR)/less.compile: $(less_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LESS_DIR) && $(LESS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

less_install: $(STATEDIR)/less.install

$(STATEDIR)/less.install: $(less_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LESS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

less_targetinstall: $(STATEDIR)/less.targetinstall

$(STATEDIR)/less.targetinstall: $(less_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, less)
	@$(call install_fixup, less,PACKAGE,less)
	@$(call install_fixup, less,PRIORITY,optional)
	@$(call install_fixup, less,VERSION,$(LESS_VERSION))
	@$(call install_fixup, less,SECTION,base)
	@$(call install_fixup, less,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, less,DEPENDS,)
	@$(call install_fixup, less,DESCRIPTION,missing)

	@echo "DEBUG"
	@echo "SYSROOT: $(SYSROOT) $(LESS)"
	@echo ""

#
# FIXME: copy from $(SYSROOT is probably a bad idea, better would be something like
#        (...)/local/packages/less-406/... identified as e.g. $(PACKAGE_SYSROOT)
#	 or $(LESS_SYSROOT).						bbu, 20071018
#
ifdef PTXCONF_LESS_BIN
	@$(call install_copy, less, 0, 0, 0755, $(SYSROOT)/usr/bin/less, /usr/bin/less)
endif

ifdef PTXCONF_LESS_KEY
	@$(call install_copy, less, 0, 0, 0755, $(SYSROOT)/usr/bin/lesskey, /usr/bin/lesskey)
endif

ifdef PTXCONF_LESS_ECHO
	@$(call install_copy, less, 0, 0, 0755, $(SYSROOT)/usr/bin/lessecho, /usr/bin/lessecho)
endif

	@$(call install_finish, less)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

less_clean:
	rm -rf $(STATEDIR)/less.*
	rm -rf $(IMAGEDIR)/less_*
	rm -rf $(LESS_DIR)

# vim: syntax=make

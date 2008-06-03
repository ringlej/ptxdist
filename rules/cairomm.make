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
PACKAGES-$(PTXCONF_CAIROMM) += cairomm

#
# Paths and names
#
CAIROMM_VERSION	:= 1.4.4
CAIROMM		:= cairomm-$(CAIROMM_VERSION)
CAIROMM_SUFFIX	:= tar.gz
CAIROMM_URL	:= http://cairographics.org/releases/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_SOURCE	:= $(SRCDIR)/$(CAIROMM).$(CAIROMM_SUFFIX)
CAIROMM_DIR	:= $(BUILDDIR)/$(CAIROMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cairomm_get: $(STATEDIR)/cairomm.get

$(STATEDIR)/cairomm.get: $(cairomm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CAIROMM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CAIROMM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cairomm_extract: $(STATEDIR)/cairomm.extract

$(STATEDIR)/cairomm.extract: $(cairomm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CAIROMM_DIR))
	@$(call extract, CAIROMM)
	@$(call patchin, CAIROMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cairomm_prepare: $(STATEDIR)/cairomm.prepare

CAIROMM_PATH	:= PATH=$(CROSS_PATH)
CAIROMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIROMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/cairomm.prepare: $(cairomm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CAIROMM_DIR)/config.cache)
	cd $(CAIROMM_DIR) && \
		$(CAIROMM_PATH) $(CAIROMM_ENV) \
		./configure $(CAIROMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cairomm_compile: $(STATEDIR)/cairomm.compile

$(STATEDIR)/cairomm.compile: $(cairomm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CAIROMM_DIR) && $(CAIROMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cairomm_install: $(STATEDIR)/cairomm.install

$(STATEDIR)/cairomm.install: $(cairomm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CAIROMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cairomm_targetinstall: $(STATEDIR)/cairomm.targetinstall

$(STATEDIR)/cairomm.targetinstall: $(cairomm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, cairomm)
	@$(call install_fixup, cairomm,PACKAGE,cairomm)
	@$(call install_fixup, cairomm,PRIORITY,optional)
	@$(call install_fixup, cairomm,VERSION,$(CAIROMM_VERSION))
	@$(call install_fixup, cairomm,SECTION,base)
	@$(call install_fixup, cairomm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, cairomm,DEPENDS,)
	@$(call install_fixup, cairomm,DESCRIPTION,missing)

	@$(call install_copy, cairomm, 0, 0, 0644, \
		$(CAIROMM_DIR)/cairomm/.libs/libcairomm-1.0.so.1.1.0, \
		/usr/lib/libcairomm-1.0.so.1.1.0)

	@$(call install_link, cairomm, \
		libcairomm-1.0.so.1.1.0, /usr/lib/libcairomm-1.0.so.1)

	@$(call install_link, cairomm, \
		libcairomm-1.0.so.1.1.0, /usr/lib/libcairomm-1.0.so)

	@$(call install_finish, cairomm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cairomm_clean:
	rm -rf $(STATEDIR)/cairomm.*
	rm -rf $(PKGDIR)/cairomm_*
	rm -rf $(CAIROMM_DIR)

# vim: syntax=make

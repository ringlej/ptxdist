# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel
# Copyright (C) 2008 by Wolfram Sang, Pengutronix e.K.
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BING) += bing

#
# Paths and names
#
BING_VERSION		= 1.1.3
BING			= bing_src-$(BING_VERSION)
BING_SUFFIX		= tar.gz
BING_URL		= http://fgouget.free.fr/bing/$(BING).$(BING_SUFFIX)
BING_SOURCE		= $(SRCDIR)/$(BING).$(BING_SUFFIX)
BING_DIR		= $(BUILDDIR)/$(BING)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bing_get: $(STATEDIR)/bing.get

$(STATEDIR)/bing.get: $(bing_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BING_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BING)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bing_extract: $(STATEDIR)/bing.extract

$(STATEDIR)/bing.extract: $(bing_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BING_DIR))
	@$(call extract, BING)
	@$(call patchin, BING)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bing_prepare: $(STATEDIR)/bing.prepare

BING_PATH	=  PATH=$(CROSS_PATH)
BING_ENV 	=  $(CROSS_ENV) PREFIX=$(SYSROOT)/usr

$(STATEDIR)/bing.prepare: $(bing_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bing_compile: $(STATEDIR)/bing.compile

$(STATEDIR)/bing.compile: $(bing_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BING_DIR) && $(BING_ENV) $(BING_PATH) make bing
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bing_install: $(STATEDIR)/bing.install

$(STATEDIR)/bing.install: $(bing_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BING)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bing_targetinstall: $(STATEDIR)/bing.targetinstall

$(STATEDIR)/bing.targetinstall: $(bing_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, bing)
	@$(call install_fixup, bing,PACKAGE,bing)
	@$(call install_fixup, bing,PRIORITY,optional)
	@$(call install_fixup, bing,VERSION,$(BING_VERSION))
	@$(call install_fixup, bing,SECTION,base)
	@$(call install_fixup, bing,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, bing,DEPENDS,)
	@$(call install_fixup, bing,DESCRIPTION,missing)
	@$(call install_copy, bing, 0, 0, 0755, $(BING_DIR)/bing, /usr/sbin/bing)
	@$(call install_finish, bing)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bing_clean:
	rm -rf $(STATEDIR)/bing.*
	rm -rf $(PKGDIR)/bing_*
	rm -rf $(BING_DIR)

# vim: syntax=make

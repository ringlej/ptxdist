# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_FIGLET) += figlet

#
# Paths and names
#
FIGLET_VERSION		= 222
FIGLET			= figlet$(FIGLET_VERSION)
FIGLET_SUFFIX		= tar.gz
FIGLET_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_SOURCE		= $(SRCDIR)/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_DIR		= $(BUILDDIR)/$(FIGLET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

figlet_get: $(STATEDIR)/figlet.get

$(STATEDIR)/figlet.get: $(figlet_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FIGLET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FIGLET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

figlet_extract: $(STATEDIR)/figlet.extract

$(STATEDIR)/figlet.extract: $(figlet_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FIGLET_DIR))
	@$(call extract, FIGLET)
	@$(call patchin, FIGLET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

figlet_prepare: $(STATEDIR)/figlet.prepare

FIGLET_PATH	=  PATH=$(CROSS_PATH)
FIGLET_ENV 	= $(CROSS_ENV) \
	CFLAGS='$(call remove_quotes,$(TARGET_CFLAGS))' \
	LDFLAGS='$(call remove_quotes,$(TARGET_LDFLAGS))'
FIGLET_MAKEVARS = prefix=/usr

$(STATEDIR)/figlet.prepare: $(figlet_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

figlet_compile: $(STATEDIR)/figlet.compile

$(STATEDIR)/figlet.compile: $(figlet_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FIGLET_DIR) && $(FIGLET_ENV) $(FIGLET_PATH) make $(FIGLET_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

figlet_install: $(STATEDIR)/figlet.install

$(STATEDIR)/figlet.install: $(figlet_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FIGLET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

figlet_targetinstall: $(STATEDIR)/figlet.targetinstall

$(STATEDIR)/figlet.targetinstall: $(figlet_targetinstall_deps_default)
	@$(call targetinfo, $@)

	rm -f $(ROOTDIR)/usr/sbin/figlet $(ROOTDIR)/usr/share/figlet/*

	@$(call install_init, figlet)
	@$(call install_fixup, figlet,PACKAGE,figlet)
	@$(call install_fixup, figlet,PRIORITY,optional)
	@$(call install_fixup, figlet,VERSION,$(FIGLET_VERSION))
	@$(call install_fixup, figlet,SECTION,base)
	@$(call install_fixup, figlet,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, figlet,DEPENDS,)
	@$(call install_fixup, figlet,DESCRIPTION,missing)

	@$(call install_copy, figlet, 0, 0, 0755, $(FIGLET_DIR)/figlet, /usr/sbin/figlet)
	@$(call install_copy, figlet, 0, 0, 0644, $(FIGLET_DIR)/fonts/standard.flf, /usr/share/figlet/standard.flf, n)

	@$(call install_finish, figlet)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

figlet_clean:
	rm -rf $(STATEDIR)/figlet.*
	rm -rf $(PKGDIR)/figlet_*
	rm -rf $(FIGLET_DIR)

# vim: syntax=make

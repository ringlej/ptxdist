# -*-makefile-*-
# $Id: figlet.make,v 1.1 2004/06/22 06:46:56 rsc Exp $
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
ifdef PTXCONF_FIGLET
PACKAGES += figlet
endif

#
# Paths and names
#
FIGLET_VERSION		= 221
FIGLET			= figlet$(FIGLET_VERSION)
FIGLET_SUFFIX		= tar.gz
FIGLET_URL		= ftp://ftp.figlet.org/pub/figlet/program/unix/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_SOURCE		= $(SRCDIR)/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_DIR		= $(BUILDDIR)/$(FIGLET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

figlet_get: $(STATEDIR)/figlet.get

figlet_get_deps = $(FIGLET_SOURCE)

$(STATEDIR)/figlet.get: $(figlet_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, PTXCONF_FIGLET)
	touch $@

$(FIGLET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FIGLET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

figlet_extract: $(STATEDIR)/figlet.extract

figlet_extract_deps = $(STATEDIR)/figlet.get

$(STATEDIR)/figlet.extract: $(figlet_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FIGLET_DIR))
	@$(call extract, $(FIGLET_SOURCE))
	@$(call patchin, $(PTXCONF_FIGLET))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

figlet_prepare: $(STATEDIR)/figlet.prepare

#
# dependencies
#
figlet_prepare_deps = \
	$(STATEDIR)/figlet.extract \
	$(STATEDIR)/virtual-xchain.install

FIGLET_PATH	=  PATH=$(CROSS_PATH)
FIGLET_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/figlet.prepare: $(figlet_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

figlet_compile: $(STATEDIR)/figlet.compile

figlet_compile_deps = $(STATEDIR)/figlet.prepare

$(STATEDIR)/figlet.compile: $(figlet_compile_deps)
	@$(call targetinfo, $@)
	cd $(FIGLET_DIR) && $(FIGLET_ENV) $(FIGLET_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

figlet_install: $(STATEDIR)/figlet.install

$(STATEDIR)/figlet.install: $(STATEDIR)/figlet.compile
	@$(call targetinfo, $@)
	cd $(FIGLET_DIR) && $(FIGLET_ENV) $(FIGLET_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

figlet_targetinstall: $(STATEDIR)/figlet.targetinstall

figlet_targetinstall_deps = $(STATEDIR)/figlet.compile

$(STATEDIR)/figlet.targetinstall: $(figlet_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/sbin
	install -d $(ROOTDIR)/usr/share/figlet
	cp $(FIGLET_DIR)/figlet $(ROOTDIR)/usr/sbin/
	cp $(FIGLET_DIR)/fonts/standard.flf $(ROOTDIR)/usr/share/figlet/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/figlet
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

figlet_clean:
	rm -rf $(STATEDIR)/figlet.*
	rm -rf $(FIGLET_DIR)

# vim: syntax=make

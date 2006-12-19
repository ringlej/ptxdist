# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KONQ_E) += konq-e

#
# Paths and names
#
KONQ_E_VERSION		= snapshot-20030705
KONQ_E			= konqueror-embedded-$(KONQ_E_VERSION)
KONQ_E_SUFFIX		= tar.gz
KONQ_E_URL		= http://devel-home.kde.org/~hausmann/snapshots/$(KONQ_E).$(KONQ_E_SUFFIX)
KONQ_E_SOURCE		= $(SRCDIR)/$(KONQ_E).$(KONQ_E_SUFFIX)
KONQ_E_DIR		= $(BUILDDIR)/$(KONQ_E)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

konq-e_get: $(STATEDIR)/konq-e.get

$(STATEDIR)/konq-e.get: $(konq-e_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KONQ_E_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KONQ_E)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

konq-e_extract: $(STATEDIR)/konq-e.extract

$(STATEDIR)/konq-e.extract: $(konq-e_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ_E_DIR))
	@$(call extract, KONQ_E)
	@$(call patchin, KONQ_E)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

konq-e_prepare: $(STATEDIR)/konq-e.prepare

KONQ_E_PATH	=  PATH=$(CROSS_PATH)
KONQ_E_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
KONQ_E_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/konq-e.prepare: $(konq-e_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ_E_BUILDDIR))
	cd $(KONQ_E_DIR) && \
		$(KONQ_E_PATH) $(KONQ_E_ENV) \
		./configure $(KONQ_E_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

konq-e_compile: $(STATEDIR)/konq-e.compile

$(STATEDIR)/konq-e.compile: $(konq-e_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(KONQ_E_DIR) && $(KONQ_E_PATH) $(KONQ_E_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

konq-e_install: $(STATEDIR)/konq-e.install

$(STATEDIR)/konq-e.install: $(konq-e_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: RSC: shouldn't this be target-install? 
	@$(call install, KONQ_E)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

konq-e_targetinstall: $(STATEDIR)/konq-e.targetinstall

$(STATEDIR)/konq-e.targetinstall: $(konq-e_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

konq-e_clean:
	rm -rf $(STATEDIR)/konq-e.*
	rm -rf $(KONQ_E_DIR)

# vim: syntax=make

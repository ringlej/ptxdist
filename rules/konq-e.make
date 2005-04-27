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
ifdef PTXCONF_KONQ-E
PACKAGES += konq-e
endif

#
# Paths and names
#
KONQ-E_VERSION		= snapshot-20030705
KONQ-E			= konqueror-embedded-$(KONQ-E_VERSION)
KONQ-E_SUFFIX		= tar.gz
KONQ-E_URL		= http://devel-home.kde.org/~hausmann/snapshots/$(KONQ-E).$(KONQ-E_SUFFIX)
KONQ-E_SOURCE		= $(SRCDIR)/$(KONQ-E).$(KONQ-E_SUFFIX)
KONQ-E_DIR		= $(BUILDDIR)/$(KONQ-E)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

konq-e_get: $(STATEDIR)/konq-e.get

konq-e_get_deps	=  $(KONQ-E_SOURCE)

$(STATEDIR)/konq-e.get: $(konq-e_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KONQ-E_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KONQ-E_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

konq-e_extract: $(STATEDIR)/konq-e.extract

konq-e_extract_deps	=  $(STATEDIR)/konq-e.get

$(STATEDIR)/konq-e.extract: $(konq-e_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ-E_DIR))
	@$(call extract, $(KONQ-E_SOURCE))
	@$(call patchin, $(KONQ-E))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

konq-e_prepare: $(STATEDIR)/konq-e.prepare

#
# dependencies
#
konq-e_prepare_deps =  \
	$(STATEDIR)/konq-e.extract \
	$(STATEDIR)/virtual-xchain.install

KONQ-E_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
KONQ-E_ENV 	=  $(CROSS_ENV)
#KONQ-E_ENV	+=


#
# autoconf
#
KONQ-E_AUTOCONF =  $(CROSS_AUTOCONF)
KONQ-E_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/konq-e.prepare: $(konq-e_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ-E_BUILDDIR))
	cd $(KONQ-E_DIR) && \
		$(KONQ-E_PATH) $(KONQ-E_ENV) \
		./configure $(KONQ-E_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

konq-e_compile: $(STATEDIR)/konq-e.compile

konq-e_compile_deps =  $(STATEDIR)/konq-e.prepare

$(STATEDIR)/konq-e.compile: $(konq-e_compile_deps)
	@$(call targetinfo, $@)
	cd $(KONQ-E_DIR) && $(KONQ-E_PATH) $(KONQ-E_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

konq-e_install: $(STATEDIR)/konq-e.install

$(STATEDIR)/konq-e.install: $(STATEDIR)/konq-e.compile
	@$(call targetinfo, $@)
	# FIXME: RSC: shouldn't this be target-install? 
	cd $(KONQ-E_DIR) && $(KONQ-E_PATH) $(KONQ-E_ENV) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

konq-e_targetinstall: $(STATEDIR)/konq-e.targetinstall

konq-e_targetinstall_deps	=  $(STATEDIR)/konq-e.compile

$(STATEDIR)/konq-e.targetinstall: $(konq-e_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

konq-e_clean:
	rm -rf $(STATEDIR)/konq-e.*
	rm -rf $(KONQ-E_DIR)

# vim: syntax=make

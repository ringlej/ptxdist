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
ifdef PTXCONF_NANO
PACKAGES += nano
endif

#
# Paths and names
#
NANO_VERSION		= 1.2.4
NANO			= nano-$(NANO_VERSION)
NANO_SUFFIX		= tar.gz
NANO_URL		= http://www.nano-editor.org/dist/v1.2/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		= $(BUILDDIR)/$(NANO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nano_get: $(STATEDIR)/nano.get

nano_get_deps = $(NANO_SOURCE)

$(STATEDIR)/nano.get: $(nano_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NANO))
	touch $@

$(NANO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NANO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nano_extract: $(STATEDIR)/nano.extract

nano_extract_deps = $(STATEDIR)/nano.get

$(STATEDIR)/nano.extract: $(nano_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NANO_DIR))
	@$(call extract, $(NANO_SOURCE))
	@$(call patchin, $(NANO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nano_prepare: $(STATEDIR)/nano.prepare

#
# dependencies
#
nano_prepare_deps = \
	$(STATEDIR)/nano.extract \
	$(STATEDIR)/virtual-xchain.install

NANO_PATH	=  PATH=$(CROSS_PATH)
NANO_ENV 	=  $(CROSS_ENV)
#NANO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#NANO_ENV	+=

#
# autoconf
#
NANO_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/nano.prepare: $(nano_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NANO_DIR)/config.cache)
	cd $(NANO_DIR) && \
		$(NANO_PATH) $(NANO_ENV) \
		./configure $(NANO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nano_compile: $(STATEDIR)/nano.compile

nano_compile_deps = $(STATEDIR)/nano.prepare

$(STATEDIR)/nano.compile: $(nano_compile_deps)
	@$(call targetinfo, $@)
	cd $(NANO_DIR) && $(NANO_ENV) $(NANO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nano_install: $(STATEDIR)/nano.install

$(STATEDIR)/nano.install: $(STATEDIR)/nano.compile
	@$(call targetinfo, $@)
	cd $(NANO_DIR) && $(NANO_ENV) $(NANO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nano_targetinstall: $(STATEDIR)/nano.targetinstall

nano_targetinstall_deps = $(STATEDIR)/nano.compile

$(STATEDIR)/nano.targetinstall: $(nano_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nano_clean:
	rm -rf $(STATEDIR)/nano.*
	rm -rf $(NANO_DIR)

# vim: syntax=make

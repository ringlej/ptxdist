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
ifdef PTXCONF_BONNIE++
PACKAGES += bonnie++
endif

#
# Paths and names
#
BONNIE++_VERSION	= 1.03a
BONNIE++		= bonnie++-$(BONNIE++_VERSION)
BONNIE++_SUFFIX		= tgz
BONNIE++_URL		= http://www.coker.com.au/bonnie++/$(BONNIE++).$(BONNIE++_SUFFIX)
BONNIE++_SOURCE		= $(SRCDIR)/$(BONNIE++).$(BONNIE++_SUFFIX)
BONNIE++_DIR		= $(BUILDDIR)/$(BONNIE++)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bonnie++_get: $(STATEDIR)/bonnie++.get

bonnie++_get_deps = $(BONNIE++_SOURCE)

$(STATEDIR)/bonnie++.get: $(bonnie++_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(BONNIE++))
	touch $@

$(BONNIE++_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BONNIE++_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bonnie++_extract: $(STATEDIR)/bonnie++.extract

bonnie++_extract_deps = $(STATEDIR)/bonnie++.get

$(STATEDIR)/bonnie++.extract: $(bonnie++_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BONNIE++_DIR))
	@$(call extract, $(BONNIE++_SOURCE))
	@$(call patchin, $(BONNIE++))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bonnie++_prepare: $(STATEDIR)/bonnie++.prepare

#
# dependencies
#
bonnie++_prepare_deps = \
	$(STATEDIR)/bonnie++.extract \
	$(STATEDIR)/virtual-xchain.install

BONNIE++_PATH	=  PATH=$(CROSS_PATH)
BONNIE++_ENV 	=  $(CROSS_ENV)
#BONNIE++_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#BONNIE++_ENV	+=

#
# autoconf
#
BONNIE++_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/bonnie++.prepare: $(bonnie++_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BONNIE++_DIR)/config.cache)
	cd $(BONNIE++_DIR) && \
		$(BONNIE++_PATH) $(BONNIE++_ENV) \
		./configure $(BONNIE++_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bonnie++_compile: $(STATEDIR)/bonnie++.compile

bonnie++_compile_deps = $(STATEDIR)/bonnie++.prepare

$(STATEDIR)/bonnie++.compile: $(bonnie++_compile_deps)
	@$(call targetinfo, $@)
	cd $(BONNIE++_DIR) && $(BONNIE++_ENV) $(BONNIE++_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bonnie++_install: $(STATEDIR)/bonnie++.install

$(STATEDIR)/bonnie++.install: $(STATEDIR)/bonnie++.compile
	@$(call targetinfo, $@)
	cd $(BONNIE++_DIR) && $(BONNIE++_ENV) $(BONNIE++_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bonnie++_targetinstall: $(STATEDIR)/bonnie++.targetinstall

bonnie++_targetinstall_deps = $(STATEDIR)/bonnie++.compile

$(STATEDIR)/bonnie++.targetinstall: $(bonnie++_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bonnie++_clean:
	rm -rf $(STATEDIR)/bonnie++.*
	rm -rf $(BONNIE++_DIR)

# vim: syntax=make

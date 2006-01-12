# -*-makefile-*-
# 
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: do something on targetinstall

#
# We provide this package
#
PACKAGES-$(PTXCONF_REALVNC) += realvnc

#
# Paths and names
#
REALVNC_VERSION		= 4.0
REALVNC			= vnc-$(REALVNC_VERSION)-unixsrc
REALVNC_SUFFIX		= tar.gz
REALVNC_URL		= http://www.realvnc.com/dist/$(REALVNC).$(REALVNC_SUFFIX)
REALVNC_SOURCE		= $(SRCDIR)/$(REALVNC).$(REALVNC_SUFFIX)
REALVNC_DIR		= $(BUILDDIR)/$(REALVNC)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

realvnc_get: $(STATEDIR)/realvnc.get

realvnc_get_deps = $(REALVNC_SOURCE)

$(STATEDIR)/realvnc.get: $(realvnc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(REALVNC))
	@$(call touch, $@)

$(REALVNC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(REALVNC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

realvnc_extract: $(STATEDIR)/realvnc.extract

realvnc_extract_deps = $(STATEDIR)/realvnc.get

$(STATEDIR)/realvnc.extract: $(realvnc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(REALVNC_DIR))
	@$(call extract, $(REALVNC_SOURCE))
	@$(call patchin, $(REALVNC))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

realvnc_prepare: $(STATEDIR)/realvnc.prepare

#
# dependencies
#
realvnc_prepare_deps =  $(STATEDIR)/realvnc.extract
realvnc_prepare_deps += $(STATEDIR)/virtual-xchain.install
realvnc_prepare_deps += $(STATEDIR)/xlibs-xtst.install

REALVNC_PATH	=  PATH=$(CROSS_PATH)
REALVNC_ENV 	=  $(CROSS_ENV)
#REALVNC_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#REALVNC_ENV	+=

#
# autoconf
#
REALVNC_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
REALVNC_AUTOCONF += --x-includes=$(CROSS_LIB_DIR)/include
REALVNC_AUTOCONF += --x-libraries=$(CROSS_LIB_DIR)/lib
REALVNC_AUTOCONF += --with-installed-zlib

$(STATEDIR)/realvnc.prepare: $(realvnc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(REALVNC_DIR)/config.cache)
	cd $(REALVNC_DIR) && \
		$(REALVNC_PATH) $(REALVNC_ENV) \
		./configure $(REALVNC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

realvnc_compile: $(STATEDIR)/realvnc.compile

realvnc_compile_deps = $(STATEDIR)/realvnc.prepare

$(STATEDIR)/realvnc.compile: $(realvnc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(REALVNC_DIR) && $(REALVNC_ENV) $(REALVNC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

realvnc_install: $(STATEDIR)/realvnc.install

$(STATEDIR)/realvnc.install: $(STATEDIR)/realvnc.compile
	@$(call targetinfo, $@)
	@$(call install, REALVNC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

realvnc_targetinstall: $(STATEDIR)/realvnc.targetinstall

realvnc_targetinstall_deps =  $(STATEDIR)/realvnc.compile
realvnc_targetinstall_deps += $(STATEDIR)/xlibs-xtst.targetinstall

$(STATEDIR)/realvnc.targetinstall: $(realvnc_targetinstall_deps_default)
	@$(call targetinfo, $@)
	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

realvnc_clean:
	rm -rf $(STATEDIR)/realvnc.*
	rm -rf $(IMAGeDIR)/realvnc_*
	rm -rf $(REALVNC_DIR)

# vim: syntax=make

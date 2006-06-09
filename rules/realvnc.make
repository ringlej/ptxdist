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


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

realvnc_get: $(STATEDIR)/realvnc.get

$(STATEDIR)/realvnc.get: $(realvnc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(REALVNC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, REALVNC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

realvnc_extract: $(STATEDIR)/realvnc.extract

$(STATEDIR)/realvnc.extract: $(realvnc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(REALVNC_DIR))
	@$(call extract, REALVNC)
	@$(call patchin, REALVNC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

realvnc_prepare: $(STATEDIR)/realvnc.prepare

REALVNC_PATH	=  PATH=$(CROSS_PATH)
REALVNC_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
REALVNC_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--x-includes=$(SYSROOT)/include \
	--x-libraries=$(SYSROOT)/lib \
	--with-installed-zlib

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

$(STATEDIR)/realvnc.compile: $(realvnc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(REALVNC_DIR) && $(REALVNC_ENV) $(REALVNC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

realvnc_install: $(STATEDIR)/realvnc.install

$(STATEDIR)/realvnc.install: $(realvnc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, REALVNC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

realvnc_targetinstall: $(STATEDIR)/realvnc.targetinstall

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

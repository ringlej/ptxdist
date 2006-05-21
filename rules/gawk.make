# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, By Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GAWK) += gawk

#
# Paths and names
#
GAWK_VERSION		= 3.1.5
GAWK			= gawk-$(GAWK_VERSION)
GAWK_SUFFIX		= tar.gz
GAWK_URL		= $(PTXCONF_SETUP_GNUMIRROR)/gawk/$(GAWK).$(GAWK_SUFFIX)
GAWK_SOURCE		= $(SRCDIR)/$(GAWK).$(GAWK_SUFFIX)
GAWK_DIR		= $(BUILDDIR)/$(GAWK)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gawk_get: $(STATEDIR)/gawk.get

$(STATEDIR)/gawk.get: $(gawk_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GAWK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GAWK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gawk_extract: $(STATEDIR)/gawk.extract

$(STATEDIR)/gawk.extract: $(gawk_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GAWK_DIR))
	@$(call extract, GAWK)
	@$(call patchin, GAWK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gawk_prepare: $(STATEDIR)/gawk.prepare

GAWK_PATH	=  PATH=$(CROSS_PATH)
GAWK_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
GAWK_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gawk.prepare: $(gawk_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GAWK_DIR)/config.cache)
	cd $(GAWK_DIR) && \
		$(GAWK_PATH) $(GAWK_ENV) \
		./configure $(GAWK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gawk_compile: $(STATEDIR)/gawk.compile

$(STATEDIR)/gawk.compile: $(gawk_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GAWK_DIR) && $(GAWK_ENV) $(GAWK_PATH) make $(GAWK_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gawk_install: $(STATEDIR)/gawk.install

$(STATEDIR)/gawk.install: $(gawk_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GAWK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gawk_targetinstall: $(STATEDIR)/gawk.targetinstall

$(STATEDIR)/gawk.targetinstall: $(gawk_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# FIXME: RSC: ipkgize
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gawk_clean:
	rm -rf $(STATEDIR)/gawk.*
	rm -rf $(GAWK_DIR)

# vim: syntax=make

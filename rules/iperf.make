# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPERF) += iperf

#
# Paths and names
#
IPERF_VERSION	:= 2.0.2
IPERF		:= iperf-$(IPERF_VERSION)
IPERF_SUFFIX		:= tar.gz
IPERF_URL		:= http://dast.nlanr.net/Projects/Iperf2.0/$(IPERF).$(IPERF_SUFFIX)
IPERF_SOURCE		:= $(SRCDIR)/$(IPERF).$(IPERF_SUFFIX)
IPERF_DIR		:= $(BUILDDIR)/$(IPERF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

iperf_get: $(STATEDIR)/iperf.get

$(STATEDIR)/iperf.get: $(iperf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(IPERF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, IPERF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

iperf_extract: $(STATEDIR)/iperf.extract

$(STATEDIR)/iperf.extract: $(iperf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPERF_DIR))
	@$(call extract, IPERF)
	@$(call patchin, IPERF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

iperf_prepare: $(STATEDIR)/iperf.prepare

IPERF_PATH	:= PATH=$(CROSS_PATH)
IPERF_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
IPERF_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/iperf.prepare: $(iperf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPERF_DIR)/config.cache)
	cd $(IPERF_DIR) && \
		$(IPERF_PATH) $(IPERF_ENV) \
		./configure $(IPERF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

iperf_compile: $(STATEDIR)/iperf.compile

$(STATEDIR)/iperf.compile: $(iperf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(IPERF_DIR) && $(IPERF_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

iperf_install: $(STATEDIR)/iperf.install

$(STATEDIR)/iperf.install: $(iperf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, IPERF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

iperf_targetinstall: $(STATEDIR)/iperf.targetinstall

$(STATEDIR)/iperf.targetinstall: $(iperf_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, iperf)
	@$(call install_fixup, iperf,PACKAGE,iperf)
	@$(call install_fixup, iperf,PRIORITY,optional)
	@$(call install_fixup, iperf,VERSION,$(IPERF_VERSION))
	@$(call install_fixup, iperf,SECTION,base)
	@$(call install_fixup, iperf,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, iperf,DEPENDS,)
	@$(call install_fixup, iperf,DESCRIPTION,missing)

	@$(call install_copy, iperf, 0, 0, 0755, $(IPERF_DIR)/src/iperf, /usr/bin/iperf)

	@$(call install_finish, iperf)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iperf_clean:
	rm -rf $(STATEDIR)/iperf.*
	rm -rf $(PKGDIR)/iperf_*
	rm -rf $(IPERF_DIR)

# vim: syntax=make

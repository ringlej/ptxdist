# -*-makefile-*-
# $Id$
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
CROSS_PACKAGES-$(PTXCONF_CROSS_INSIGHT) += cross-insight

#
# Paths and names
#
CROSS_INSIGHT_VERSION	:= 6.6
CROSS_INSIGHT		:= insight-$(CROSS_INSIGHT_VERSION)
CROSS_INSIGHT_SUFFIX	:= tar.bz2
CROSS_INSIGHT_URL	:= ftp://sourceware.org/pub/insight/releases/$(CROSS_INSIGHT).$(CROSS_INSIGHT_SUFFIX)
CROSS_INSIGHT_SOURCE	:= $(SRCDIR)/$(CROSS_INSIGHT).$(CROSS_INSIGHT_SUFFIX)
CROSS_INSIGHT_DIR	:= $(CROSS_BUILDDIR)/$(CROSS_INSIGHT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cross-insight_get: $(STATEDIR)/cross-insight.get

$(STATEDIR)/cross-insight.get: $(cross-insight_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CROSS_INSIGHT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CROSS_INSIGHT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cross-insight_extract: $(STATEDIR)/cross-insight.extract

$(STATEDIR)/cross-insight.extract: $(cross-insight_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_INSIGHT_DIR))
	@$(call extract, CROSS_INSIGHT, $(CROSS_BUILDDIR))
	@$(call patchin, CROSS_INSIGHT, $(CROSS_INSIGHT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cross-insight_prepare: $(STATEDIR)/cross-insight.prepare

CROSS_INSIGHT_PATH	:= PATH=$(HOST_PATH)
CROSS_INSIGHT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
CROSS_INSIGHT_AUTOCONF	:= --target=$(PTXCONF_GNU_TARGET) \
	--prefix=$(PTX_PREFIX_CROSS)

$(STATEDIR)/cross-insight.prepare: $(cross-insight_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_INSIGHT_DIR)/config.cache)
	cd $(CROSS_INSIGHT_DIR) && \
		$(CROSS_INSIGHT_PATH) $(CROSS_INSIGHT_ENV) \
		./configure $(CROSS_INSIGHT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cross-insight_compile: $(STATEDIR)/cross-insight.compile

$(STATEDIR)/cross-insight.compile: $(cross-insight_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CROSS_INSIGHT_DIR) && $(CROSS_INSIGHT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cross-insight_install: $(STATEDIR)/cross-insight.install

$(STATEDIR)/cross-insight.install: $(cross-insight_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CROSS_INSIGHT,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-insight_clean:
	rm -rf $(STATEDIR)/cross-insight.*
	rm -rf $(CROSS_INSIGHT_DIR)

# vim: syntax=make

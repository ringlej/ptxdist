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

$(CROSS_INSIGHT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CROSS_INSIGHT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CROSS_INSIGHT_PATH	:= PATH=$(HOST_PATH)
CROSS_INSIGHT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
CROSS_INSIGHT_AUTOCONF	:= --target=$(PTXCONF_GNU_TARGET) \
	--prefix=$(PTXCONF_SYSROOT_CROSS)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-insight.compile:
	@$(call targetinfo)
	cd $(CROSS_INSIGHT_DIR) && $(CROSS_INSIGHT_PATH) $(MAKE) $(PARALLELMFLAGS)
	cd $(CROSS_INSIGHT_DIR) && $(CROSS_INSIGHT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-insight_clean:
	rm -rf $(STATEDIR)/cross-insight.*
	rm -rf $(CROSS_INSIGHT_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XLIBS-FIXESEXT) += xlibs-fixesext

#
# Paths and names
#
XLIBS-FIXESEXT_VERSION	= 20041103-1
XLIBS-FIXESEXT		= FixesExt-$(XLIBS-FIXESEXT_VERSION)
XLIBS-FIXESEXT_SUFFIX	= tar.bz2
XLIBS-FIXESEXT_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-FIXESEXT).$(XLIBS-FIXESEXT_SUFFIX)
XLIBS-FIXESEXT_SOURCE	= $(SRCDIR)/$(XLIBS-FIXESEXT).$(XLIBS-FIXESEXT_SUFFIX)
XLIBS-FIXESEXT_DIR	= $(BUILDDIR)/$(XLIBS-FIXESEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fixesext_get: $(STATEDIR)/xlibs-fixesext.get

xlibs-fixesext_get_deps = $(XLIBS-FIXESEXT_SOURCE)

$(STATEDIR)/xlibs-fixesext.get: $(xlibs-fixesext_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-FIXESEXT))
	@$(call touch, $@)

$(XLIBS-FIXESEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-FIXESEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fixesext_extract: $(STATEDIR)/xlibs-fixesext.extract

xlibs-fixesext_extract_deps = $(STATEDIR)/xlibs-fixesext.get

$(STATEDIR)/xlibs-fixesext.extract: $(xlibs-fixesext_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-FIXESEXT_DIR))
	@$(call extract, $(XLIBS-FIXESEXT_SOURCE))
	@$(call patchin, $(XLIBS-FIXESEXT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fixesext_prepare: $(STATEDIR)/xlibs-fixesext.prepare

#
# dependencies
#
xlibs-fixesext_prepare_deps =  $(STATEDIR)/xlibs-fixesext.extract
xlibs-fixesext_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-FIXESEXT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-FIXESEXT_ENV 	=  $(CROSS_ENV)
XLIBS-FIXESEXT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-FIXESEXT_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fixesext.prepare: $(xlibs-fixesext_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-FIXESEXT_DIR)/config.cache)
	chmod a+x $(XLIBS-FIXESEXT_DIR)/configure
	cd $(XLIBS-FIXESEXT_DIR) && \
		$(XLIBS-FIXESEXT_PATH) $(XLIBS-FIXESEXT_ENV) \
		./configure $(XLIBS-FIXESEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fixesext_compile: $(STATEDIR)/xlibs-fixesext.compile

xlibs-fixesext_compile_deps = $(STATEDIR)/xlibs-fixesext.prepare

$(STATEDIR)/xlibs-fixesext.compile: $(xlibs-fixesext_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-FIXESEXT_DIR) && $(XLIBS-FIXESEXT_ENV) $(XLIBS-FIXESEXT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fixesext_install: $(STATEDIR)/xlibs-fixesext.install

$(STATEDIR)/xlibs-fixesext.install: $(STATEDIR)/xlibs-fixesext.compile
	@$(call targetinfo, $@)
	@$(call install, XLIBS-FIXESEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fixesext_targetinstall: $(STATEDIR)/xlibs-fixesext.targetinstall

xlibs-fixesext_targetinstall_deps = $(STATEDIR)/xlibs-fixesext.compile

$(STATEDIR)/xlibs-fixesext.targetinstall: $(xlibs-fixesext_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fixesext_clean:
	rm -rf $(STATEDIR)/xlibs-fixesext.*
	rm -rf $(XLIBS-FIXESEXT_DIR)

# vim: syntax=make

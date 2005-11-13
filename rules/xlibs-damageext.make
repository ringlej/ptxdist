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
PACKAGES-$(PTXCONF_XLIBS-DAMAGEEXT) += xlibs-damageext

#
# Paths and names
#
XLIBS-DAMAGEEXT_VERSION	= 20041103-1
XLIBS-DAMAGEEXT		= DamageExt-$(XLIBS-DAMAGEEXT_VERSION)
XLIBS-DAMAGEEXT_SUFFIX	= tar.bz2
XLIBS-DAMAGEEXT_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-DAMAGEEXT).$(XLIBS-DAMAGEEXT_SUFFIX)
XLIBS-DAMAGEEXT_SOURCE	= $(SRCDIR)/$(XLIBS-DAMAGEEXT).$(XLIBS-DAMAGEEXT_SUFFIX)
XLIBS-DAMAGEEXT_DIR	= $(BUILDDIR)/$(XLIBS-DAMAGEEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-damageext_get: $(STATEDIR)/xlibs-damageext.get

xlibs-damageext_get_deps = $(XLIBS-DAMAGEEXT_SOURCE)

$(STATEDIR)/xlibs-damageext.get: $(xlibs-damageext_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-DAMAGEEXT))
	$(call touch, $@)

$(XLIBS-DAMAGEEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-DAMAGEEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-damageext_extract: $(STATEDIR)/xlibs-damageext.extract

xlibs-damageext_extract_deps = $(STATEDIR)/xlibs-damageext.get

$(STATEDIR)/xlibs-damageext.extract: $(xlibs-damageext_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-DAMAGEEXT_DIR))
	@$(call extract, $(XLIBS-DAMAGEEXT_SOURCE))
	@$(call patchin, $(XLIBS-DAMAGEEXT))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-damageext_prepare: $(STATEDIR)/xlibs-damageext.prepare

#
# dependencies
#
xlibs-damageext_prepare_deps =  $(STATEDIR)/xlibs-damageext.extract
xlibs-damageext_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-DAMAGEEXT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-DAMAGEEXT_ENV 	=  $(CROSS_ENV)
XLIBS-DAMAGEEXT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-DAMAGEEXT_AUTOCONF =  --build=$(GNU_HOST)
XLIBS-DAMAGEEXT_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
XLIBS-DAMAGEEXT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-damageext.prepare: $(xlibs-damageext_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-DAMAGEEXT_DIR)/config.cache)
	chmod a+x $(XLIBS-DAMAGEEXT_DIR)/configure
	cd $(XLIBS-DAMAGEEXT_DIR) && \
		$(XLIBS-DAMAGEEXT_PATH) $(XLIBS-DAMAGEEXT_ENV) \
		./configure $(XLIBS-DAMAGEEXT_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-damageext_compile: $(STATEDIR)/xlibs-damageext.compile

xlibs-damageext_compile_deps = $(STATEDIR)/xlibs-damageext.prepare

$(STATEDIR)/xlibs-damageext.compile: $(xlibs-damageext_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-DAMAGEEXT_DIR) && $(XLIBS-DAMAGEEXT_ENV) $(XLIBS-DAMAGEEXT_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-damageext_install: $(STATEDIR)/xlibs-damageext.install

$(STATEDIR)/xlibs-damageext.install: $(STATEDIR)/xlibs-damageext.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-DAMAGEEXT_DIR) && $(XLIBS-DAMAGEEXT_ENV) $(XLIBS-DAMAGEEXT_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-damageext_targetinstall: $(STATEDIR)/xlibs-damageext.targetinstall

xlibs-damageext_targetinstall_deps = $(STATEDIR)/xlibs-damageext.compile

$(STATEDIR)/xlibs-damageext.targetinstall: $(xlibs-damageext_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-damageext_clean:
	rm -rf $(STATEDIR)/xlibs-damageext.*
	rm -rf $(XLIBS-DAMAGEEXT_DIR)

# vim: syntax=make

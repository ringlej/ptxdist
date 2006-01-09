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
PACKAGES-$(PTXCONF_XLIBS-RANDR) += xlibs-randr

#
# Paths and names
#
XLIBS-RANDR_VERSION	= 20041103-1
XLIBS-RANDR		= Randr-$(XLIBS-RANDR_VERSION)
XLIBS-RANDR_SUFFIX	= tar.bz2
XLIBS-RANDR_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-RANDR).$(XLIBS-RANDR_SUFFIX)
XLIBS-RANDR_SOURCE	= $(SRCDIR)/$(XLIBS-RANDR).$(XLIBS-RANDR_SUFFIX)
XLIBS-RANDR_DIR		= $(BUILDDIR)/$(XLIBS-RANDR)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-randr_get: $(STATEDIR)/xlibs-randr.get

xlibs-randr_get_deps = $(XLIBS-RANDR_SOURCE)

$(STATEDIR)/xlibs-randr.get: $(xlibs-randr_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-RANDR))
	@$(call touch, $@)

$(XLIBS-RANDR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-RANDR_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-randr_extract: $(STATEDIR)/xlibs-randr.extract

xlibs-randr_extract_deps = $(STATEDIR)/xlibs-randr.get

$(STATEDIR)/xlibs-randr.extract: $(xlibs-randr_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RANDR_DIR))
	@$(call extract, $(XLIBS-RANDR_SOURCE))
	@$(call patchin, $(XLIBS-RANDR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-randr_prepare: $(STATEDIR)/xlibs-randr.prepare

#
# dependencies
#
xlibs-randr_prepare_deps =  $(STATEDIR)/xlibs-randr.extract
xlibs-randr_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-RANDR_PATH	=  PATH=$(CROSS_PATH)
XLIBS-RANDR_ENV 	=  $(CROSS_ENV)
XLIBS-RANDR_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-RANDR_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xlibs-randr.prepare: $(xlibs-randr_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RANDR_DIR)/config.cache)
	chmod a+x $(XLIBS-RANDR_DIR)/configure
	cd $(XLIBS-RANDR_DIR) && \
		$(XLIBS-RANDR_PATH) $(XLIBS-RANDR_ENV) \
		./configure $(XLIBS-RANDR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-randr_compile: $(STATEDIR)/xlibs-randr.compile

xlibs-randr_compile_deps = $(STATEDIR)/xlibs-randr.prepare

$(STATEDIR)/xlibs-randr.compile: $(xlibs-randr_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-RANDR_DIR) && $(XLIBS-RANDR_ENV) $(XLIBS-RANDR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-randr_install: $(STATEDIR)/xlibs-randr.install

$(STATEDIR)/xlibs-randr.install: $(STATEDIR)/xlibs-randr.compile
	@$(call targetinfo, $@)
	@$(call install, XLIBS-RANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-randr_targetinstall: $(STATEDIR)/xlibs-randr.targetinstall

xlibs-randr_targetinstall_deps = $(STATEDIR)/xlibs-randr.compile

$(STATEDIR)/xlibs-randr.targetinstall: $(xlibs-randr_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-randr_clean:
	rm -rf $(STATEDIR)/xlibs-randr.*
	rm -rf $(XLIBS-RANDR_DIR)

# vim: syntax=make

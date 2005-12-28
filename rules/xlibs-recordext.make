# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
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
PACKAGES-$(PTXCONF_XLIBS-RECORDEXT) += xlibs-recordext

#
# Paths and names
#
XLIBS-RECORDEXT_VERSION	= 20041103-1
XLIBS-RECORDEXT		= RecordExt-$(XLIBS-RECORDEXT_VERSION)
XLIBS-RECORDEXT_SUFFIX	= tar.bz2
XLIBS-RECORDEXT_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src//$(XLIBS-RECORDEXT).$(XLIBS-RECORDEXT_SUFFIX)
XLIBS-RECORDEXT_SOURCE	= $(SRCDIR)/$(XLIBS-RECORDEXT).$(XLIBS-RECORDEXT_SUFFIX)
XLIBS-RECORDEXT_DIR	= $(BUILDDIR)/$(XLIBS-RECORDEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-recordext_get: $(STATEDIR)/xlibs-recordext.get

xlibs-recordext_get_deps = $(XLIBS-RECORDEXT_SOURCE)

$(STATEDIR)/xlibs-recordext.get: $(xlibs-recordext_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-RECORDEXT))
	@$(call touch, $@)

$(XLIBS-RECORDEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-RECORDEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-recordext_extract: $(STATEDIR)/xlibs-recordext.extract

xlibs-recordext_extract_deps = $(STATEDIR)/xlibs-recordext.get

$(STATEDIR)/xlibs-recordext.extract: $(xlibs-recordext_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RECORDEXT_DIR))
	@$(call extract, $(XLIBS-RECORDEXT_SOURCE))
	@$(call patchin, $(XLIBS-RECORDEXT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-recordext_prepare: $(STATEDIR)/xlibs-recordext.prepare

#
# dependencies
#
xlibs-recordext_prepare_deps = \
	$(STATEDIR)/xlibs-recordext.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS-RECORDEXT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-RECORDEXT_ENV 	=  $(CROSS_ENV)
XLIBS-RECORDEXT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-RECORDEXT_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xlibs-recordext.prepare: $(xlibs-recordext_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RECORDEXT_DIR)/config.cache)
	chmod a+x $(XLIBS-RECORDEXT_DIR)/configure
	cd $(XLIBS-RECORDEXT_DIR) && \
		$(XLIBS-RECORDEXT_PATH) $(XLIBS-RECORDEXT_ENV) \
		./configure $(XLIBS-RECORDEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-recordext_compile: $(STATEDIR)/xlibs-recordext.compile

xlibs-recordext_compile_deps = $(STATEDIR)/xlibs-recordext.prepare

$(STATEDIR)/xlibs-recordext.compile: $(xlibs-recordext_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-RECORDEXT_DIR) && $(XLIBS-RECORDEXT_ENV) $(XLIBS-RECORDEXT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-recordext_install: $(STATEDIR)/xlibs-recordext.install

$(STATEDIR)/xlibs-recordext.install: $(STATEDIR)/xlibs-recordext.compile
	@$(call targetinfo, $@)
	@$(call install, XLIBS-RECORDEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-recordext_targetinstall: $(STATEDIR)/xlibs-recordext.targetinstall

xlibs-recordext_targetinstall_deps = $(STATEDIR)/xlibs-recordext.compile

$(STATEDIR)/xlibs-recordext.targetinstall: $(xlibs-recordext_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-recordext_clean:
	rm -rf $(STATEDIR)/xlibs-recordext.*
	rm -rf $(XLIBS-RECORDEXT_DIR)

# vim: syntax=make

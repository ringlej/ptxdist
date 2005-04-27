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
ifdef PTXCONF_XLIBS-XEXTENSIONS
PACKAGES += xlibs-xextensions
endif

#
# Paths and names
#
XLIBS-XEXTENSIONS_VERSION	= 20041103-1
XLIBS-XEXTENSIONS		= XExtensions-$(XLIBS-XEXTENSIONS_VERSION)
XLIBS-XEXTENSIONS_SUFFIX	= tar.bz2
XLIBS-XEXTENSIONS_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XEXTENSIONS).$(XLIBS-XEXTENSIONS_SUFFIX)
XLIBS-XEXTENSIONS_SOURCE	= $(SRCDIR)/$(XLIBS-XEXTENSIONS).$(XLIBS-XEXTENSIONS_SUFFIX)
XLIBS-XEXTENSIONS_DIR		= $(BUILDDIR)/$(XLIBS-XEXTENSIONS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xextensions_get: $(STATEDIR)/xlibs-xextensions.get

xlibs-xextensions_get_deps = $(XLIBS-XEXTENSIONS_SOURCE)

$(STATEDIR)/xlibs-xextensions.get: $(xlibs-xextensions_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XEXTENSIONS))
	touch $@

$(XLIBS-XEXTENSIONS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XEXTENSIONS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xextensions_extract: $(STATEDIR)/xlibs-xextensions.extract

xlibs-xextensions_extract_deps = $(STATEDIR)/xlibs-xextensions.get

$(STATEDIR)/xlibs-xextensions.extract: $(xlibs-xextensions_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXTENSIONS_DIR))
	@$(call extract, $(XLIBS-XEXTENSIONS_SOURCE))
	@$(call patchin, $(XLIBS-XEXTENSIONS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xextensions_prepare: $(STATEDIR)/xlibs-xextensions.prepare

#
# dependencies
#
xlibs-xextensions_prepare_deps =  $(STATEDIR)/xlibs-xextensions.extract
xlibs-xextensions_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-XEXTENSIONS_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XEXTENSIONS_ENV 	=  $(CROSS_ENV)
XLIBS-XEXTENSIONS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XEXTENSIONS_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xextensions.prepare: $(xlibs-xextensions_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXTENSIONS_DIR)/config.cache)
	chmod a+x $(XLIBS-XEXTENSIONS_DIR)/configure
	cd $(XLIBS-XEXTENSIONS_DIR) && \
		$(XLIBS-XEXTENSIONS_PATH) $(XLIBS-XEXTENSIONS_ENV) \
		./configure $(XLIBS-XEXTENSIONS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xextensions_compile: $(STATEDIR)/xlibs-xextensions.compile

xlibs-xextensions_compile_deps = $(STATEDIR)/xlibs-xextensions.prepare

$(STATEDIR)/xlibs-xextensions.compile: $(xlibs-xextensions_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XEXTENSIONS_DIR) && $(XLIBS-XEXTENSIONS_ENV) $(XLIBS-XEXTENSIONS_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xextensions_install: $(STATEDIR)/xlibs-xextensions.install

$(STATEDIR)/xlibs-xextensions.install: $(STATEDIR)/xlibs-xextensions.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XEXTENSIONS_DIR) && $(XLIBS-XEXTENSIONS_ENV) $(XLIBS-XEXTENSIONS_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xextensions_targetinstall: $(STATEDIR)/xlibs-xextensions.targetinstall

xlibs-xextensions_targetinstall_deps = $(STATEDIR)/xlibs-xextensions.compile

$(STATEDIR)/xlibs-xextensions.targetinstall: $(xlibs-xextensions_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xextensions_clean:
	rm -rf $(STATEDIR)/xlibs-xextensions.*
	rm -rf $(XLIBS-XEXTENSIONS_DIR)

# vim: syntax=make

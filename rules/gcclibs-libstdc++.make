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

#
# We provide this package
#
ifdef PTXCONF_GCCLIBS_CXX
PACKAGES += gcclibs_cxx
endif

#
# Paths and names
#
# We use the same version as the meta packet here...
#
GCCLIBS_CXX_VERSION	= $(GCCLIBS_VERSION)
GCCLIBS			= gcc-$(call remove_quotes,$(GCCLIBS_VERSION))
GCCLIBS_CXX_DIR		= $(BUILDDIR)/gcclibs/$(GCCLIBS)/libstdc++-v3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gcclibs_cxx_get: $(STATEDIR)/gcclibs_cxx.get

# we leave this to the gcc packet...
gcclibs_cxx_get_deps = $(GCCLIBS_SOURCE)

$(STATEDIR)/gcclibs_cxx.get: $(gcclibs_cxx_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gcclibs_cxx_extract: $(STATEDIR)/gcclibs_cxx.extract

# we leave this to the gcc packet...
gcclibs_cxx_extract_deps = $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs_cxx.extract: $(gcclibs_cxx_extract_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gcclibs_cxx_prepare: $(STATEDIR)/gcclibs_cxx.prepare

#
# dependencies
#
gcclibs_cxx_prepare_deps =  $(STATEDIR)/gcclibs_cxx.extract
gcclibs_cxx_prepare_deps += $(STATEDIR)/virtual-xchain.install

GCCLIBS_CXX_PATH =  PATH=$(CROSS_PATH)
GCCLIBS_CXX_ENV  =  $(CROSS_ENV)
GCCLIBS_CXX_ENV  += ac_aux_dir=$(BUILDDIR)/gcclibs/$(GCCLIBS)

#
# autoconf
#
GCCLIBS_CXX_AUTOCONF =  --build=$(GNU_HOST)
GCCLIBS_CXX_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
GCCLIBS_CXX_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gcclibs_cxx.prepare: $(gcclibs_cxx_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCCLIBS_CXX_DIR)/config.cache)

	cd $(GCCLIBS_CXX_DIR) && \
		$(GCCLIBS_CXX_PATH) $(GCCLIBS_CXX_ENV) \
		./configure $(GCCLIBS_CXX_AUTOCONF)

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gcclibs_cxx_compile: $(STATEDIR)/gcclibs_cxx.compile

gcclibs_cxx_compile_deps = $(STATEDIR)/gcclibs_cxx.prepare

$(STATEDIR)/gcclibs_cxx.compile: $(gcclibs_cxx_compile_deps)
	@$(call targetinfo, $@)
	cd $(GCCLIBS_CXX_DIR) && $(GCCLIBS_CXX_ENV) $(GCCLIBS_CXX_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gcclibs_cxx_install: $(STATEDIR)/gcclibs_cxx.install

$(STATEDIR)/gcclibs_cxx.install: $(STATEDIR)/gcclibs_cxx.compile
	@$(call targetinfo, $@)
	cd $(GCCLIBS_CXX_DIR) && $(GCCLIBS_CXX_ENV) $(GCCLIBS_CXX_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gcclibs_cxx_targetinstall: $(STATEDIR)/gcclibs_cxx.targetinstall

gcclibs_cxx_targetinstall_deps = $(STATEDIR)/gcclibs_cxx.compile

$(STATEDIR)/gcclibs_cxx.targetinstall: $(gcclibs_cxx_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_cxx_clean:
	rm -rf $(STATEDIR)/gcclibs_cxx.*
	rm -rf $(GCCLIBS_CXX_DIR)

# vim: syntax=make

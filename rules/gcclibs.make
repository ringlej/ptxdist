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
ifdef PTXCONF_GCCLIBS
PACKAGES += gcclibs
endif

#
# Paths and names
#
# We use the same version as our compiler here
#
GCCLIBS_VERSION		= $(PTXCONF_CROSSCHAIN_CHECK)
GCCLIBS			= gcc-$(call remove_quotes,$(GCCLIBS_VERSION))
GCCLIBS_SUFFIX		= tar.bz2
GCCLIBS_URL		= ftp://ftp.gnu.org/gnu/gcc/$(GCCLIBS)/$(GCCLIBS).$(GCCLIBS_SUFFIX)
GCCLIBS_SOURCE		= $(SRCDIR)/$(GCCLIBS).$(GCCLIBS_SUFFIX)
GCCLIBS_DIR		= $(BUILDDIR)/gcclibs

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gcclibs_get: $(STATEDIR)/gcclibs.get

gcclibs_get_deps = $(GCCLIBS_SOURCE)

$(STATEDIR)/gcclibs.get: $(gcclibs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GCCLIBS))
	touch $@

$(GCCLIBS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GCCLIBS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gcclibs_extract: $(STATEDIR)/gcclibs.extract

gcclibs_extract_deps = $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs.extract: $(gcclibs_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCCLIBS_DIR))
	mkdir $(GCCLIBS_DIR)
	@$(call extract, $(GCCLIBS_SOURCE), $(GCCLIBS_DIR))
	@$(call patchin, $(GCCLIBS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gcclibs_prepare: $(STATEDIR)/gcclibs.prepare

#
# dependencies
#
gcclibs_prepare_deps =  $(STATEDIR)/gcclibs.extract
gcclibs_prepare_deps += $(STATEDIR)/virtual-xchain.install

GCCLIBS_PATH =  PATH=$(CROSS_PATH)
GCCLIBS_ENV  =  $(CROSS_ENV)

#
# autoconf
#
GCCLIBS_AUTOCONF =  --build=$(GNU_HOST)
GCCLIBS_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
GCCLIBS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gcclibs.prepare: $(gcclibs_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCCLIBS_DIR)/config.cache)

	cd $(GCCLIBS_DIR)/$(GCCLIBS) && \
		$(GCCLIBS_PATH) $(GCCLIBS_ENV) \
		./configure $(GCCLIBS_AUTOCONF)

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gcclibs_compile: $(STATEDIR)/gcclibs.compile

gcclibs_compile_deps = $(STATEDIR)/gcclibs.prepare

$(STATEDIR)/gcclibs.compile: $(gcclibs_compile_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gcclibs_install: $(STATEDIR)/gcclibs.install

$(STATEDIR)/gcclibs.install: $(STATEDIR)/gcclibs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gcclibs_targetinstall: $(STATEDIR)/gcclibs.targetinstall

gcclibs_targetinstall_deps = $(STATEDIR)/gcclibs.compile

$(STATEDIR)/gcclibs.targetinstall: $(gcclibs_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_clean:
	rm -rf $(STATEDIR)/gcclibs.*
	rm -rf $(GCCLIBS_DIR)

# vim: syntax=make

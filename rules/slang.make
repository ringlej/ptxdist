# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SLANG) += slang

#
# Paths and names
#
SLANG_VERSION	= 1.4.9
SLANG		= slang-$(SLANG_VERSION)
SLANG_SUFFIX	= tar.bz2
SLANG_URL	= ftp://space.mit.edu/pub/davis/slang/v1.4/$(SLANG).$(SLANG_SUFFIX)
SLANG_SOURCE	= $(SRCDIR)/$(SLANG).$(SLANG_SUFFIX)
SLANG_DIR	= $(BUILDDIR)/$(SLANG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

slang_get: $(STATEDIR)/slang.get

slang_get_deps = $(SLANG_SOURCE)

$(STATEDIR)/slang.get: $(slang_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(SLANG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SLANG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

slang_extract: $(STATEDIR)/slang.extract

slang_extract_deps = $(STATEDIR)/slang.get

$(STATEDIR)/slang.extract: $(slang_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SLANG_DIR))
	@$(call extract, $(SLANG_SOURCE))
	@$(call patchin, $(SLANG))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

slang_prepare: $(STATEDIR)/slang.prepare

#
# dependencies
#
slang_prepare_deps = \
	$(STATEDIR)/slang.extract \
	$(STATEDIR)/virtual-xchain.install

SLANG_PATH	=  PATH=$(CROSS_PATH)
SLANG_ENV 	=  $(CROSS_ENV)
#SLANG_ENV	+=

#
# autoconf
#
SLANG_AUTOCONF =  $(CROSS_AUTOCONF)
SLANG_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/slang.prepare: $(slang_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SLANG_DIR)/config.cache)
	cd $(SLANG_DIR) && \
		$(SLANG_PATH) $(SLANG_ENV) \
		./configure $(SLANG_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

slang_compile: $(STATEDIR)/slang.compile

slang_compile_deps = $(STATEDIR)/slang.prepare

$(STATEDIR)/slang.compile: $(slang_compile_deps)
	@$(call targetinfo, $@)
	cd $(SLANG_DIR) && $(SLANG_PATH) make elf
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

slang_install: $(STATEDIR)/slang.install

$(STATEDIR)/slang.install: $(STATEDIR)/slang.compile
	@$(call targetinfo, $@)
	cd $(SLANG_DIR) && $(SLANG_PATH) make install-elf
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

slang_targetinstall: $(STATEDIR)/slang.targetinstall

slang_targetinstall_deps = $(STATEDIR)/slang.compile

$(STATEDIR)/slang.targetinstall: $(slang_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,slang)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SLANG_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, \
		$(SLANG_DIR)/src/elfobjs/libslang.so.$(SLANG_VERSION), \
		/usr/lib/libslang.so.$(SLANG_VERSION))
	@$(call install_link, libslang.so.$(SLANG_VERSION), /usr/lib/libslang.so.1)
	@$(call install_link, libslang.so.$(SLANG_VERSION), /usr/lib/libslang.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

slang_clean:
	rm -rf $(STATEDIR)/slang.*
	rm -rf $(IMAGEDIR)/slang_*
	rm -rf $(SLANG_DIR)

# vim: syntax=make

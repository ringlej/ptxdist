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
ifdef PTXCONF_SLANG
PACKAGES += slang
endif

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
	touch $@

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
	touch $@

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
SLANG_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/slang.prepare: $(slang_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SLANG_DIR)/config.cache)
	cd $(SLANG_DIR) && \
		$(SLANG_PATH) $(SLANG_ENV) \
		./configure $(SLANG_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

slang_compile: $(STATEDIR)/slang.compile

slang_compile_deps = $(STATEDIR)/slang.prepare

$(STATEDIR)/slang.compile: $(slang_compile_deps)
	@$(call targetinfo, $@)
	$(SLANG_PATH) make -C $(SLANG_DIR) elf
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

slang_install: $(STATEDIR)/slang.install

$(STATEDIR)/slang.install: $(STATEDIR)/slang.compile
	@$(call targetinfo, $@)
	$(SLANG_PATH) make -C $(SLANG_DIR) install-elf
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

slang_targetinstall: $(STATEDIR)/slang.targetinstall

slang_targetinstall_deps = $(STATEDIR)/slang.compile

$(STATEDIR)/slang.targetinstall: $(slang_targetinstall_deps)
	@$(call targetinfo, $@)
	install $(SLANG_DIR)/src/elfobjs/libslang.so.$(SLANG_VERSION) \
		$(ROOTDIR)/usr/lib/
	cd $(ROOTDIR)/usr/lib/ && \
		ln -s libslang.so.$(SLANG_VERSION) libslang.so.1
	cd $(ROOTDIR)/usr/lib/ && \
		ln -s libslang.so.$(SLANG_VERSION) libslang.so
	$(CROSSSTRIP) -S -R .note -R .comment \
		$(ROOTDIR)/usr/lib/libslang.so.$(SLANG_VERSION)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

slang_clean:
	rm -rf $(STATEDIR)/slang.*
	rm -rf $(SLANG_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Dan Kegel http://kegel.com
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NASM
PACKAGES += xchain-nasm
endif

#
# Paths and names
#
XCHAIN_NASM_VERSION	= 0.98.38
XCHAIN_NASM		= nasm-$(XCHAIN_NASM_VERSION)
XCHAIN_NASM_SUFFIX	= tar.bz2
XCHAIN_NASM_URL		= $(PTXCONF_SFMIRROR)/nasm/$(XCHAIN_NASM).$(XCHAIN_NASM_SUFFIX)
XCHAIN_NASM_SOURCE	= $(SRCDIR)/$(XCHAIN_NASM).$(XCHAIN_NASM_SUFFIX)
XCHAIN_NASM_DIR		= $(BUILDDIR)/$(XCHAIN_NASM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-nasm_get: $(STATEDIR)/xchain-nasm.get

xchain-nasm_get_deps	=  $(XCHAIN_NASM_SOURCE)

$(STATEDIR)/xchain-nasm.get: $(xchain-nasm_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(XCHAIN_NASM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN_NASM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-nasm_extract: $(STATEDIR)/xchain-nasm.extract

xchain-nasm_extract_deps	=  $(STATEDIR)/xchain-nasm.get

$(STATEDIR)/xchain-nasm.extract: $(xchain-nasm_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_NASM_DIR))
	@$(call extract, $(XCHAIN_NASM_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-nasm_prepare: $(STATEDIR)/xchain-nasm.prepare

#
# dependencies
#
xchain-nasm_prepare_deps =  \
	$(STATEDIR)/xchain-nasm.extract


XCHAIN_NASM_PATH	=  PATH=$(CROSS_PATH)
XCHAIN_NASM_ENV	=  $(HOSTCC_ENV)

#
# autoconf
#
XCHAIN_NASM_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/xchain-nasm.prepare: $(xchain-nasm_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_NASM_BUILDDIR))
	cd $(XCHAIN_NASM_DIR) && \
		$(XCHAIN_NASM_PATH) $(XCHAIN_NASM_ENV) \
		./configure $(XCHAIN_NASM_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-nasm_compile: $(STATEDIR)/xchain-nasm.compile

xchain-nasm_compile_deps =  $(STATEDIR)/xchain-nasm.prepare

$(STATEDIR)/xchain-nasm.compile: $(xchain-nasm_compile_deps)
	@$(call targetinfo, $@)
	$(XCHAIN_NASM_PATH) make -C $(XCHAIN_NASM_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-nasm_install: $(STATEDIR)/xchain-nasm.install

$(STATEDIR)/xchain-nasm.install: $(STATEDIR)/xchain-nasm.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin
	mkdir -p $(PTXCONF_PREFIX)/man/man1
	$(XCHAIN_NASM_PATH) make -C $(XCHAIN_NASM_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-nasm_targetinstall: $(STATEDIR)/xchain-nasm.targetinstall

xchain-nasm_targetinstall_deps	=  $(STATEDIR)/xchain-nasm.install

$(STATEDIR)/xchain-nasm.targetinstall: $(xchain-nasm_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nasm_clean:
	rm -rf $(STATEDIR)/xchain-nasm.*
	rm -rf $(XCHAIN_NASM_DIR)

# vim: syntax=make

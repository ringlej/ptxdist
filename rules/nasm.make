# -*-makefile-*-
# $Id: nasm.make,v 1.1 2003/09/26 12:16:07 mkl Exp $
#
# (c) 2003 by Dan Kegel http://kegel.com
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NASM
PACKAGES += nasm
endif

#
# Paths and names
#
NASM_VERSION	= 0.98.38
NASM		= nasm-$(NASM_VERSION)
NASM_SUFFIX	= tar.bz2
NASM_URL	= http://umn.dl.sourceforge.net/sourceforge/nasm/$(NASM).$(NASM_SUFFIX)
NASM_SOURCE	= $(SRCDIR)/$(NASM).$(NASM_SUFFIX)
NASM_DIR	= $(BUILDDIR)/$(NASM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nasm_get: $(STATEDIR)/nasm.get

nasm_get_deps	=  $(NASM_SOURCE)

$(STATEDIR)/nasm.get: $(nasm_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(NASM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NASM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nasm_extract: $(STATEDIR)/nasm.extract

nasm_extract_deps	=  $(STATEDIR)/nasm.get

$(STATEDIR)/nasm.extract: $(nasm_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NASM_DIR))
	@$(call extract, $(NASM_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nasm_prepare: $(STATEDIR)/nasm.prepare

#
# dependencies
#
nasm_prepare_deps =  \
	$(STATEDIR)/nasm.extract

NASM_PATH	= 
NASM_ENV 	=  
#NASM_ENV	+=


#
# autoconf
#
NASM_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)

#NASM_AUTOCONF	+= 

$(STATEDIR)/nasm.prepare: $(nasm_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NASM_BUILDDIR))
	cd $(NASM_DIR) && \
		$(NASM_PATH) $(NASM_ENV) \
		./configure $(NASM_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nasm_compile: $(STATEDIR)/nasm.compile

nasm_compile_deps =  $(STATEDIR)/nasm.prepare

$(STATEDIR)/nasm.compile: $(nasm_compile_deps)
	@$(call targetinfo, $@)
	$(NASM_PATH) $(NASM_ENV) make -C $(NASM_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nasm_install: $(STATEDIR)/nasm.install

$(STATEDIR)/nasm.install: $(STATEDIR)/nasm.compile
	@$(call targetinfo, $@)
	$(NASM_PATH) $(NASM_ENV) make -C $(NASM_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nasm_targetinstall: $(STATEDIR)/nasm.targetinstall

nasm_targetinstall_deps	=  $(STATEDIR)/nasm.install

$(STATEDIR)/nasm.targetinstall: $(nasm_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nasm_clean:
	rm -rf $(STATEDIR)/nasm.*
	rm -rf $(NASM_DIR)

# vim: syntax=make

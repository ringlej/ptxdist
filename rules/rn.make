# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_RN
PACKAGES += rn
endif

#
# Paths and names
#
RN_VERSION	= 0.4
RN		= rn-$(RN_VERSION)
RN_SUFFIX	= tar.gz
RN_URL		= www.kegel.com/rn/$(RN).$(RN_SUFFIX)
RN_SOURCE	= $(SRCDIR)/$(RN).$(RN_SUFFIX)
RN_DIR		= $(BUILDDIR)/$(RN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rn_get: $(STATEDIR)/rn.get

rn_get_deps = $(RN_SOURCE)

$(STATEDIR)/rn.get: $(rn_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(RN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RN_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rn_extract: $(STATEDIR)/rn.extract

rn_extract_deps = $(STATEDIR)/rn.get

$(STATEDIR)/rn.extract: $(rn_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RN_DIR))
	@$(call extract, $(RN_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rn_prepare: $(STATEDIR)/rn.prepare

#
# dependencies
#
rn_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/rn.extract

#
# Only needed if using old glibc (older than 2.3.2)
#
#ifdef  PTXCONF_SYS-EPOLL-LIB
#rn_prepare_deps += $(STATEDIR)/sys-epoll-lib.install
#endif

RN_AUTOCONF  = \
	--prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET) \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

RN_MAKEVARS = \
	PREFIX=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET) \
	CC=$(PTXCONF_GNU_TARGET)-gcc

RN_PATH	=  PATH=$(CROSS_PATH)
RN_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/rn.prepare: $(rn_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RN_DIR)/config.cache)
	cd $(RN_DIR) && \
		$(RN_PATH) $(RN_ENV) \
		sh configure $(RN_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rn_compile: $(STATEDIR)/rn.compile

rn_compile_deps = $(STATEDIR)/rn.prepare

$(STATEDIR)/rn.compile: $(rn_compile_deps)
	@$(call targetinfo, $@)
	$(RN_PATH) make -C $(RN_DIR) $(RN_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rn_install: $(STATEDIR)/rn.install

$(STATEDIR)/rn.install: $(STATEDIR)/rn.compile
	@$(call targetinfo, $@)
	$(RN_PATH) make -C $(RN_DIR)  $(RN_MAKEVARS) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rn_targetinstall: $(STATEDIR)/rn.targetinstall

rn_targetinstall_deps = $(STATEDIR)/rn.install

$(STATEDIR)/rn.targetinstall: $(rn_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rn_clean:
	rm -rf $(STATEDIR)/rn.*
	rm -rf $(RN_DIR)

# vim: syntax=make

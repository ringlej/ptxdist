# -*-makefile-*-
# $Id: termcap.make,v 1.1 2003/11/17 03:52:43 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_TERMCAP
PACKAGES += termcap
endif

#
# Paths and names
#
TERMCAP_VERSION	= 1.3.1
TERMCAP		= termcap-$(TERMCAP_VERSION)
TERMCAP_SUFFIX	= tar.gz
TERMCAP_URL	= ftp://ftp.gnu.org/pub/gnu/termcap/$(TERMCAP).$(TERMCAP_SUFFIX)
TERMCAP_SOURCE	= $(SRCDIR)/$(TERMCAP).$(TERMCAP_SUFFIX)
TERMCAP_DIR	= $(BUILDDIR)/$(TERMCAP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

termcap_get: $(STATEDIR)/termcap.get

termcap_get_deps = \
	$(TERMCAP_SOURCE) \
	$(STATEDIR)/termcap-patches.get

$(STATEDIR)/termcap.get: $(termcap_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/termcap-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(TERMCAP))
	touch $@

$(TERMCAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TERMCAP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

termcap_extract: $(STATEDIR)/termcap.extract

termcap_extract_deps = $(STATEDIR)/termcap.get

$(STATEDIR)/termcap.extract: $(termcap_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TERMCAP_DIR))
	@$(call extract, $(TERMCAP_SOURCE))
	@$(call patchin, $(TERMCAP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

termcap_prepare: $(STATEDIR)/termcap.prepare

#
# dependencies
#
termcap_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/termcap.extract

TERMCAP_PATH	=  PATH=$(CROSS_PATH)
TERMCAP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
TERMCAP_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

ifdef PTXCONF_TERMCAP_TERMCAP
TERMCAP_AUTOCONF += --enable-install-termcap
endif

$(STATEDIR)/termcap.prepare: $(termcap_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TERMCAP_DIR)/config.cache)
	cd $(TERMCAP_DIR) && \
		$(TERMCAP_PATH) $(TERMCAP_ENV) \
		./configure $(TERMCAP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

termcap_compile: $(STATEDIR)/termcap.compile

termcap_compile_deps = $(STATEDIR)/termcap.prepare

$(STATEDIR)/termcap.compile: $(termcap_compile_deps)
	@$(call targetinfo, $@)
	$(TERMCAP_PATH) make -C $(TERMCAP_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

termcap_install: $(STATEDIR)/termcap.install

$(STATEDIR)/termcap.install: $(STATEDIR)/termcap.compile
	@$(call targetinfo, $@)
	$(TERMCAP_PATH) make -C $(TERMCAP_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

termcap_targetinstall: $(STATEDIR)/termcap.targetinstall

termcap_targetinstall_deps = $(STATEDIR)/termcap.install

$(STATEDIR)/termcap.targetinstall: $(termcap_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

termcap_clean:
	rm -rf $(STATEDIR)/termcap.*
	rm -rf $(TERMCAP_DIR)

# vim: syntax=make

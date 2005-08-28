# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: does nothing on targetinstall? 

#
# We provide this package
#
ifdef PTXCONF_POPT
PACKAGES += popt
endif

#
# Paths and names
#
POPT_VERSION	= 1.7
POPT		= popt-$(POPT_VERSION)
POPT_SUFFIX	= tar.gz
POPT_URL	= ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/$(POPT).$(POPT_SUFFIX)
POPT_SOURCE	= $(SRCDIR)/$(POPT).$(POPT_SUFFIX)
POPT_DIR	= $(BUILDDIR)/$(POPT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

popt_get: $(STATEDIR)/popt.get

popt_get_deps = $(POPT_SOURCE)

$(STATEDIR)/popt.get: $(popt_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(POPT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(POPT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

popt_extract: $(STATEDIR)/popt.extract

popt_extract_deps = $(STATEDIR)/popt.get

$(STATEDIR)/popt.extract: $(popt_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(POPT_DIR))
	@$(call extract, $(POPT_SOURCE))
	@$(call patchin, $(POPT))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

popt_prepare: $(STATEDIR)/popt.prepare

#
# dependencies
#
popt_prepare_deps =  \
	$(STATEDIR)/popt.extract \
	$(STATEDIR)/virtual-xchain.install

POPT_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
POPT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
POPT_AUTOCONF = \
	--prefix=$(CROSS_LIB_DIR) \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/popt.prepare: $(popt_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(POP_DIR)/config.cache)
	cd $(POPT_DIR) && \
		$(POPT_PATH) $(POPT_ENV) \
		./configure $(POPT_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

popt_compile: $(STATEDIR)/popt.compile

popt_compile_deps = $(STATEDIR)/popt.prepare

$(STATEDIR)/popt.compile: $(popt_compile_deps)
	@$(call targetinfo, $@)
	cd $(POPT_DIR) && $(POPT_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

popt_install: $(STATEDIR)/popt.install

$(STATEDIR)/popt.install: $(STATEDIR)/popt.compile
	@$(call targetinfo, $@)
	cd $(POPT_DIR) && $(POPT_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

popt_targetinstall: $(STATEDIR)/popt.targetinstall

popt_targetinstall_deps	= $(STATEDIR)/popt.compile

$(STATEDIR)/popt.targetinstall: $(popt_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

popt_clean:
	rm -rf $(STATEDIR)/popt.*
	rm -rf $(IMAGEDIR)/popt_*
	rm -rf $(POPT_DIR)

# vim: syntax=make

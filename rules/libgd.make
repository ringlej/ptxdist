# -*-makefile-*-
# $Id: libgd.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBGD
PACKAGES += libgd
endif

#
# Paths and names
#
LIBGD_VERSION	= 2.0.15
LIBGD		= gd-$(LIBGD_VERSION)
LIBGD_SUFFIX	= tar.gz
LIBGD_URL		= http://www.boutell.com/gd/http/$(LIBGD).$(LIBGD_SUFFIX)
LIBGD_SOURCE	= $(SRCDIR)/$(LIBGD).$(LIBGD_SUFFIX)
LIBGD_DIR		= $(BUILDDIR)/$(LIBGD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgd_get: $(STATEDIR)/libgd.get

libgd_get_deps	=  $(LIBGD_SOURCE)

$(STATEDIR)/libgd.get: $(libgd_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LIBGD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBGD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgd_extract: $(STATEDIR)/libgd.extract

libgd_extract_deps	=  $(STATEDIR)/libgd.get

$(STATEDIR)/libgd.extract: $(libgd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGD_DIR))
	@$(call extract, $(LIBGD_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgd_prepare: $(STATEDIR)/libgd.prepare

#
# dependencies
#
libgd_prepare_deps =  \
	$(STATEDIR)/libgd.extract \
	$(STATEDIR)/virtual-xchain.install

LIBGD_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
LIBGD_ENV 	=  $(CROSS_ENV)
#LIBGD_ENV	+=


#
# autoconf
#
LIBGD_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
LIBGD_AUTOCONF	+= --build=$(GNU_HOST)
LIBGD_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

#LIBGD_AUTOCONF	+= 

$(STATEDIR)/libgd.prepare: $(libgd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGD_BUILDDIR))
	cd $(LIBGD_DIR) && \
		$(LIBGD_PATH) $(LIBGD_ENV) \
		./configure $(LIBGD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgd_compile: $(STATEDIR)/libgd.compile

libgd_compile_deps =  $(STATEDIR)/libgd.prepare

$(STATEDIR)/libgd.compile: $(libgd_compile_deps)
	@$(call targetinfo, $@)
	$(LIBGD_PATH) $(LIBGD_ENV) make -C $(LIBGD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgd_install: $(STATEDIR)/libgd.install

$(STATEDIR)/libgd.install: $(STATEDIR)/libgd.compile
	@$(call targetinfo, $@)
	$(LIBGD_PATH) $(LIBGD_ENV) make -C $(LIBGD_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgd_targetinstall: $(STATEDIR)/libgd.targetinstall

libgd_targetinstall_deps	=  $(STATEDIR)/libgd.compile

$(STATEDIR)/libgd.targetinstall: $(libgd_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgd_clean:
	rm -rf $(STATEDIR)/libgd.*
	rm -rf $(LIBGD_DIR)

# vim: syntax=make

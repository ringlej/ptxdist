# -*-makefile-*-
# $Id: lrzsz.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LSZRZ
PACKAGES += lrzsz
endif

#
# Paths and names
#
LSZRZ_VERSION		= 0.12.20
LSZRZ			= lrzsz-$(LSZRZ_VERSION)
LSZRZ_SUFFIX		= tar.gz
LSZRZ_URL		= http://www.ohse.de/uwe/releases/$(LSZRZ).$(LSZRZ_SUFFIX)
LSZRZ_SOURCE		= $(SRCDIR)/$(LSZRZ).$(LSZRZ_SUFFIX)
LSZRZ_DIR		= $(BUILDDIR)/$(LSZRZ)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lrzsz_get: $(STATEDIR)/lrzsz.get

lrzsz_get_deps	=  $(LSZRZ_SOURCE)

$(STATEDIR)/lrzsz.get: $(lrzsz_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LSZRZ_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LSZRZ_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lrzsz_extract: $(STATEDIR)/lrzsz.extract

lrzsz_extract_deps	=  $(STATEDIR)/lrzsz.get

$(STATEDIR)/lrzsz.extract: $(lrzsz_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LSZRZ_DIR))
	@$(call extract, $(LSZRZ_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lrzsz_prepare: $(STATEDIR)/lrzsz.prepare

#
# dependencies
#
lrzsz_prepare_deps =  \
	$(STATEDIR)/lrzsz.extract \
	$(STATEDIR)/virtual-xchain.install

LSZRZ_PATH	=  PATH=$(CROSS_PATH)
LSZRZ_ENV 	=  $(CROSS_ENV)
LSZRZ_ENV	+= CFLAGS=-Wstrict-prototypes

#
# autoconf
#
LSZRZ_AUTOCONF	=  --prefix=/usr
LSZRZ_AUTOCONF	+= --build=$(GNU_HOST)
LSZRZ_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/lrzsz.prepare: $(lrzsz_prepare_deps)
	@$(call targetinfo, $@)
	cd $(LSZRZ_DIR) && \
		$(LSZRZ_PATH) $(LSZRZ_ENV) \
		./configure $(LSZRZ_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lrzsz_compile: $(STATEDIR)/lrzsz.compile

lrzsz_compile_deps =  $(STATEDIR)/lrzsz.prepare

$(STATEDIR)/lrzsz.compile: $(lrzsz_compile_deps)
	@$(call targetinfo, $@)
	$(LSZRZ_PATH) make -C $(LSZRZ_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lrzsz_install: $(STATEDIR)/lrzsz.install

$(STATEDIR)/lrzsz.install: $(STATEDIR)/lrzsz.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lrzsz_targetinstall: $(STATEDIR)/lrzsz.targetinstall

lrzsz_targetinstall_deps	=  $(STATEDIR)/lrzsz.compile

$(STATEDIR)/lrzsz.targetinstall: $(lrzsz_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lrzsz_clean:
	rm -rf $(STATEDIR)/lrzsz.*
	rm -rf $(LSZRZ_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: pango12.make,v 1.11 2004/02/25 22:36:34 robert Exp $
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
ifdef PTXCONF_PANGO12
PACKAGES += pango
endif

#
# Paths and names
#
PANGO12_VERSION		= 1.3.2
PANGO12			= pango-$(PANGO12_VERSION)
PANGO12_SUFFIX		= tar.gz
PANGO12_URL		= ftp://ftp.gnome.org/pub/GNOME/sources/pango/1.3/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_SOURCE		= $(SRCDIR)/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_DIR		= $(BUILDDIR)/$(PANGO12)
PANGO_MODULE_VERSION	= 1.4

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango12_get: $(STATEDIR)/pango12.get

pango12_get_deps	=  $(PANGO12_SOURCE)
pango12_get_deps	+= $(PANGO12_PATCH_SOURCE)

$(STATEDIR)/pango12.get: $(pango12_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(PANGO12_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PANGO12_URL))

$(PANGO12_PATCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PANGO12_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango12_extract: $(STATEDIR)/pango12.extract

pango12_extract_deps	=  $(STATEDIR)/pango12.get

$(STATEDIR)/pango12.extract: $(pango12_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO12_DIR))
	@$(call extract, $(PANGO12_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pango12_prepare: $(STATEDIR)/pango12.prepare

#
# dependencies
#
pango12_prepare_deps =  \
	$(STATEDIR)/pango12.extract \
	$(STATEDIR)/glib22.install \
	$(STATEDIR)/xfree430.install \
	$(STATEDIR)/fontconfig22.install \
	$(STATEDIR)/freetype214.install \
	$(STATEDIR)/virtual-xchain.install


PANGO12_PATH	=  PATH=$(CROSS_PATH)
PANGO12_ENV 	=  $(CROSS_ENV)
PANGO12_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
PANGO12_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
PANGO12_AUTOCONF	+= --build=$(GNU_HOST)
PANGO12_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
PANGO12_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
PANGO12_AUTOCONF	+= --enable-explicit-deps

$(STATEDIR)/pango12.prepare: $(pango12_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO12_BUILDDIR))
	cd $(PANGO12_DIR) && \
		$(PANGO12_PATH) $(PANGO12_ENV) \
		./configure $(PANGO12_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pango12_compile: $(STATEDIR)/pango12.compile

pango12_compile_deps =  $(STATEDIR)/pango12.prepare

$(STATEDIR)/pango12.compile: $(pango12_compile_deps)
	@$(call targetinfo, $@)
	cd $(PANGO12_DIR) && $(PANGO12_PATH) $(PANGO12_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango12_install: $(STATEDIR)/pango12.install

$(STATEDIR)/pango12.install: $(STATEDIR)/pango12.compile
	@$(call targetinfo, $@)
	cd $(PANGO12_DIR) && $(PANGO12_PATH) $(PANGO12_ENV) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pango12_targetinstall: $(STATEDIR)/pango12.targetinstall

pango12_targetinstall_deps	=  $(STATEDIR)/pango12.install
pango12_targetinstall_deps	+= $(STATEDIR)/glib22.targetinstall
pango12_targetinstall_deps	+= $(STATEDIR)/xfree430.targetinstall
pango12_targetinstall_deps	+= $(STATEDIR)/fontconfig22.targetinstall
pango12_targetinstall_deps	+= $(STATEDIR)/freetype214.targetinstall

$(STATEDIR)/pango12.targetinstall: $(pango12_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/lib
	rm -f $(ROOTDIR)/lib/libpango-1.0.so*

	install $(PANGO12_DIR)/pango/.libs/libpango-1.0.so.0.300.2 $(ROOTDIR)/lib/
	ln -sf libpango-1.0.so.0.300.2 $(ROOTDIR)/lib/libpango-1.0.so.0
	ln -sf libpango-1.0.so.0.300.2 $(ROOTDIR)/lib/libpango-1.0.so

	install $(PANGO12_DIR)/pango/.libs/libpangox-1.0.so.0.300.2 $(ROOTDIR)/lib/
	ln -sf libpangox-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangox-1.0.so.0
	ln -sf  libpangox-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangox-1.0.so

	install $(PANGO12_DIR)/pango/.libs/libpangoxft-1.0.so.0.300.2 $(ROOTDIR)/lib/
	ln -sf libpangoxft-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangoxft-1.0.so.0
	ln -sf  libpangoxft-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangoxft-1.0.so

	install $(PANGO12_DIR)/pango/.libs/libpangoft2-1.0.so.0.300.2 $(ROOTDIR)/lib/
	ln -sf libpangoft2-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangoft2-1.0.so.0
	ln -sf  libpangoft2-1.0.so.0.300.2 $(ROOTDIR)/lib/libpangoft2-1.0.so
	
	install $(PANGO12_DIR)/pango/.libs/pango-querymodules $(ROOTDIR)/usr/bin
	cp -a $(CROSS_LIB_DIR)/lib/pango $(ROOTDIR)/usr/lib
	touch $@
	
	install -d $(ROOTDIR)/usr/lib/pango/$(PANGO_MODULE_VERSION)/modules
	cp $(PANGO12_DIR)/modules/basic/.libs/*.so $(ROOTDIR)/usr/lib/pango/$(PANGO_MODULE_VERSION)/modules
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango12_clean:
	rm -rf $(STATEDIR)/pango12.*
	rm -rf $(PANGO12_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/pango*

# vim: syntax=make

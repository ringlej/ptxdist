# -*-makefile-*-
# $Id: pango12.make,v 1.2 2003/08/17 00:32:04 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
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
PANGO12_VERSION		= 1.2.3
PANGO12			= pango-$(PANGO12_VERSION)
PANGO12_SUFFIX		= tar.gz
PANGO12_URL		= ftp://ftp.gtk.org/pub/gtk/v2.2/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_SOURCE		= $(SRCDIR)/$(PANGO12).$(PANGO12_SUFFIX)
PANGO12_DIR		= $(BUILDDIR)/$(PANGO12)
PANGO12_PATCH		= $(PANGO12)-ptx1.diff
PANGO12_PATCH_SOURCE	= $(SRCDIR)/$(PANGO12_PATCH)
PANGO12_PATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(PANGO12_PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango12_get: $(STATEDIR)/pango12.get

pango12_get_deps	=  $(PANGO12_SOURCE)
pango12_get_deps	+= $(PANGO12_PATCH_SOURCE)

$(STATEDIR)/pango12.get: $(pango12_get_deps)
	@$(call targetinfo, pango12.get)
	touch $@

$(PANGO12_SOURCE):
	@$(call targetinfo, $(PANGO12_SOURCE))
	@$(call get, $(PANGO12_URL))

$(PANGO12_PATCH_SOURCE):
	@$(call targetinfo, $(PANGO12_PATCH_SOURCE))
	@$(call get, $(PANGO12_PATCH_URL))
	
# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango12_extract: $(STATEDIR)/pango12.extract

pango12_extract_deps	=  $(STATEDIR)/pango12.get

$(STATEDIR)/pango12.extract: $(pango12_extract_deps)
	@$(call targetinfo, pango12.extract)
	@$(call clean, $(PANGO12_DIR))
	@$(call extract, $(PANGO12_SOURCE))
	cd $(PANGO12_DIR) && patch -p1 < $(PANGO12_PATCH_SOURCE)
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
#	$(STATEDIR)/fontconfig22.install \
#	$(STATEDIR)/virtual-xchain.install

PANGO12_PATH	=  PATH=$(CROSS_PATH)
PANGO12_ENV 	=  $(CROSS_ENV)
PANGO12_ENV	+= PKG_CONFIG_PATH=../$(GLIB22):../$(ATK124):../$(PANGO12):../$(GTK22)

# FIXME: pango does not use pkg-config yet...
PANGO12_ENV	+= ac_cv_path_FREETYPE_CONFIG=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin/freetype-config

#
# autoconf
#
PANGO12_AUTOCONF	=  --prefix=/usr
PANGO12_AUTOCONF	+= --build=$(GNU_HOST)
PANGO12_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
PANGO12_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include

$(STATEDIR)/pango12.prepare: $(pango12_prepare_deps)
	@$(call targetinfo, pango12.prepare)
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
	@$(call targetinfo, pango12.compile)

	# FIXME: feed upstream; these links are expected by gtk and seem
	# to have been forgetten. 
	ln -sf libpangoxft-1.0.la $(PANGO12_DIR)/pango/libpangoxft.la
	ln -sf libpango-1.0.la $(PANGO12_DIR)/pango/libpango.la
	ln -sf libpangox-1.0.la $(PANGO12_DIR)/pango/libpangox.la
	
	$(PANGO12_PATH) $(PANGO12_ENV) make -C $(PANGO12_DIR)

	# FIXME: let gtk not see xft
	cd $(PANGO12_DIR) && mv pangoxft-uninstalled.pc NOINST-pangoxft-uninstalled.pc
	cd $(PANGO12_DIR) && mv pangoxft.pc NOINST-pangoxft.pc

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango12_install: $(STATEDIR)/pango12.install

$(STATEDIR)/pango12.install: $(STATEDIR)/pango12.compile
	@$(call targetinfo, pango12.install)
	
	install -d $(PTXCONF_PREFIX)/$(PTX_GNU_TARGET)/lib
	rm -f $(PTXCONF_PREFIX)/$(PTX_GNU_TARGET)/lib/libpango-1.0.so*
	install $(PANGO12_DIR)/pango/.libs/libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/
	ln -sf libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpango-1.0.so.0
	ln -sf libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpango-1.0.so
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/pango*.h
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/pango
	cp $(PANGO12_DIR)/pango/pango*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/pango

	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pango12_targetinstall: $(STATEDIR)/pango12.targetinstall

pango12_targetinstall_deps	=  $(STATEDIR)/pango12.compile

$(STATEDIR)/pango12.targetinstall: $(pango12_targetinstall_deps)
	@$(call targetinfo, pango12.targetinstall)
	install -d $(ROOTDIR)/lib
	rm -f $(ROOTDIR)/lib/libpango-1.0.so*
	install $(PANGO12_DIR)/pango/.libs/libpango-1.0.so.0.200.3 $(ROOTDIR)/lib/
	ln -sf libpango-1.0.so.0.200.3 $(ROOTDIR)/lib/libpango-1.0.so.0
	ln -sf libpango-1.0.so.0.200.3 $(ROOTDIR)/lib/libpango-1.0.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango12_clean:
	rm -rf $(STATEDIR)/pango12.*
	rm -rf $(PANGO12_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/pango*

# vim: syntax=make

# -*-makefile-*-
# $Id: pango12.make,v 1.1 2003/08/15 00:36:06 robert Exp $
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

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango12_get: $(STATEDIR)/pango12.get

pango12_get_deps	=  $(PANGO12_SOURCE)

$(STATEDIR)/pango12.get: $(pango12_get_deps)
	@$(call targetinfo, pango12.get)
	touch $@

$(PANGO12_SOURCE):
	@$(call targetinfo, $(PANGO12_SOURCE))
	@$(call get, $(PANGO12_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango12_extract: $(STATEDIR)/pango12.extract

pango12_extract_deps	=  $(STATEDIR)/pango12.get

$(STATEDIR)/pango12.extract: $(pango12_extract_deps)
	@$(call targetinfo, pango12.extract)
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
#	$(STATEDIR)/virtual-xchain.install

PANGO12_PATH	=  PATH=$(CROSS_PATH)
PANGO12_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
PANGO12_AUTOCONF	=  --prefix=/usr
PANGO12_AUTOCONF	+= --build=$(GNU_HOST)
PANGO12_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/pango12.prepare: $(pango12_prepare_deps)
	@$(call targetinfo, pango12.prepare)
	@$(call clean, $(PANGO12_BUILDDIR))
	cd $(PANGO12_DIR) && \
		$(PANGO12_PATH) $(PANGO12_ENV) \
		$(PANGO12_DIR)/configure $(PANGO12_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pango12_compile: $(STATEDIR)/pango12.compile

pango12_compile_deps =  $(STATEDIR)/pango12.prepare

$(STATEDIR)/pango12.compile: $(pango12_compile_deps)
	@$(call targetinfo, pango12.compile)
	$(PANGO12_PATH) make -C $(PANGO12_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango12_install: $(STATEDIR)/pango12.install

$(STATEDIR)/pango12.install: $(STATEDIR)/pango12.compile
	@$(call targetinfo, pango12.install)
	install -d $(PTXCONF_PREFIX)/lib
	rm -f $(PTXCONF_PREFIX)/lib/libpango-1.0.so*
	install $(PANGO12_DIR)/pango/.libs/libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/lib/
	ln -s libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/lib/libpango-1.0.so.0
	ln -s libpango-1.0.so.0.200.3 $(PTXCONF_PREFIX)/lib/libpango-1.0.so
	rm -f $(PTXCONF_PREFIX)/include/pango*.h
	install $(PANGO12_DIR)/pango/pango*.h $(PTXCONF_PREFIX)/include
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
	ln -s libpango-1.0.so.0.200.3 $(ROOTDIR)/lib/libpango-1.0.so.0
	ln -s libpango-1.0.so.0.200.3 $(ROOTDIR)/lib/libpango-1.0.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango12_clean:
	rm -rf $(STATEDIR)/pango12.*
	rm -rf $(PANGO12_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBGNOMECANVAS
PACKAGES += libgnomecanvas
endif

#
# Paths and names
#
LIBGNOMECANVAS_VERSION	= 2.5.90
LIBGNOMECANVAS		= libgnomecanvas-$(LIBGNOMECANVAS_VERSION)
LIBGNOMECANVAS_SUFFIX	= tar.bz2
LIBGNOMECANVAS_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/libgnomecanvas/2.5/$(LIBGNOMECANVAS).$(LIBGNOMECANVAS_SUFFIX)
LIBGNOMECANVAS_SOURCE	= $(SRCDIR)/$(LIBGNOMECANVAS).$(LIBGNOMECANVAS_SUFFIX)
LIBGNOMECANVAS_DIR	= $(BUILDDIR)/$(LIBGNOMECANVAS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgnomecanvas_get: $(STATEDIR)/libgnomecanvas.get

libgnomecanvas_get_deps = $(LIBGNOMECANVAS_SOURCE)

$(STATEDIR)/libgnomecanvas.get: $(libgnomecanvas_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LIBGNOMECANVAS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBGNOMECANVAS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgnomecanvas_extract: $(STATEDIR)/libgnomecanvas.extract

libgnomecanvas_extract_deps = $(STATEDIR)/libgnomecanvas.get

$(STATEDIR)/libgnomecanvas.extract: $(libgnomecanvas_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGNOMECANVAS_DIR))
	@$(call extract, $(LIBGNOMECANVAS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgnomecanvas_prepare: $(STATEDIR)/libgnomecanvas.prepare

#
# dependencies
#
libgnomecanvas_prepare_deps = \
	$(STATEDIR)/libgnomecanvas.extract \
	$(STATEDIR)/libglade.install \
	$(STATEDIR)/libart.install \
	$(STATEDIR)/virtual-xchain.install

LIBGNOMECANVAS_PATH	=  PATH=$(CROSS_PATH)
LIBGNOMECANVAS_ENV 	=  $(CROSS_ENV)
LIBGNOMECANVAS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
LIBGNOMECANVAS_AUTOCONF =  $(CROSS_AUTOCONF)
LIBGNOMECANVAS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/libgnomecanvas.prepare: $(libgnomecanvas_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGNOMECANVAS_DIR)/config.cache)
	cd $(LIBGNOMECANVAS_DIR) && \
		$(LIBGNOMECANVAS_PATH) $(LIBGNOMECANVAS_ENV) \
		./configure $(LIBGNOMECANVAS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgnomecanvas_compile: $(STATEDIR)/libgnomecanvas.compile

libgnomecanvas_compile_deps = $(STATEDIR)/libgnomecanvas.prepare

$(STATEDIR)/libgnomecanvas.compile: $(libgnomecanvas_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBGNOMECANVAS_DIR) && \
	   $(LIBGNOMECANVAS_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgnomecanvas_install: $(STATEDIR)/libgnomecanvas.install

$(STATEDIR)/libgnomecanvas.install: $(STATEDIR)/libgnomecanvas.compile
	@$(call targetinfo, $@)
	cd $(LIBGNOMECANVAS_DIR) && \
	$(LIBGNOMECANVAS_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgnomecanvas_targetinstall: $(STATEDIR)/libgnomecanvas.targetinstall

libgnomecanvas_targetinstall_deps = $(STATEDIR)/libgnomecanvas.compile
libgnomecanvas_targetinstall_deps = $(STATEDIR)/libart.targetinstall

$(STATEDIR)/libgnomecanvas.targetinstall: $(libgnomecanvas_targetinstall_deps)
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)/usr/lib
        
	install $(LIBGNOMECANVAS_DIR)/libgnomecanvas/.libs/libgnomecanvas-2.so.0.590.0 $(ROOTDIR)/usr/lib
	ln -sf libgnomecanvas-2.so.0.590.0 $(ROOTDIR)/usr/lib/libgnomecanvas-2.so.0
	ln -sf libgnomecanvas-2.so.0.590.0 $(ROOTDIR)/usr/lib/libgnomecanvas-2.so

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgnomecanvas_clean:
	rm -rf $(STATEDIR)/libgnomecanvas.*
	rm -rf $(LIBGNOMECANVAS_DIR)

# vim: syntax=make

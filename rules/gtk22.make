# -*-makefile-*-
# $Id: gtk22.make,v 1.8 2004/02/25 22:33:07 robert Exp $
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
ifdef PTXCONF_GTK22
PACKAGES += gtk22
endif

#
# Paths and names
#
GTK22_VERSION		= 2.3.2
GTK22			= gtk+-$(GTK22_VERSION)
GTK22_SUFFIX		= tar.gz
GTK22_URL		= ftp://ftp.gtk.org/pub/gtk/v2.3/$(GTK22).$(GTK22_SUFFIX)
GTK22_SOURCE		= $(SRCDIR)/$(GTK22).$(GTK22_SUFFIX)
GTK22_DIR		= $(BUILDDIR)/$(GTK22)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk22_get: $(STATEDIR)/gtk22.get

gtk22_get_deps	=  $(GTK22_SOURCE)

$(STATEDIR)/gtk22.get: $(gtk22_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GTK22_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GTK22_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk22_extract: $(STATEDIR)/gtk22.extract

gtk22_extract_deps	=  $(STATEDIR)/gtk22.get

$(STATEDIR)/gtk22.extract: $(gtk22_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK22_DIR))
	@$(call extract, $(GTK22_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk22_prepare: $(STATEDIR)/gtk22.prepare

#
# dependencies
#
gtk22_prepare_deps =  \
	$(STATEDIR)/gtk22.extract \
	$(STATEDIR)/glib22.install \
	$(STATEDIR)/atk.install \
	$(STATEDIR)/pango12.install \
	$(STATEDIR)/freetype214.install \
	$(STATEDIR)/virtual-xchain.install \

GTK22_PATH	=  PATH=$(CROSS_PATH)
GTK22_ENV 	=  $(CROSS_ENV)
GTK22_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/
GTK22_ENV	+= FREETYPE_CONFIG="pkg-config freetype2"
#GTK22_ENV	+= CFLAGS=-I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include

#
# autoconf
#
GTK22_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
GTK22_AUTOCONF	+= --build=$(GNU_HOST)
GTK22_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GTK22_AUTOCONF	+= --with-x=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/X11R6
# FIXME
GTK22_AUTOCONF	+= --without-libtiff
GTK22_AUTOCONF	+= --without-libjpeg


$(STATEDIR)/gtk22.prepare: $(gtk22_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK22_BUILDDIR))
	cd $(GTK22_DIR) && \
		$(GTK22_PATH) $(GTK22_ENV) \
		./configure $(GTK22_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk22_compile: $(STATEDIR)/gtk22.compile

gtk22_compile_deps =  $(STATEDIR)/gtk22.prepare

$(STATEDIR)/gtk22.compile: $(gtk22_compile_deps)
	@$(call targetinfo, $@)
	cd $(GTK22_DIR) && $(GTK22_PATH) $(GTK22_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk22_install: $(STATEDIR)/gtk22.install

gtk22_install_deps	=  $(STATEDIR)/gtk22.compile

$(STATEDIR)/gtk22.install: $(gtk22_install_deps)
	@$(call targetinfo, $@)
	cd $(GTK22_DIR) && $(GTK22_PATH) $(GTK22_ENV) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk22_targetinstall: $(STATEDIR)/gtk22.targetinstall

gtk22_targetinstall_deps	=  $(STATEDIR)/gtk22.install
gtk22_targetinstall_deps	+= $(STATEDIR)/fontconfig22.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/freetype214.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/libidl-2.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/pango12.targetinstall

$(STATEDIR)/gtk22.targetinstall: $(gtk22_targetinstall_deps)
	@$(call targetinfo, $@)
	
	install -d $(ROOTDIR)/usr/lib
	
	install $(GTK22_DIR)/gtk/.libs/libgtk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib
	ln -sf libgtk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgtk-x11-2.0.so.0
	ln -sf libgtk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgtk-x11-2.0.so
	
	install $(GTK22_DIR)/gdk/.libs/libgdk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib
	ln -sf libgdk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgdk-x11-2.0.so.0
	ln -sf libgdk-x11-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgdk-x11-2.0.so

	install $(GTK22_DIR)/gdk-pixbuf/.libs/libgdk_pixbuf-2.0.so.0.302.0 $(ROOTDIR)/usr/lib
	ln -sf libgdk_pixbuf-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgdk_pixbuf-2.0.so.0
	ln -sf libgdk_pixbuf-2.0.so.0.302.0 $(ROOTDIR)/usr/lib/libgdk_pixbuf-2.0.so
	
	install $(GTK22_DIR)/gdk-pixbuf/.libs/gdk-pixbuf-query-loaders $(ROOTDIR)/usr/bin
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk22_clean:
	rm -rf $(STATEDIR)/gtk22.*
	rm -rf $(GTK22_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_GTK22) += gtk22

#
# Paths and names
#
GTK22_VERSION		= 2.3.2
GTK22			= gtk+-$(GTK22_VERSION)
GTK22_SUFFIX		= tar.gz
GTK22_URL		= ftp://ftp.gtk.org/pub/gtk/v2.3/$(GTK22).$(GTK22_SUFFIX)
GTK22_SOURCE		= $(SRCDIR)/$(GTK22).$(GTK22_SUFFIX)
GTK22_DIR		= $(BUILDDIR)/$(GTK22)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk22_get: $(STATEDIR)/gtk22.get

gtk22_get_deps	=  $(GTK22_SOURCE)

$(STATEDIR)/gtk22.get: $(gtk22_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

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
	@$(call patchin, $(GTK22))
	@$(call touch, $@)

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
	$(STATEDIR)/freetype.install \
	$(STATEDIR)/virtual-xchain.install \

GTK22_PATH	=  PATH=$(CROSS_PATH)
GTK22_ENV 	=  $(CROSS_ENV)
GTK22_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/
GTK22_ENV	+= FREETYPE_CONFIG="pkg-config freetype2"
#GTK22_ENV	+= CFLAGS=-I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include

#
# autoconf
#
GTK22_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
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

	# Tweak alert! gdk-pixbuf-csource leaks in when being available 
	# on the host... so don't compile demos at all. 
	
	perl -i -p -e 's/^SRC_SUBDIRS =(.*) demos (.*)$$/SRC_SUBDIRS = $$1 $$2/g' $(GTK22_DIR)/Makefile
	 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk22_compile: $(STATEDIR)/gtk22.compile

gtk22_compile_deps =  $(STATEDIR)/gtk22.prepare

$(STATEDIR)/gtk22.compile: $(gtk22_compile_deps)
	@$(call targetinfo, $@)
	cd $(GTK22_DIR) && $(GTK22_PATH) $(GTK22_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk22_install: $(STATEDIR)/gtk22.install

gtk22_install_deps	=  $(STATEDIR)/gtk22.compile

$(STATEDIR)/gtk22.install: $(gtk22_install_deps)
	@$(call targetinfo, $@)
	@$(call install, GTK22)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk22_targetinstall: $(STATEDIR)/gtk22.targetinstall

gtk22_targetinstall_deps	=  $(STATEDIR)/gtk22.install
gtk22_targetinstall_deps	+= $(STATEDIR)/fontconfig22.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/freetype.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/libidl-2.targetinstall
gtk22_targetinstall_deps	+= $(STATEDIR)/pango12.targetinstall

$(STATEDIR)/gtk22.targetinstall: $(gtk22_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gtk22)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GTK22_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(GTK22_DIR)/gtk/.libs/libgtk-x11-2.0.so.0.302.0, \
		/usr/lib/libgtk-x11-2.0.so.0.302.0)
	@$(call install_link, libgtk-x11-2.0.so.0.302.0, /usr/lib/libgtk-x11-2.0.so.0)
	@$(call install_link, libgtk-x11-2.0.so.0.302.0, /usr/lib/libgtk-x11-2.0.so)
	
	@$(call install_copy, 0, 0, 0644, \
		$(GTK22_DIR)/gdk/.libs/libgdk-x11-2.0.so.0.302.0, \
		/usr/lib/libgdk-x11-2.0.so.0.302.0)
	@$(call install_link, libgdk-x11-2.0.so.0.302.0, /usr/lib/libgdk-x11-2.0.so.0)
	@$(call install_link, libgdk-x11-2.0.so.0.302.0, /usr/lib/libgdk-x11-2.0.so)

	@$(call install_copy, 0, 0, 0644, \
		$(GTK22_DIR)/gdk-pixbuf/.libs/libgdk_pixbuf-2.0.so.0.302.0, \
		/usr/lib/libgdk_pixbuf-2.0.so.0.302.0)
	@$(call install_link, libgdk_pixbuf-2.0.so.0.302.0, /usr/lib/libgdk_pixbuf-2.0.so.0)
	@$(call install_link, libgdk_pixbuf-2.0.so.0.302.0, /usr/lib/libgdk_pixbuf-2.0.so)
	
	@$(call install_copy, 0, 0, 0644, \
		$(GTK22_DIR)/gdk-pixbuf/.libs/gdk-pixbuf-query-loaders, \
		/usr/bin/gdk-pixbuf-query-loaders)
	@$(call install_copy, 0, 0, 0644, \
		$(GTK22_DIR)/gdk-pixbuf/.libs/libpixbufloader*so, \
		/usr/lib/gdk-pixbuf-loaders/)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk22_clean:
	rm -rf $(STATEDIR)/gtk22.*
	rm -rf $(IMAGEDIR)/gtk22_*
	rm -rf $(GTK22_DIR)

# vim: syntax=make

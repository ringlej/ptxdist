# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK) += gtk

#
# Paths and names
#
GTK_VERSION	:= 2.12.12
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.bz2
GTK_URL		:= http://ftp.gtk.org/pub/gtk/2.12/$(GTK).$(GTK_SUFFIX)
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GTK_SOURCE):
	@$(call targetinfo)
	@$(call get, GTK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GTK_PATH	:= PATH=$(CROSS_PATH)

# cups-config otherwhise picks up the host version
GTK_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_CUPS_CONFIG=no

GTK_LOADER-$(PTXCONF_GTK_LOADER_PNG)	+= png
GTK_LOADER-$(PTXCONF_GTK_LOADER_BMP)	+= bmp
GTK_LOADER-$(PTXCONF_GTK_LOADER_WBMP)	+= wbmp
GTK_LOADER-$(PTXCONF_GTK_LOADER_GIF)	+= gif
GTK_LOADER-$(PTXCONF_GTK_LOADER_ICO)	+= ico
GTK_LOADER-$(PTXCONF_GTK_LOADER_ANI)	+= ani
GTK_LOADER-$(PTXCONF_GTK_LOADER_JPEG)	+= jpeg
GTK_LOADER-$(PTXCONF_GTK_LOADER_PNM)	+= pnm
GTK_LOADER-$(PTXCONF_GTK_LOADER_RAS)	+= ras
GTK_LOADER-$(PTXCONF_GTK_LOADER_TIFF)	+= tiff
GTK_LOADER-$(PTXCONF_GTK_LOADER_XPM)	+= xpm
GTK_LOADER-$(PTXCONF_GTK_LOADER_TGA)	+= tga
GTK_LOADER-$(PTXCONF_GTK_LOADER_PCX)	+= pcx

#
# autoconf
#
GTK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--enable-explicit-deps=yes \
	--disable-glibtest \
	--disable-modules \
	--with-included-loaders=$(subst $(space),$(comma),$(GTK_LOADER-y))

ifndef PTXCONF_GTK_LOADER_PNG
GTK_AUTOCONF += --without-libpng
endif

ifndef PTXCONF_GTK_LOADER_TIFF
GTK_AUTOCONF += --without-libtiff
endif

ifndef PTXCONF_GTK_LOADER_JPEG
GTK_AUTOCONF += --without-libjpeg
endif

ifdef PTXCONF_GTK_TARGET_X11
GTK_AUTOCONF += --with-gdktarget=x11
endif

ifdef PTXCONF_GTK_TARGET_DIRECTFB
GTK_AUTOCONF += --with-gdktarget=directfb
endif

ifdef PTXCONF_GTK_TARGET_WIN32
GTK_AUTOCONF += --with-gdktarget=win32
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk)
	@$(call install_fixup,gtk,PACKAGE,gtk)
	@$(call install_fixup,gtk,PRIORITY,optional)
	@$(call install_fixup,gtk,VERSION,$(GTK_VERSION))
	@$(call install_fixup,gtk,SECTION,base)
	@$(call install_fixup,gtk,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,gtk,DEPENDS,)
	@$(call install_fixup,gtk,DESCRIPTION,missing)

ifdef PTXCONF_GTK_TARGET_DIRECTFB
	@$(call install_copy, gtk, 0, 0, 0644, \
		$(GTK_DIR)/gdk/.libs/libgdk-directfb-2.0.so.0.1200.12, \
		/usr/lib/libgdk-directfb-2.0.so.0.1200.12)
	@$(call install_link, gtk, libgdk-directfb-2.0.so.0.1200.12, /usr/lib/libgdk-directfb-2.0.so.0)
	@$(call install_link, gtk, libgdk-directfb-2.0.so.0.1200.12, /usr/lib/libgdk-directfb-2.0.so)

	@$(call install_copy, gtk, 0, 0, 0644, \
		$(GTK_DIR)/gtk/.libs/libgtk-directfb-2.0.so.0.1200.12, \
		/usr/lib/libgtk-directfb-2.0.so.0.1200.12)
	@$(call install_link, gtk, libgtk-directfb-2.0.so.0.1200.12, /usr/lib/libgtk-directfb-2.0.so.0)
	@$(call install_link, gtk, libgtk-directfb-2.0.so.0.1200.12, /usr/lib/libgtk-directfb-2.0.so)
endif

ifdef PTXCONF_GTK_TARGET_X11
	@$(call install_copy, gtk, 0, 0, 0644, \
		$(GTK_DIR)/gdk/.libs/libgdk-x11-2.0.so.0.1200.12, \
		/usr/lib/libgdk-x11-2.0.so.0.1200.12)
	@$(call install_link, gtk, libgdk-x11-2.0.so.0.1200.12, /usr/lib/libgdk-x11-2.0.so.0)
	@$(call install_link, gtk, libgdk-x11-2.0.so.0.1200.12, /usr/lib/libgdk-x11-2.0.so)

	@$(call install_copy, gtk, 0, 0, 0644, \
		$(GTK_DIR)/gtk/.libs/libgtk-x11-2.0.so.0.1200.12, \
		/usr/lib/libgtk-x11-2.0.so.0.1200.12)
	@$(call install_link, gtk, libgtk-x11-2.0.so.0.1200.12, /usr/lib/libgtk-x11-2.0.so.0)
	@$(call install_link, gtk, libgtk-x11-2.0.so.0.1200.12, /usr/lib/libgtk-x11-2.0.so)
endif

	@$(call install_copy, gtk, 0, 0, 0644, \
		$(GTK_DIR)/gdk-pixbuf/.libs/libgdk_pixbuf-2.0.so.0.1200.12, \
		/usr/lib/libgdk_pixbuf-2.0.so.0.1200.12)
	@$(call install_link, gtk, libgdk_pixbuf-2.0.so.0.1200.12, /usr/lib/libgdk_pixbuf-2.0.so.0)
	@$(call install_link, gtk, libgdk_pixbuf-2.0.so.0.1200.12, /usr/lib/libgdk_pixbuf-2.0.so)

ifdef PTXCONF_GTK_DEMO
	@$(call install_copy, gtk, 0, 0, 0755, \
		$(GTK_DIR)/tests/testgtk, \
		/usr/bin/testgtk)
endif

	@$(call install_finish,gtk)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk_clean:
	rm -rf $(STATEDIR)/gtk.*
	rm -rf $(PKGDIR)/gtk_*
	rm -rf $(GTK_DIR)

# vim: syntax=make

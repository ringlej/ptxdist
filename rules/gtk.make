# -*-makefile-*-
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
GTK_VERSION	:= 2.18.7
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.bz2
GTK_URL		:= http://ftp.gtk.org/pub/gtk/2.18/$(GTK).$(GTK_SUFFIX)
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
	--with-included-loaders=$(subst $(space),$(comma),$(GTK_LOADER-y)) \
	gio_can_sniff=yes

ifndef PTXCONF_GTK_LOADER_PNG
GTK_AUTOCONF += --without-libpng
endif

ifndef PTXCONF_GTK_LOADER_TIFF
GTK_AUTOCONF += --without-libtiff
endif

ifndef PTXCONF_GTK_LOADER_JPEG
GTK_AUTOCONF += --without-libjpeg
endif

ifndef PTXCONF_GTK_LOADER_JPEG2000
GTK_AUTOCONF += --without-libjasper
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

GTK_VERSION_TUPLE := $(subst ., ,$(GTK_VERSION))
GTK_LIBVERSION := 0.$(word 2,$(GTK_VERSION_TUPLE))00.$(word 3,$(GTK_VERSION_TUPLE))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk.install:
	@$(call targetinfo)
	@$(call install, GTK)
	@install  -m 755 -D $(GTK_DIR)/tests/testgtk $(GTK_PKGDIR)/usr/bin/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk)
	@$(call install_fixup,gtk,PRIORITY,optional)
	@$(call install_fixup,gtk,SECTION,base)
	@$(call install_fixup,gtk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,gtk,DESCRIPTION,missing)

# reviewed: 2.14.7 wants to install this:
#
# /usr/bin/gdk-pixbuf-csource
# /usr/bin/gtk-update-icon-cache
# /usr/bin/gtk-query-immodules-2.0
# /usr/bin/gdk-pixbuf-query-loaders
# /usr/bin/gtk-demo
# /usr/bin/gtk-builder-convert
# /usr/share/themes/Default
# /usr/share/themes/Default/gtk-2.0-key
# /usr/share/themes/Default/gtk-2.0-key/gtkrc
# /usr/share/themes/Emacs
# /usr/share/themes/Emacs/gtk-2.0-key
# /usr/share/themes/Emacs/gtk-2.0-key/gtkrc
# /usr/share/themes/Raleigh
# /usr/share/themes/Raleigh/gtk-2.0
# /usr/share/themes/Raleigh/gtk-2.0/gtkrc
# /usr/lib/libgdk_pixbuf-2.0.so.$(GTK_LIBVERSION)
# /usr/lib/libgdk-directfb-2.0.so
# /usr/lib/gtk-2.0/modules/libferret.so
# /usr/lib/gtk-2.0/modules/libgail.so
# /usr/lib/gtk-2.0/2.10.0/engines/libpixmap.so
# /usr/lib/gtk-2.0/2.10.0/printbackends/libprintbackend-lpr.so
# /usr/lib/gtk-2.0/2.10.0/printbackends/libprintbackend-file.so
# /usr/lib/libgdk_pixbuf-2.0.so.0
# /usr/lib/libgdk-directfb-2.0.so.0
# /usr/lib/libgailutil.so.18
# /usr/lib/libgailutil.so
# /usr/lib/libgdk_pixbuf-2.0.so
# /usr/lib/libgtk-directfb-2.0.so.0
# /usr/lib/libgdk-directfb-2.0.so.$(GTK_LIBVERSION)
# /usr/lib/libgtk-directfb-2.0.so
# /usr/lib/libgtk-directfb-2.0.so.$(GTK_LIBVERSION)
# /etc/gtk-2.0/im-multipress.conf

ifdef PTXCONF_GTK_TARGET_DIRECTFB
	@$(call install_copy, gtk, 0, 0, 0644, -, /usr/lib/libgdk-directfb-2.0.so.$(GTK_LIBVERSION))
	@$(call install_link, gtk, libgdk-directfb-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk-directfb-2.0.so.0)
	@$(call install_link, gtk, libgdk-directfb-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk-directfb-2.0.so)

	@$(call install_copy, gtk, 0, 0, 0644, -, /usr/lib/libgtk-directfb-2.0.so.$(GTK_LIBVERSION))
	@$(call install_link, gtk, libgtk-directfb-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgtk-directfb-2.0.so.0)
	@$(call install_link, gtk, libgtk-directfb-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgtk-directfb-2.0.so)
endif

ifdef PTXCONF_GTK_TARGET_X11
	@$(call install_copy, gtk, 0, 0, 0644, -, /usr/lib/libgdk-x11-2.0.so.$(GTK_LIBVERSION))
	@$(call install_link, gtk, libgdk-x11-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk-x11-2.0.so.0)
	@$(call install_link, gtk, libgdk-x11-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk-x11-2.0.so)

	@$(call install_copy, gtk, 0, 0, 0644, -, /usr/lib/libgtk-x11-2.0.so.$(GTK_LIBVERSION))
	@$(call install_link, gtk, libgtk-x11-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgtk-x11-2.0.so.0)
	@$(call install_link, gtk, libgtk-x11-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgtk-x11-2.0.so)
endif

	@$(call install_copy, gtk, 0, 0, 0644, -, /usr/lib/libgdk_pixbuf-2.0.so.$(GTK_LIBVERSION))
	@$(call install_link, gtk, libgdk_pixbuf-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk_pixbuf-2.0.so.0)
	@$(call install_link, gtk, libgdk_pixbuf-2.0.so.$(GTK_LIBVERSION), /usr/lib/libgdk_pixbuf-2.0.so)

ifdef PTXCONF_GTK_DEMO
	@$(call install_copy, gtk, 0, 0, 0755, -,\
		/usr/bin/testgtk)
endif

	@$(call install_finish,gtk)

	@$(call touch)

# vim: syntax=make

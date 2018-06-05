# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GDK_PIXBUF) += gdk-pixbuf

#
# Paths and names
#
GDK_PIXBUF_VERSION	:= 2.24.0
GDK_PIXBUF_MD5		:= d8ece3a4ade4a91c768328620e473ab8
GDK_PIXBUF		:= gdk-pixbuf-$(GDK_PIXBUF_VERSION)
GDK_PIXBUF_SUFFIX	:= tar.bz2
GDK_PIXBUF_URL		:= http://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/2.24/$(GDK_PIXBUF).$(GDK_PIXBUF_SUFFIX)
GDK_PIXBUF_SOURCE	:= $(SRCDIR)/$(GDK_PIXBUF).$(GDK_PIXBUF_SUFFIX)
GDK_PIXBUF_DIR		:= $(BUILDDIR)/$(GDK_PIXBUF)
GDK_PIXBUF_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GDK_PIXBUF_CONF_ENV	:= $(CROSS_ENV) \
	gio_can_sniff=yes

#
# autoconf
#
GDK_PIXBUF_CONF_TOOL	:= autoconf
GDK_PIXBUF_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-rebuilds \
	--enable-explicit-deps=no \
	--disable-nls \
	--disable-rpath \
	--disable-glibtest \
	--disable-modules \
	--disable-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--enable-Bsymbolic \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--$(call ptx/wwo, PTXCONF_GDK_PIXBUF_LOADER_PNG)-libpng \
	--$(call ptx/wwo, PTXCONF_GDK_PIXBUF_LOADER_JPEG)-libjpeg \
	--without-libtiff \
	--without-libjasper \
	--without-gdiplus

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdk-pixbuf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gdk-pixbuf)
	@$(call install_fixup, gdk-pixbuf,PRIORITY,optional)
	@$(call install_fixup, gdk-pixbuf,SECTION,base)
	@$(call install_fixup, gdk-pixbuf,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gdk-pixbuf,DESCRIPTION,missing)

# currently no module loading enable
#	@$(call install_copy, gdk-pixbuf, 0, 0, 0755, -, /usr/bin/gdk-pixbuf-query-loaders)

ifdef PTXCONF_GDK_PIXBUF_X11
	@$(call install_lib, gdk-pixbuf, 0, 0, 0644, libgdk_pixbuf_xlib-2.0)
endif
	@$(call install_lib, gdk-pixbuf, 0, 0, 0644, libgdk_pixbuf-2.0)

	@$(call install_finish, gdk-pixbuf)

	@$(call touch)

# vim: syntax=make

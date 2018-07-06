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
GTK_VERSION	:= 3.22.30
GTK_MD5		:= 61e60dc073e0a6893c72043d20579dc0
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.xz
GTK_URL		:= https://download.gnome.org/sources/gtk+/$(basename $(GTK_VERSION))/$(GTK).$(GTK_SUFFIX)
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)
GTK_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GTK_CONF_TOOL	:= autoconf
GTK_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--x-includes=$(XORG_PREFIX)/include \
	--x-libraries=$(XORG_LIBDIR) \
	--disable-nls \
	--disable-rpath \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debug \
	--disable-installed-tests \
	--$(call ptx/endis, PTXCONF_GTK_XKB)-xkb \
	--$(call ptx/endis, PTXCONF_GTK_XINERAMA)-xinerama \
	--$(call ptx/endis, PTXCONF_GTK_XRANDR)-xrandr \
	--$(call ptx/endis, PTXCONF_GTK_XFIXES)-xfixes \
	--$(call ptx/endis, PTXCONF_GTK_XCOMPOSITE)-xcomposite \
	--$(call ptx/endis, PTXCONF_GTK_XDAMAGE)-xdamage \
	--$(call ptx/endis, PTXCONF_GTK_X11)-x11-backend \
	--disable-broadway-backend \
	--$(call ptx/endis, PTXCONF_GTK_WAYLAND)-wayland-backend \
	--disable-mir-backend \
	--enable-explicit-deps=no \
	--disable-glibtest \
	--enable-modules \
	--disable-cups \
	--disable-papi \
	--disable-cloudprint \
	--disable-test-print-backend \
	--disable-schemas-compile \
	--disable-introspection \
	--disable-colord \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--disable-doc-cross-references \
	--enable-Bsymbolic \
	--$(call ptx/wwo, PTXCONF_GTK_X11)-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk)
	@$(call install_fixup, gtk,PRIORITY,optional)
	@$(call install_fixup, gtk,SECTION,base)
	@$(call install_fixup, gtk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk,DESCRIPTION,missing)

	@$(call install_lib, gtk, 0, 0, 0644, libgdk-3)
	@$(call install_lib, gtk, 0, 0, 0644, libgtk-3)
	@$(call install_lib, gtk, 0, 0, 0644, libgailutil-3)

	@$(call install_finish, gtk)

	@$(call touch)

# vim: syntax=make

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
GTK_VERSION	:= 3.2.2
GTK_MD5		:= afc3a739d6ff39d3b81cf69119833c46
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.bz2
GTK_URL		:= http://ftp.gtk.org/pub/gtk/3.2/$(GTK).$(GTK_SUFFIX)
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)
GTK_LICENSE	:= LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GTK_PATH	:= PATH=$(CROSS_PATH)

# cups-config otherwhise picks up the host version
GTK_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_CUPS_CONFIG=no

#
# autoconf
#
GTK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--x-includes=$(XORG_PREFIX)/include \
	--x-libraries=$(XORG_LIBDIR) \
	--enable-gtk2-dependency \
	--$(call ptx/endis, PTXCONF_GTK_XKB)-xkb \
	--$(call ptx/endis, PTXCONF_GTK_XINERAMA)-xinerama \
	--$(call ptx/endis, PTXCONF_GTK_XINPUT)-xinput \
	--$(call ptx/endis, PTXCONF_GTK_XRANDR)-xrandr \
	--$(call ptx/endis, PTXCONF_GTK_XFIXES)-xfixes \
	--$(call ptx/endis, PTXCONF_GTK_XCOMPOSITE)-xcomposite \
	--$(call ptx/endis, PTXCONF_GTK_XDAMAGE)-xdamage \
	--enable-x11-backend \
	--disable-broadway-backend \
	--disable-wayland-backend \
	--enable-explicit-deps=no \
	--disable-glibtest \
	--enable-modules \
	--disable-cups \
	--disable-papi \
	--disable-test-print-backend \
	--disable-schemas-compile \
	--disable-introspection \
	--disable-packagekit \
	--disable-colord \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--enable-Bsymbolic \
	--with-x

# FIXME:
# - we want to add wayland at some point

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

	@$(call install_copy, gtk, 0, 0, 0644, -, \
		/usr/lib/gtk-3.0/3.0.0/printbackends/libprintbackend-lpr.so)
	@$(call install_copy, gtk, 0, 0, 0644, -, \
		/usr/lib/gtk-3.0/3.0.0/printbackends/libprintbackend-file.so)

	@$(call install_copy, gtk, 0, 0, 0755, -, /usr/bin/gtk-query-immodules-3.0)
	@$(call install_copy, gtk, 0, 0, 0755, -, /usr/share/glib-2.0/schemas/org.gtk.Settings.FileChooser.gschema.xml)

	#/usr/lib/gtk-3.0/3.0.0/immodules/im-ti-er.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-inuktitut.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-thai.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-multipress.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-viqr.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-cyrillic-translit.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-cedilla.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-am-et.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-ti-et.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-xim.so
	#/usr/lib/gtk-3.0/3.0.0/immodules/im-ipa.so

	#/usr/share/themes/Emacs/gtk-3.0
	#/usr/share/themes/Emacs/gtk-3.0/gtk-keys.css
	#/usr/share/themes/Raleigh/gtk-3.0
	#/usr/share/themes/Raleigh/gtk-3.0/gtk.css
	#/usr/share/themes/Default/gtk-3.0
	#/usr/share/themes/Default/gtk-3.0/gtk-keys.css
	#/etc/gtk-3.0/im-multipress.conf

ifdef PTXCONF_GTK_DEMO
	@$(call install_copy, gtk, 0, 0, 0755, -,/usr/bin/gtk3-demo)
endif
	@$(call install_finish, gtk)

	@$(call touch)

# vim: syntax=make

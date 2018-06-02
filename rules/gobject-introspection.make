# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GOBJECT_INTROSPECTION) += gobject-introspection

#
# Paths and names
#
GOBJECT_INTROSPECTION_VERSION	:= 1.56.1
GOBJECT_INTROSPECTION_MD5	:= 62e5f5685b8d9752fdeaf17c057d53d1
GOBJECT_INTROSPECTION		:= gobject-introspection-$(GOBJECT_INTROSPECTION_VERSION)
GOBJECT_INTROSPECTION_SUFFIX	:= tar.xz
GOBJECT_INTROSPECTION_URL	:= http://ftp.gnome.org/pub/GNOME/sources/gobject-introspection/$(basename $(GOBJECT_INTROSPECTION_VERSION))/$(GOBJECT_INTROSPECTION).$(GOBJECT_INTROSPECTION_SUFFIX)
GOBJECT_INTROSPECTION_SOURCE	:= $(SRCDIR)/$(GOBJECT_INTROSPECTION).$(GOBJECT_INTROSPECTION_SUFFIX)
GOBJECT_INTROSPECTION_DIR	:= $(BUILDDIR)/$(GOBJECT_INTROSPECTION)
GOBJECT_INTROSPECTION_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GOBJECT_INTROSPECTION_CONF_TOOL	:= autoconf
GOBJECT_INTROSPECTION_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-doctool \
	--without-cairo \
	--with-python=$(SYSTEMPYTHON3)

# needed so g-ir-compiler runs in qemu
GOBJECT_INTROSPECTION_MAKE_ENV	= \
	GI_CROSS_LAUNCHER="$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross -E LD_LIBRARY_PATH='$(GOBJECT_INTROSPECTION_DIR)/.libs:$(QEMU_CROSS_LD_LIBRARY_PATH)'"

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gobject-introspection.install.post:
	@$(call targetinfo)
	@$(call world/install.post, GOBJECT_INTROSPECTION)
	@sed -i 's;bindir=.*;bindir=$(PTXDIST_SYSROOT_CROSS)/bin;' \
		$(SYSROOT)/usr/lib/pkgconfig/gobject-introspection-1.0.pc
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gobject-introspection.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gobject-introspection)
	@$(call install_fixup, gobject-introspection,PRIORITY,optional)
	@$(call install_fixup, gobject-introspection,SECTION,base)
	@$(call install_fixup, gobject-introspection,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gobject-introspection,DESCRIPTION,missing)

	@$(call install_lib, gobject-introspection, 0, 0, 0644, \
		libgirepository-1.0)
	@$(call install_tree, gobject-introspection, 0, 0, -, \
		/usr/lib/girepository-1.0)

	@$(call install_finish, gobject-introspection)

	@$(call touch)

# vim: syntax=make

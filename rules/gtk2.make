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
PACKAGES-$(PTXCONF_GTK2) += gtk2

#
# Paths and names
#
GTK2_VERSION	:= 2.24.32
GTK2_MD5	:= d5742aa42275203a499b59b4c382a784
GTK2		:= gtk+-$(GTK2_VERSION)
GTK2_SUFFIX	:= tar.xz
GTK2_URL	:= ftp://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/$(GTK2).$(GTK2_SUFFIX)
GTK2_SOURCE	:= $(SRCDIR)/$(GTK2).$(GTK2_SUFFIX)
GTK2_DIR	:= $(BUILDDIR)/$(GTK2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# cups-config otherwhise picks up the host version
GTK2_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_CUPS_CONFIG=no

#
# autoconf
#
GTK2_CONF_TOOL	:= autoconf
GTK2_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debug \
	--disable-shm \
	--enable-xkb \
	--disable-xinerama \
	--disable-rebuilds \
	--enable-explicit-deps \
	--disable-glibtest \
	--disable-modules \
	--disable-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--without-xinput \
	--with-gdktarget=$(PTXCONF_GTK2_TARGET)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk2.install:
	@$(call targetinfo)
	@$(call install, GTK2)
	@install  -m 755 -D $(GTK2_DIR)/tests/testgtk $(GTK2_PKGDIR)/usr/bin/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk2)
	@$(call install_fixup, gtk2,PRIORITY,optional)
	@$(call install_fixup, gtk2,SECTION,base)
	@$(call install_fixup, gtk2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk2,DESCRIPTION,missing)

	@$(call install_lib, gtk2, 0, 0, 0644, libgdk-$(PTXCONF_GTK2_TARGET)-2.0)
	@$(call install_lib, gtk2, 0, 0, 0644, libgtk-$(PTXCONF_GTK2_TARGET)-2.0)

	@$(call install_finish, gtk2)

	@$(call touch)

# vim: syntax=make

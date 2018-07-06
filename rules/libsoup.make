# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSOUP) += libsoup

#
# Paths and names
#
LIBSOUP_VERSION	:= 2.62.2
LIBSOUP_MD5	:= eaf99b04ac8968ed2b26f2509ba75584
LIBSOUP		:= libsoup-$(LIBSOUP_VERSION)
LIBSOUP_SUFFIX	:= tar.xz
LIBSOUP_URL	:= http://ftp.gnome.org/pub/GNOME/sources/libsoup/$(basename $(LIBSOUP_VERSION))/$(LIBSOUP).$(LIBSOUP_SUFFIX)
LIBSOUP_SOURCE	:= $(SRCDIR)/$(LIBSOUP).$(LIBSOUP_SUFFIX)
LIBSOUP_DIR	:= $(BUILDDIR)/$(LIBSOUP)
LIBSOUP_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSOUP_CONF_TOOL := autoconf
LIBSOUP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-debug=minimum \
	--disable-glibtest \
	--disable-installed-tests \
	--disable-always-build-tests \
	--disable-nls \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/endis, PTXCONF_LIBSOUP_INTROSPECTION)-introspection \
	--disable-vala \
	--disable-tls-check \
	--disable-code-coverage \
	--enable-more-warnings \
	--without-gnome \
	--without-apache-httpd \
	--without-gssapi

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsoup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsoup)
	@$(call install_fixup, libsoup,PRIORITY,optional)
	@$(call install_fixup, libsoup,SECTION,base)
	@$(call install_fixup, libsoup,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsoup,DESCRIPTION,missing)

	@$(call install_lib, libsoup, 0, 0, 0644, libsoup-2.4)
ifdef PTXCONF_LIBSOUP_INTROSPECTION
	@$(call install_copy, libsoup, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Soup-2.4.typelib)
endif

	@$(call install_finish, libsoup)

	@$(call touch)

# vim: syntax=make

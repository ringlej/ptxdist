# -*-makefile-*-
#
# Copyright (C) 2003-2009 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.42.1
PANGO_MD5	:= d66d2f29e92d33b6da5e19c563520f7c
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.xz
PANGO_URL	:= http://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(PANGO_VERSION))/$(PANGO).$(PANGO_SUFFIX)
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)
PANGO_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PANGO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-rebuilds \
	--$(call ptx/endis, PTXCONF_PANGO_INTROSPECTION)-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-doc-cross-references \
	--disable-installed-tests \
	--without-xft \
	--with-cairo

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pango.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pango)
	@$(call install_fixup, pango,PRIORITY,optional)
	@$(call install_fixup, pango,SECTION,base)
	@$(call install_fixup, pango,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pango,DESCRIPTION,missing)

	@$(call install_lib, pango, 0, 0, 0644, libpango-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangoft2-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangocairo-1.0)
ifdef PTXCONF_PANGO_INTROSPECTION
	@$(call install_copy, pango, 0, 0, 644, -, \
		/usr/lib/girepository-1.0/Pango-1.0.typelib)
endif

	@$(call install_finish, pango)

	@$(call touch)

# vim: syntax=make

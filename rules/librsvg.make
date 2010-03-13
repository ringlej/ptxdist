# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRSVG) += librsvg

#
# Paths and names
#
LIBRSVG_VERSION	:= 2.26.0
LIBRSVG		:= librsvg-$(LIBRSVG_VERSION)
LIBRSVG_SUFFIX	:= tar.bz2
LIBRSVG_URL	:= http://ftp.gnome.org/pub/GNOME/sources/librsvg/2.26/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_SOURCE	:= $(SRCDIR)/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_DIR	:= $(BUILDDIR)/$(LIBRSVG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBRSVG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBRSVG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRSVG_PATH	:= PATH=$(CROSS_PATH)
LIBRSVG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBRSVG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-theme  \
	--disable-mozilla-plugin \
	--disable-gtk-doc \
	--without-x

ifdef PTXCONF_LIBRSVG_PIXBUF_LOADER
LIBRSVG_AUTOCONF += --enable-pixbuf-loader
else
LIBRSVG_AUTOCONF += --disable-pixbuf-loader
endif

ifdef PTXCONF_LIBRSVG_SVGZ
LIBRSVG_AUTOCONF += --with-svgz
else
LIBRSVG_AUTOCONF += --without-svgz
endif

ifdef PTXCONF_LIBRSVG_CROCO
LIBRSVG_AUTOCONF += --with-croco
else
LIBRSVG_AUTOCONF += --without-croco
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librsvg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, librsvg)
	@$(call install_fixup, librsvg,PACKAGE,librsvg)
	@$(call install_fixup, librsvg,PRIORITY,optional)
	@$(call install_fixup, librsvg,VERSION,$(LIBRSVG_VERSION))
	@$(call install_fixup, librsvg,SECTION,base)
	@$(call install_fixup, librsvg,AUTHOR,"Erwin Rol")
	@$(call install_fixup, librsvg,DEPENDS,)
	@$(call install_fixup, librsvg,DESCRIPTION,missing)

	@$(call install_copy, librsvg, 0, 0, 0644, -, \
		/usr/lib/librsvg-2.so.2.26.0)
	@$(call install_link, librsvg, librsvg-2.so.2.26.0, \
		/usr/lib/librsvg-2.so.2)
	@$(call install_link, librsvg, librsvg-2.so.2.26.0, \
		/usr/lib/librsvg-2.so)

	@$(call install_finish, librsvg)

	@$(call touch)

# vim: syntax=make

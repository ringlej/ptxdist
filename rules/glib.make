# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006-2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB) += glib

#
# Paths and names
#
GLIB_VERSION	:= 2.14.5
GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.bz2
GLIB_URL	:= http://ftp.gtk.org/pub/glib/2.14/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GLIB_SOURCE):
	@$(call targetinfo)
	@$(call get, GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_PATH	:= PATH=$(CROSS_PATH)
GLIB_ENV 	:= \
	$(CROSS_ENV) \
	glib_cv_uscore=no \
	glib_cv_stack_grows=no

#
# autoconf
#
GLIB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

ifdef PTXCONF_GLIB__LIBICONV_GNU
GLIB_AUTOCONF += --with-libiconv=gnu
endif
ifdef PTXCONF_GLIB__LIBICONV_NATIVE
GLIB_AUTOCONF += --with-libiconv=native
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, glib)
	@$(call install_fixup,glib,PACKAGE,glib)
	@$(call install_fixup,glib,PRIORITY,optional)
	@$(call install_fixup,glib,VERSION,$(GLIB_VERSION))
	@$(call install_fixup,glib,SECTION,base)
	@$(call install_fixup,glib,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,glib,DEPENDS,)
	@$(call install_fixup,glib,DESCRIPTION,missing)

	@$(call install_copy, glib, 0, 0, 0644, \
		$(GLIB_DIR)/glib/.libs/libglib-2.0.so.0.1400.5, \
		/usr/lib/libglib-2.0.so.0.1400.5)
	@$(call install_link, glib, libglib-2.0.so.0.1400.5, /usr/lib/libglib-2.0.so.0)
	@$(call install_link, glib, libglib-2.0.so.0.1400.5, /usr/lib/libglib-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, \
		$(GLIB_DIR)/gobject/.libs/libgobject-2.0.so.0.1400.5, \
		/usr/lib/libgobject-2.0.so.0.1400.5)
	@$(call install_link, glib, libgobject-2.0.so.0.1400.5, /usr/lib/libgobject-2.0.so.0)
	@$(call install_link, glib, libgobject-2.0.so.0.1400.5, /usr/lib/libgobject-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, \
		$(GLIB_DIR)/gmodule/.libs/libgmodule-2.0.so.0.1400.5, \
		/usr/lib/libgmodule-2.0.so.0.1400.5)
	@$(call install_link, glib, libgmodule-2.0.so.0.1400.5, /usr/lib/libgmodule-2.0.so.0)
	@$(call install_link, glib, libgmodule-2.0.so.0.1400.5, /usr/lib/libgmodule-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, \
		$(GLIB_DIR)/gthread/.libs/libgthread-2.0.so.0.1400.5, \
		/usr/lib/libgthread-2.0.so.0.1400.5)
	@$(call install_link, glib, libgthread-2.0.so.0.1400.5, /usr/lib/libgthread-2.0.so.0)
	@$(call install_link, glib, libgthread-2.0.so.0.1400.5, /usr/lib/libgthread-2.0.so)

	@$(call install_finish,glib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib_clean:
	rm -rf $(STATEDIR)/glib.*
	rm -rf $(PKGDIR)/glib_*
	rm -rf $(GLIB_DIR)

# vim: syntax=make

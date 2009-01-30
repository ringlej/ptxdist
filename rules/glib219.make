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
PACKAGES-$(PTXCONF_GLIB219) += glib219

#
# Paths and names
#
GLIB219_VERSION	:= 2.19.5
GLIB219		:= glib-$(GLIB219_VERSION)
GLIB219_SUFFIX	:= tar.bz2
GLIB219_URL	:= http://ftp.gtk.org/pub/glib/2.19/$(GLIB219).$(GLIB219_SUFFIX)
GLIB219_SOURCE	:= $(SRCDIR)/$(GLIB219).$(GLIB219_SUFFIX)
GLIB219_DIR	:= $(BUILDDIR)/$(GLIB219)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GLIB219_SOURCE):
	@$(call targetinfo)
	@$(call get, GLIB219)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB219_PATH	:= PATH=$(CROSS_PATH)
GLIB219_ENV 	:= \
	$(CROSS_ENV) \
	glib_cv_uscore=no \
	glib_cv_stack_grows=no \
	ac_cv_func_posix_getpwuid_r=yes \
	ac_cv_func_nonposix_getpwuid_r=no \
	ac_cv_func_posix_getgrgid_r=yes \
	ac_cv_func_nonposix_getgrgid_r=no

#
# autoconf
#
GLIB219_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

ifdef PTXCONF_GLIB219__LIBICONV_GNU
GLIB219_AUTOCONF += --with-libiconv=gnu
endif
ifdef PTXCONF_GLIB219__LIBICONV_NATIVE
GLIB219_AUTOCONF += --with-libiconv=native
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib219.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib219)
	@$(call install_fixup,glib219,PACKAGE,glib)
	@$(call install_fixup,glib219,PRIORITY,optional)
	@$(call install_fixup,glib219,VERSION,$(GLIB219_VERSION))
	@$(call install_fixup,glib219,SECTION,base)
	@$(call install_fixup,glib219,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,glib219,DEPENDS,)
	@$(call install_fixup,glib219,DESCRIPTION,missing)

	# FIXME: lib links are identical between 2.19 and 2.14 ...

	@$(call install_copy, glib219, 0, 0, 0644, \
		$(GLIB219_DIR)/glib/.libs/libglib-2.0.so.0.1905.0, \
		/usr/lib/libglib-2.0.so.0.1905.0)
	@$(call install_link, glib219, libglib-2.0.so.0.1905.0, /usr/lib/libglib-2.0.so.0)
	@$(call install_link, glib219, libglib-2.0.so.0.1905.0, /usr/lib/libglib-2.0.so)

	@$(call install_copy, glib219, 0, 0, 0644, \
		$(GLIB219_DIR)/gobject/.libs/libgobject-2.0.so.0.1905.0, \
		/usr/lib/libgobject-2.0.so.0.1905.0)
	@$(call install_link, glib219, libgobject-2.0.so.0.1905.0, /usr/lib/libgobject-2.0.so.0)
	@$(call install_link, glib219, libgobject-2.0.so.0.1905.0, /usr/lib/libgobject-2.0.so)

	@$(call install_copy, glib219, 0, 0, 0644, \
		$(GLIB219_DIR)/gmodule/.libs/libgmodule-2.0.so.0.1905.0, \
		/usr/lib/libgmodule-2.0.so.0.1905.0)
	@$(call install_link, glib219, libgmodule-2.0.so.0.1905.0, /usr/lib/libgmodule-2.0.so.0)
	@$(call install_link, glib219, libgmodule-2.0.so.0.1905.0, /usr/lib/libgmodule-2.0.so)

	@$(call install_copy, glib219, 0, 0, 0644, \
		$(GLIB219_DIR)/gthread/.libs/libgthread-2.0.so.0.1905.0, \
		/usr/lib/libgthread-2.0.so.0.1905.0)
	@$(call install_link, glib219, libgthread-2.0.so.0.1905.0, /usr/lib/libgthread-2.0.so.0)
	@$(call install_link, glib219, libgthread-2.0.so.0.1905.0, /usr/lib/libgthread-2.0.so)

	@$(call install_finish,glib219)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib219_clean:
	rm -rf $(STATEDIR)/glib219.*
	rm -rf $(PKGDIR)/glib219_*
	rm -rf $(GLIB219_DIR)

# vim: syntax=make

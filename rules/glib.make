# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
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
GLIB_VERSION := 2.8.6
GLIB         := glib-$(GLIB_VERSION)
GLIB_SUFFIX  := tar.bz2
GLIB_URL     := ftp://ftp.gtk.org/pub/gtk/v2.8/$(GLIB).$(GLIB_SUFFIX)
GLIB_SOURCE  := $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR     := $(BUILDDIR)/$(GLIB)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib_get: $(STATEDIR)/glib.get

$(STATEDIR)/glib.get: $(glib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib_extract: $(STATEDIR)/glib.extract

$(STATEDIR)/glib.extract: $(glib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB_DIR))
	@$(call extract, $(GLIB_SOURCE))
	@$(call patchin, $(GLIB))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib_prepare: $(STATEDIR)/glib.prepare

GLIB_PATH	:= PATH=$(CROSS_PATH)
GLIB_ENV 	:= \
	$(CROSS_ENV) \
	glib_cv_stack_grows=no

#FIXME
#ifdef $(PTXCONF_GLIBC_DL)
#GLIB_ENV	+= glib_cv_uscore=yes
#else
GLIB_ENV	+= glib_cv_uscore=no
#endif

#
# autoconf
#
GLIB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/glib.prepare: $(glib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB_DIR)/config.cache)
	cd $(GLIB_DIR) && \
		$(GLIB_PATH) $(GLIB_ENV) \
		./configure $(GLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib_compile: $(STATEDIR)/glib.compile

$(STATEDIR)/glib.compile: $(glib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GLIB_DIR) && $(GLIB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib_install: $(STATEDIR)/glib.install

$(STATEDIR)/glib.install: $(glib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib_targetinstall: $(STATEDIR)/glib.targetinstall

$(STATEDIR)/glib.targetinstall: $(glib_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glib)
	@$(call install_fixup,glib,PACKAGE,glib)
	@$(call install_fixup,glib,PRIORITY,optional)
	@$(call install_fixup,glib,VERSION,$(GLIB_VERSION))
	@$(call install_fixup,glib,SECTION,base)
	@$(call install_fixup,glib,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,glib,DEPENDS,)
	@$(call install_fixup,glib,DESCRIPTION,missing)

ifdef PTXCONF_GTK_28
	@$(call install_copy, glib, 0, 0, 0644, $(GLIB_DIR)/glib/.libs/libglib-2.0.so.0.800.6, /usr/lib/libglib-2.0.so.0.800.6)
	@$(call install_link, glib, libglib-2.0.so.0.800.6, /usr/lib/libglib-2.0.so.0)
	@$(call install_link, glib, libglib-2.0.so.0.800.6, /usr/lib/libglib-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, $(GLIB_DIR)/gobject/.libs/libgobject-2.0.so.0.800.6, /usr/lib/libgobject-2.0.so.0.800.6)
	@$(call install_link, glib, libgobject-2.0.so.0.800.6, /usr/lib/libgobject-2.0.so.0)
	@$(call install_link, glib, libgobject-2.0.so.0.800.6, /usr/lib/libgobject-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, $(GLIB_DIR)/gmodule/.libs/libgmodule-2.0.so.0.800.6, /usr/lib/libgmodule-2.0.so.0.800.6)
	@$(call install_link, glib, libgmodule-2.0.so.0.800.6, /usr/lib/libgmodule-2.0.so.0)
	@$(call install_link, glib, libgmodule-2.0.so.0.800.6, /usr/lib/libgmodule-2.0.so)

	@$(call install_copy, glib, 0, 0, 0644, $(GLIB_DIR)/gthread/.libs/libgthread-2.0.so.0.800.6, /usr/lib/libgthread-2.0.so.0.800.6)
	@$(call install_link, glib, libgthread-2.0.so.0.800.6, /usr/lib/libgthread-2.0.so.0)
	@$(call install_link, glib, libgthread-2.0.so.0.800.6, /usr/lib/libgthread-2.0.so)
endif

	@$(call install_finish,glib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib_clean:
	rm -rf $(STATEDIR)/glib.*
	rm -rf $(IMAGEDIR)/glib_*
	rm -rf $(GLIB_DIR)

# vim: syntax=make

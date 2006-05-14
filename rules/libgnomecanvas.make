# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGNOMECANVAS) += libgnomecanvas

#
# Paths and names
#
LIBGNOMECANVAS_VERSION	= 2.5.90
LIBGNOMECANVAS		= libgnomecanvas-$(LIBGNOMECANVAS_VERSION)
LIBGNOMECANVAS_SUFFIX	= tar.bz2
LIBGNOMECANVAS_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/libgnomecanvas/2.5/$(LIBGNOMECANVAS).$(LIBGNOMECANVAS_SUFFIX)
LIBGNOMECANVAS_SOURCE	= $(SRCDIR)/$(LIBGNOMECANVAS).$(LIBGNOMECANVAS_SUFFIX)
LIBGNOMECANVAS_DIR	= $(BUILDDIR)/$(LIBGNOMECANVAS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgnomecanvas_get: $(STATEDIR)/libgnomecanvas.get

$(STATEDIR)/libgnomecanvas.get: $(libgnomecanvas_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGNOMECANVAS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBGNOMECANVAS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgnomecanvas_extract: $(STATEDIR)/libgnomecanvas.extract

$(STATEDIR)/libgnomecanvas.extract: $(libgnomecanvas_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGNOMECANVAS_DIR))
	@$(call extract, LIBGNOMECANVAS)
	@$(call patchin, $(LIBGNOMECANVAS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgnomecanvas_prepare: $(STATEDIR)/libgnomecanvas.prepare

LIBGNOMECANVAS_PATH	=  PATH=$(CROSS_PATH)
LIBGNOMECANVAS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBGNOMECANVAS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libgnomecanvas.prepare: $(libgnomecanvas_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGNOMECANVAS_DIR)/config.cache)
	cd $(LIBGNOMECANVAS_DIR) && \
		$(LIBGNOMECANVAS_PATH) $(LIBGNOMECANVAS_ENV) \
		./configure $(LIBGNOMECANVAS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgnomecanvas_compile: $(STATEDIR)/libgnomecanvas.compile

$(STATEDIR)/libgnomecanvas.compile: $(libgnomecanvas_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBGNOMECANVAS_DIR) && \
	   $(LIBGNOMECANVAS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgnomecanvas_install: $(STATEDIR)/libgnomecanvas.install

$(STATEDIR)/libgnomecanvas.install: $(libgnomecanvas_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBGNOMECANVAS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgnomecanvas_targetinstall: $(STATEDIR)/libgnomecanvas.targetinstall

$(STATEDIR)/libgnomecanvas.targetinstall: $(libgnomecanvas_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libgnomecanvas)
	@$(call install_fixup, libgnomecanvas,PACKAGE,libgnomecanvas)
	@$(call install_fixup, libgnomecanvas,PRIORITY,optional)
	@$(call install_fixup, libgnomecanvas,VERSION,$(LIBGNOMECANVAS_VERSION))
	@$(call install_fixup, libgnomecanvas,SECTION,base)
	@$(call install_fixup, libgnomecanvas,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libgnomecanvas,DEPENDS,)
	@$(call install_fixup, libgnomecanvas,DESCRIPTION,missing)

	@$(call install_copy, libgnomecanvas, 0, 0, 0644, \
		$(LIBGNOMECANVAS_DIR)/libgnomecanvas/.libs/libgnomecanvas-2.so.0.590.0, \
		/usr/lib/libgnomecanvas-2.so.0.590.0)
	@$(call install_link, libgnomecanvas, libgnomecanvas-2.so.0.590.0, /usr/lib/libgnomecanvas-2.so.0)
	@$(call install_link, libgnomecanvas, libgnomecanvas-2.so.0.590.0, /usr/lib/libgnomecanvas-2.so)

	@$(call install_finish, libgnomecanvas)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgnomecanvas_clean:
	rm -rf $(STATEDIR)/libgnomecanvas.*
	rm -rf $(IMAGEDIR)/libgnomecanvas_*
	rm -rf $(LIBGNOMECANVAS_DIR)

# vim: syntax=make

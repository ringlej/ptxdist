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

libgnomecanvas_get_deps = $(LIBGNOMECANVAS_SOURCE)

$(STATEDIR)/libgnomecanvas.get: $(libgnomecanvas_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGNOMECANVAS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBGNOMECANVAS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgnomecanvas_extract: $(STATEDIR)/libgnomecanvas.extract

libgnomecanvas_extract_deps = $(STATEDIR)/libgnomecanvas.get

$(STATEDIR)/libgnomecanvas.extract: $(libgnomecanvas_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGNOMECANVAS_DIR))
	@$(call extract, $(LIBGNOMECANVAS_SOURCE))
	@$(call patchin, $(LIBGNOMECANVAS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgnomecanvas_prepare: $(STATEDIR)/libgnomecanvas.prepare

#
# dependencies
#
libgnomecanvas_prepare_deps = \
	$(STATEDIR)/libgnomecanvas.extract \
	$(STATEDIR)/libglade.install \
	$(STATEDIR)/libart.install \
	$(STATEDIR)/virtual-xchain.install

LIBGNOMECANVAS_PATH	=  PATH=$(CROSS_PATH)
LIBGNOMECANVAS_ENV 	=  $(CROSS_ENV)
LIBGNOMECANVAS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
LIBGNOMECANVAS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libgnomecanvas.prepare: $(libgnomecanvas_prepare_deps)
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

libgnomecanvas_compile_deps = $(STATEDIR)/libgnomecanvas.prepare

$(STATEDIR)/libgnomecanvas.compile: $(libgnomecanvas_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBGNOMECANVAS_DIR) && \
	   $(LIBGNOMECANVAS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgnomecanvas_install: $(STATEDIR)/libgnomecanvas.install

$(STATEDIR)/libgnomecanvas.install: $(STATEDIR)/libgnomecanvas.compile
	@$(call targetinfo, $@)
	@$(call install, LIBGNOMECANVAS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgnomecanvas_targetinstall: $(STATEDIR)/libgnomecanvas.targetinstall

libgnomecanvas_targetinstall_deps = $(STATEDIR)/libgnomecanvas.compile
libgnomecanvas_targetinstall_deps = $(STATEDIR)/libart.targetinstall

$(STATEDIR)/libgnomecanvas.targetinstall: $(libgnomecanvas_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libgnomecanvas)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBGNOMECANVAS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
       
	@$(call install_copy, 0, 0, 0644, \
		$(LIBGNOMECANVAS_DIR)/libgnomecanvas/.libs/libgnomecanvas-2.so.0.590.0, \
		/usr/lib/libgnomecanvas-2.so.0.590.0)
	@$(call install_link, libgnomecanvas-2.so.0.590.0, /usr/lib/libgnomecanvas-2.so.0)
	@$(call install_link, libgnomecanvas-2.so.0.590.0, /usr/lib/libgnomecanvas-2.so)
	
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgnomecanvas_clean:
	rm -rf $(STATEDIR)/libgnomecanvas.*
	rm -rf $(IMAGEDIR)/libgnomecanvas_*
	rm -rf $(LIBGNOMECANVAS_DIR)

# vim: syntax=make

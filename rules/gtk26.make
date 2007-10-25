# -*-makefile-*-
# $Id: gtk22.make 3511 2005-12-12 15:11:00Z rsc $
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
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
PACKAGES-$(PTXCONF_GTK26) += gtk26

#
# Paths and names
#
GTK26_VERSION	= 2.6.10
GTK26		= gtk+-$(GTK26_VERSION)
GTK26_SUFFIX	= tar.bz2
GTK26_URL	= http://ftp.gtk.org/pub/gtk/v2.6/$(GTK26).$(GTK26_SUFFIX)
GTK26_SOURCE	= $(SRCDIR)/$(GTK26).$(GTK26_SUFFIX)
GTK26_DIR	= $(BUILDDIR)/$(GTK26)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk26_get: $(STATEDIR)/gtk26.get

$(STATEDIR)/gtk26.get: $(gtk26_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK26_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GTK26)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk26_extract: $(STATEDIR)/gtk26.extract

$(STATEDIR)/gtk26.extract: $(gtk26_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK26_DIR))
	@$(call extract, GTK26)
	@$(call patchin, GTK26)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk26_prepare: $(STATEDIR)/gtk26.prepare

GTK26_PATH = PATH=$(CROSS_PATH)
GTK26_ENV = $(CROSS_ENV)

#
# autoconf
#
GTK26_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gtk26.prepare: $(gtk26_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK26_BUILDDIR))
	cd $(GTK26_DIR) && \
		$(GTK26_PATH) $(GTK26_ENV) \
		./configure $(GTK26_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk26_compile: $(STATEDIR)/gtk26.compile

$(STATEDIR)/gtk26.compile: $(gtk26_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GTK26_DIR) && $(GTK26_PATH) $(GTK26_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk26_install: $(STATEDIR)/gtk26.install

$(STATEDIR)/gtk26.install: $(gtk26_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GTK26)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk26_targetinstall: $(STATEDIR)/gtk26.targetinstall

$(STATEDIR)/gtk26.targetinstall: $(gtk26_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gtk26)
	@$(call install_fixup, gtk26,PACKAGE,gtk26)
	@$(call install_fixup, gtk26,PRIORITY,optional)
	@$(call install_fixup, gtk26,VERSION,$(GTK26_VERSION))
	@$(call install_fixup, gtk26,SECTION,base)
	@$(call install_fixup, gtk26,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gtk26,DEPENDS,)
	@$(call install_fixup, gtk26,DESCRIPTION,missing)

	@$(call install_copy, gtk26, 0, 0, 0644, \
		$(GTK26_DIR)/gtk/.libs/libgtk-x11-2.0.so.0.302.0, \
		/usr/lib/libgtk-x11-2.0.so.0.302.0)
	@$(call install_link, gtk26, libgtk-x11-2.0.so.0.302.0, /usr/lib/libgtk-x11-2.0.so.0)
	@$(call install_link, gtk26, libgtk-x11-2.0.so.0.302.0, /usr/lib/libgtk-x11-2.0.so)

	@$(call install_copy, gtk26, 0, 0, 0644, \
		$(GTK26_DIR)/gdk/.libs/libgdk-x11-2.0.so.0.302.0, \
		/usr/lib/libgdk-x11-2.0.so.0.302.0)
	@$(call install_link, gtk26, libgdk-x11-2.0.so.0.302.0, /usr/lib/libgdk-x11-2.0.so.0)
	@$(call install_link, gtk26, libgdk-x11-2.0.so.0.302.0, /usr/lib/libgdk-x11-2.0.so)

	@$(call install_copy, gtk26, 0, 0, 0644, \
		$(GTK26_DIR)/gdk-pixbuf/.libs/libgdk_pixbuf-2.0.so.0.302.0, \
		/usr/lib/libgdk_pixbuf-2.0.so.0.302.0)
	@$(call install_link, gtk26, libgdk_pixbuf-2.0.so.0.302.0, /usr/lib/libgdk_pixbuf-2.0.so.0)
	@$(call install_link, gtk26, libgdk_pixbuf-2.0.so.0.302.0, /usr/lib/libgdk_pixbuf-2.0.so)

	@$(call install_copy, gtk26, 0, 0, 0644, \
		$(GTK26_DIR)/gdk-pixbuf/.libs/gdk-pixbuf-query-loaders, \
		/usr/bin/gdk-pixbuf-query-loaders)
	@$(call install_copy, gtk26, 0, 0, 0644, \
		$(GTK26_DIR)/gdk-pixbuf/.libs/libpixbufloader*so, \
		/usr/lib/gdk-pixbuf-loaders/)

	@$(call install_finish, gtk26)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk26_clean:
	rm -rf $(STATEDIR)/gtk26.*
	rm -rf $(IMAGEDIR)/gtk26_*
	rm -rf $(GTK26_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_GTK1210) += gtk1210

#
# Paths and names
#
GTK1210_VERSION		= 1.2.10
GTK1210			= gtk+-$(GTK1210_VERSION)
GTK1210_SUFFIX		= tar.gz
GTK1210_URL		= http://ftp.gtk.org/pub/gtk/v1.2/$(GTK1210).$(GTK1210_SUFFIX)
GTK1210_SOURCE		= $(SRCDIR)/$(GTK1210).$(GTK1210_SUFFIX)
GTK1210_DIR		= $(BUILDDIR)/$(GTK1210)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk1210_get: $(STATEDIR)/gtk1210.get

$(STATEDIR)/gtk1210.get: $(gtk1210_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK1210_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GTK1210)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk1210_extract: $(STATEDIR)/gtk1210.extract

$(STATEDIR)/gtk1210.extract: $(gtk1210_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK1210_DIR))
	@$(call extract, GTK1210)
	@$(call patchin, GTK1210)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk1210_prepare: $(STATEDIR)/gtk1210.prepare

GTK1210_PATH	=  PATH=$(SYSROOT)/bin:$(CROSS_PATH)
GTK1210_ENV 	=  $(CROSS_ENV)
GTK1210_ENV	+= ac_cv_have_x='have_x=yes ac_x_includes=$(SYSROOT)/include ac_x_libraries=$(SYSROOT)/lib'

#
# autoconf
#
GTK1210_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
GTK1210_AUTOCONF	+= --with-threads=posix
GTK1210_AUTOCONF 	+= --with-glib-prefix=$(SYSROOT)
GTK1210_AUTOCONF	+= --with-x

$(STATEDIR)/gtk1210.prepare: $(gtk1210_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK1210_BUILDDIR))
	cd $(GTK1210_DIR) && \
		$(GTK1210_PATH) $(GTK1210_ENV) \
		./configure $(GTK1210_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk1210_compile: $(STATEDIR)/gtk1210.compile

$(STATEDIR)/gtk1210.compile: $(gtk1210_compile_deps_default)
	@$(call targetinfo, $@)
	$(GTK1210_PATH) $(GTK1210_ENV) make -C $(GTK1210_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk1210_install: $(STATEDIR)/gtk1210.install

$(STATEDIR)/gtk1210.install: $(gtk1210_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GTK1210)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk1210_targetinstall: $(STATEDIR)/gtk1210.targetinstall

$(STATEDIR)/gtk1210.targetinstall: $(gtk1210_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gtk1210)
	@$(call install_fixup, gtk1210,PACKAGE,gtk1210)
	@$(call install_fixup, gtk1210,PRIORITY,optional)
	@$(call install_fixup, gtk1210,VERSION,$(GTK1210_VERSION))
	@$(call install_fixup, gtk1210,SECTION,base)
	@$(call install_fixup, gtk1210,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gtk1210,DEPENDS,)
	@$(call install_fixup, gtk1210,DESCRIPTION,missing)

	# gdk
	@$(call install_copy, gtk1210, 0, 0, 0644, \
		$(GTK1210_DIR)/gdk/.libs/libgdk-1.2.so.0.9.1, \
		/usr/lib/libgdk-1.2.so.0.9.1)
	@$(call install_link, gtk1210, libgdk-1.2.so.0.9.1, /usr/lib/libgdk-1.2.so.0)
	@$(call install_link, gtk1210, libgdk-1.2.so.0.9.1, /usr/lib/libgdk-1.2.so)

	# gtk
	@$(call install_copy, gtk1210, 0, 0, 0644, \
		$(GTK1210_DIR)/gtk/.libs/libgtk-1.2.so.0.9.1, \
		/usr/lib/libgtk-1.2.so.0.9.1)
	@$(call install_link, gtk1210, libgtk-1.2.so.0.9.1, /usr/lib/libgtk-1.2.so.0)
	@$(call install_link, gtk1210, libgtk-1.2.so.0.9.1, /usr/lib/libgtk-1.2.so)

	@$(call install_finish, gtk1210)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk1210_clean:
	rm -rf $(STATEDIR)/gtk1210.*
	rm -rf $(IMAGEDIR)/gtk1210_*
	rm -rf $(GTK1210_DIR)

# vim: syntax=make

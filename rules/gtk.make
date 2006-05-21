# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK) += gtk

#
# Paths and names
#
GTK_VERSION	:= 2.8.16
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.bz2
GTK_URL		:= ftp://ftp.gtk.org/pub/gtk/v2.8/$(GTK).$(GTK_SUFFIX)
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk_get: $(STATEDIR)/gtk.get

$(STATEDIR)/gtk.get: $(gtk_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GTK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk_extract: $(STATEDIR)/gtk.extract

$(STATEDIR)/gtk.extract: $(gtk_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK_DIR))
	@$(call extract, GTK)
	@$(call patchin, GTK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk_prepare: $(STATEDIR)/gtk.prepare

GTK_PATH	:= PATH=$(CROSS_PATH)
GTK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GTK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-explicit-deps=yes

ifndef PTXCONF_GTK_LIBPNG
GTK_AUTOCONF += --without-libpng
endif

ifndef PTXCONF_GTK_LIBTIFF
GTK_AUTOCONF += --without-libtiff
endif

ifndef PTXCONF_GTK_LIBJPEG
GTK_AUTOCONF += --without-libjpeg
endif

ifdef PTXCONF_GTK_TARGET_X11
GTK_AUTOCONF += --with-gdktarget=x11
endif

$(STATEDIR)/gtk.prepare: $(gtk_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK_DIR)/config.cache)
	cd $(GTK_DIR) && \
		$(GTK_PATH) $(GTK_ENV) \
		./configure $(GTK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk_compile: $(STATEDIR)/gtk.compile

$(STATEDIR)/gtk.compile: $(gtk_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GTK_DIR) && $(GTK_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk_install: $(STATEDIR)/gtk.install

$(STATEDIR)/gtk.install: $(gtk_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GTK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk_targetinstall: $(STATEDIR)/gtk.targetinstall

$(STATEDIR)/gtk.targetinstall: $(gtk_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gtk)
	@$(call install_fixup,gtk,PACKAGE,gtk)
	@$(call install_fixup,gtk,PRIORITY,optional)
	@$(call install_fixup,gtk,VERSION,$(GTK_VERSION))
	@$(call install_fixup,gtk,SECTION,base)
	@$(call install_fixup,gtk,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,gtk,DEPENDS,)
	@$(call install_fixup,gtk,DESCRIPTION,missing)

	@$(call install_copy, gtk, 0, 0, 0755, $(GTK_DIR)/foobar, /dev/null)

	@$(call install_finish,gtk)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk_clean:
	rm -rf $(STATEDIR)/gtk.*
	rm -rf $(IMAGEDIR)/gtk_*
	rm -rf $(GTK_DIR)

# vim: syntax=make

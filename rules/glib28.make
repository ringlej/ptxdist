# -*-makefile-*-
# $Id: glib28.make 3574 2005-12-27 11:46:41Z rsc $
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
PACKAGES-$(PTXCONF_GLIB28) += glib28

#
# Paths and names
#
GLIB28_VERSION		= 2.8.4
GLIB28			= glib-$(GLIB28_VERSION)
GLIB28_SUFFIX		= tar.gz
GLIB28_URL		= ftp://ftp.gtk.org/pub/gtk/v2.8/$(GLIB28).$(GLIB28_SUFFIX)
GLIB28_SOURCE		= $(SRCDIR)/$(GLIB28).$(GLIB28_SUFFIX)
GLIB28_DIR		= $(BUILDDIR)/$(GLIB28)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib28_get: $(STATEDIR)/glib28.get

$(STATEDIR)/glib28.get: $(glib28_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLIB28_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIB28_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib28_extract: $(STATEDIR)/glib28.extract

$(STATEDIR)/glib28.extract: $(glib28_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB28_DIR))
	@$(call extract, $(GLIB28_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib28_prepare: $(STATEDIR)/glib28.prepare

GLIB28_PATH = PATH=$(CROSS_PATH)
GLIB28_ENV = \
	$(CROSS_ENV) \
	glib_cv_use_pid_surrogate=no \
	ac_cv_func_posix_getpwuid_r=yes \
	glib_cv_stack_grows=no

ifdef $(PTXCONF_GLIBC_DL)
GLIB28_ENV += glib_cv_uscore=yes
else
GLIB28_ENV += glib_cv_uscore=no
endif

#
# autoconf
#
GLIB28_AUTOCONF =  $(CROSS_AUTOCONF_USR)
GLIB28_AUTOCONF += --with-threads=posix

$(STATEDIR)/glib28.prepare: $(glib28_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB28_BUILDDIR))
	cd $(GLIB28_DIR) && \
		$(GLIB28_PATH) $(GLIB28_ENV) \
		./configure $(GLIB28_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib28_compile: $(STATEDIR)/glib28.compile

glib28_compile_deps =  $(STATEDIR)/glib28.prepare

$(STATEDIR)/glib28.compile: $(glib28_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GLIB28_DIR) && $(GLIB28_PATH) $(GLIB28_ENV) make $(GLIB28_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib28_install: $(STATEDIR)/glib28.install

$(STATEDIR)/glib28.install: $(glib28_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLIB28)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib28_targetinstall: $(STATEDIR)/glib28.targetinstall

$(STATEDIR)/glib28.targetinstall: $(glib28_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glib28)
	@$(call install_fixup, glib28,PACKAGE,glib28)
	@$(call install_fixup, glib28,PRIORITY,optional)
	@$(call install_fixup, glib28,VERSION,$(GLIB28_VERSION))
	@$(call install_fixup, glib28,SECTION,base)
	@$(call install_fixup, glib28,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, glib28,DEPENDS,)
	@$(call install_fixup, glib28,DESCRIPTION,missing)

	@$(call install_copy, glib28, 0, 0, 0644, $(GLIB28_DIR)/glib/.libs/libglib-2.0.so.0.800.4, /usr/lib/libglib-2.0.so.0.800.4)
	@$(call install_link, glib28, /usr/lib/libglib-2.0.so.0.800.4, /usr/lib/libglib-2.0.so.0)
	@$(call install_link, glib28, /usr/lib/libglib-2.0.so.0.800.4, /usr/lib/libglib-2.0.so)

	@$(call install_copy, glib28, 0, 0, 0644, $(GLIB28_DIR)/gobject/.libs/libgobject-2.0.so.0.800.4, /usr/lib/libgobject-2.0.so.0.800.4)
	@$(call install_link, glib28, /usr/lib/libgobject-2.0.so.0.800.4, /usr/lib/libgobject-2.0.so.0)
	@$(call install_link, glib28, /usr/lib/libgobject-2.0.so.0.800.4, /usr/lib/libgobject-2.0.so)

	@$(call install_copy, glib28, 0, 0, 0644, $(GLIB28_DIR)/gmodule/.libs/libgmodule-2.0.so.0.800.4, /usr/lib/libgmodule-2.0.so.0.800.4)
	@$(call install_link, glib28, /usr/lib/libgmodule-2.0.so.0.800.4, /usr/lib/libgmodule-2.0.so.0)
	@$(call install_link, glib28, /usr/lib/libgmodule-2.0.so.0.800.4, /usr/lib/libgmodule-2.0.so)

	@$(call install_copy, glib28, 0, 0, 0644, $(GLIB28_DIR)/gthread/.libs/libgthread-2.0.so.0.800.4, /usr/lib/libgthread-2.0.so.0.800.4)
	@$(call install_link, glib28, /usr/lib/libgthread-2.0.so.0.800.4, /usr/lib/libgthread-2.0.so.0)
	@$(call install_link, glib28, /usr/lib/libgthread-2.0.so.0.800.4, /usr/lib/libgthread-2.0.so)

	@$(call install_finish, glib28)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib28_clean:
	rm -rf $(STATEDIR)/glib28.*
	rm -rf $(IMAGEDIR)/glib28_*
	rm -rf $(GLIB28_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/glib-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gmodule-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gobject-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gthread-2.0*.pc

# vim: syntax=make

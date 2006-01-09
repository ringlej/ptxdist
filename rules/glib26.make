# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Robert Schwebel <r.schwebel@pengutronix.de>
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
PACKAGES-$(PTXCONF_GLIB26) += glib26

#
# Paths and names
#
GLIB26_VERSION		= 2.6.6
GLIB26			= glib-$(GLIB26_VERSION)
GLIB26_SUFFIX		= tar.gz
GLIB26_URL		= ftp://ftp.gtk.org/pub/gtk/v2.6/$(GLIB26).$(GLIB26_SUFFIX)
GLIB26_SOURCE		= $(SRCDIR)/$(GLIB26).$(GLIB26_SUFFIX)
GLIB26_DIR		= $(BUILDDIR)/$(GLIB26)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib26_get: $(STATEDIR)/glib26.get

glib26_get_deps	=  $(GLIB26_SOURCE)

$(STATEDIR)/glib26.get: $(glib26_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLIB26_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIB26_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib26_extract: $(STATEDIR)/glib26.extract

glib26_extract_deps	=  $(STATEDIR)/glib26.get

$(STATEDIR)/glib26.extract: $(glib26_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB26_DIR))
	@$(call extract, $(GLIB26_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib26_prepare: $(STATEDIR)/glib26.prepare

#
# dependencies
#
glib26_prepare_deps = \
	$(STATEDIR)/glib26.extract \
	$(STATEDIR)/virtual-xchain.install

GLIB26_PATH = PATH=$(CROSS_PATH)
GLIB26_ENV = \
	$(CROSS_ENV) \
	glib_cv_use_pid_surrogate=no \
	ac_cv_func_posix_getpwuid_r=yes \
	glib_cv_stack_grows=no

ifdef $(PTXCONF_GLIBC_DL)
GLIB26_ENV += glib_cv_uscore=yes
else
GLIB26_ENV += glib_cv_uscore=no
endif

#
# autoconf
#
GLIB26_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-threads=posix

$(STATEDIR)/glib26.prepare: $(glib26_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB26_BUILDDIR))
	cd $(GLIB26_DIR) && \
		$(GLIB26_PATH) $(GLIB26_ENV) \
		./configure $(GLIB26_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib26_compile: $(STATEDIR)/glib26.compile

glib26_compile_deps =  $(STATEDIR)/glib26.prepare

$(STATEDIR)/glib26.compile: $(glib26_compile_deps)
	@$(call targetinfo, $@)
	$(GLIB26_PATH) $(GLIB26_ENV) make -C $(GLIB26_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib26_install: $(STATEDIR)/glib26.install

$(STATEDIR)/glib26.install: $(STATEDIR)/glib26.compile
	@$(call targetinfo, $@)
	@$(call install, GLIB26)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib26_targetinstall: $(STATEDIR)/glib26.targetinstall

glib26_targetinstall_deps	=  $(STATEDIR)/glib26.compile

$(STATEDIR)/glib26.targetinstall: $(glib26_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,glib26)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GLIB26_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(GLIB26_DIR)/glib/.libs/libglib-2.0.so.0.600.1, /usr/lib/libglib-2.0.so.0.600.1)
	@$(call install_link, /usr/lib/libglib-2.0.so.0.600.1, /usr/lib/libglib-2.0.so.0)
	@$(call install_link, /usr/lib/libglib-2.0.so.0.600.1, /usr/lib/libglib-2.0.so)

	@$(call install_copy, 0, 0, 0644, $(GLIB26_DIR)/gobject/.libs/libgobject-2.0.so.0.600.1, /usr/lib/libgobject-2.0.so.0.600.1)
	@$(call install_link, /usr/lib/libgobject-2.0.so.0.600.1, /usr/lib/libgobject-2.0.so.0)
	@$(call install_link, /usr/lib/libgobject-2.0.so.0.600.1, /usr/lib/libgobject-2.0.so)

	@$(call install_copy, 0, 0, 0644, $(GLIB26_DIR)/gmodule/.libs/libgmodule-2.0.so.0.600.1, /usr/lib/libgmodule-2.0.so.0.600.1)
	@$(call install_link, /usr/lib/libgmodule-2.0.so.0.600.1, /usr/lib/libgmodule-2.0.so.0)
	@$(call install_link, /usr/lib/libgmodule-2.0.so.0.600.1, /usr/lib/libgmodule-2.0.so)

	@$(call install_copy, 0, 0, 0644, $(GLIB26_DIR)/gthread/.libs/libgthread-2.0.so.0.600.1, /usr/lib/libgthread-2.0.so.0.600.1)
	@$(call install_link, /usr/lib/libgthread-2.0.so.0.600.1, /usr/lib/libgthread-2.0.so.0)
	@$(call install_link, /usr/lib/libgthread-2.0.so.0.600.1, /usr/lib/libgthread-2.0.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib26_clean:
	rm -rf $(STATEDIR)/glib26.*
	rm -rf $(IMAGEDIR)/glib26_*
	rm -rf $(GLIB26_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/glib-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gmodule-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gobject-2.0*.pc
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/gthread-2.0*.pc

# vim: syntax=make

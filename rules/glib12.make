# -*-makefile-*-
# $Id: glib12.make 3863 2006-01-12 17:12:09Z rsc $
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
PACKAGES-$(PTXCONF_GLIB12) += glib12

#
# Paths and names
#
GLIB12_VERSION	= 1.2.10
GLIB12		= glib-$(GLIB12_VERSION)
GLIB12_SUFFIX	= tar.gz
GLIB12_URL	= ftp://ftp.gtk.org/pub/gtk/v1.2/$(GLIB12).$(GLIB12_SUFFIX)
GLIB12_SOURCE	= $(SRCDIR)/$(GLIB12).$(GLIB12_SUFFIX)
GLIB12_DIR	= $(BUILDDIR)/$(GLIB12)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib12_get: $(STATEDIR)/glib12.get


$(STATEDIR)/glib12.get: $(glib12_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLIB12_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIB12_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib12_extract: $(STATEDIR)/glib12.extract

$(STATEDIR)/glib12.extract: $(glib12_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB12_DIR))
	@$(call extract, $(GLIB12_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib12_prepare: $(STATEDIR)/glib12.prepare

GLIB12_PATH	=  PATH=$(CROSS_PATH)
GLIB12_ENV 	=  $(CROSS_ENV)
#GLIB12_ENV	+= PKG_CONFIG_PATH=../$(GLIB12):../$(ATK124):../$(PANGO12):../$(GTK22)

#GLIB12_ENV	+= glib_cv_use_pid_surrogate=no
#GLIB12_ENV	+= ac_cv_func_posix_getpwuid_r=yes 
#ifeq (y, $G(PTXCONF_GLIBC_DL))
#GLIB12_ENV	+= glib_cv_uscore=yes
#else
#GLIB12_ENV	+= glib_cv_uscore=no
#endif
#GLIB12_ENV	+= glib_cv_stack_grows=no

#
# autoconf
#
GLIB12_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
GLIB12_AUTOCONF	+= --with-threads=posix

$(STATEDIR)/glib12.prepare: $(glib12_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB12_BUILDDIR))
	cd $(GLIB12_DIR) && \
		$(GLIB12_PATH) $(GLIB12_ENV) \
		./configure $(GLIB12_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib12_compile: $(STATEDIR)/glib12.compile

$(STATEDIR)/glib12.compile: $(glib12_compile_deps_default)
	@$(call targetinfo, $@)
	$(GLIB12_PATH) $(GLIB12_ENV) make -C $(GLIB12_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib12_install: $(STATEDIR)/glib12.install

$(STATEDIR)/glib12.install: $(glib12_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLIB12)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib12_targetinstall: $(STATEDIR)/glib12.targetinstall

$(STATEDIR)/glib12.targetinstall: $(glib12_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,glib12)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GLIB12_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# glib
	@$(call install_copy, 0, 0, 0644, $(GLIB12_DIR)/.libs/libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so.0.0.10)
	@$(call install_link, libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so.0)
	@$(call install_link, libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so)

	# gmodule
	@$(call install_copy, 0, 0, 0644, $(GLIB12_DIR)/gmodule/.libs/libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so.0.0.10)
	@$(call install_link, libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so.0)
	@$(call install_link, libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so)

	# gthread
	@$(call install_copy, 0, 0, 0644, $(GLIB12_DIR)/gthread/.libs/libgthread-1.2.so.0.0.10, /usr/lib/libgthread-1.2.so.0.0.10)
	@$(call install_link, libgthread-1.2.so.0.0.10 /usr/lib/libgthread-1.2.so.0)
	@$(call install_link, libgthread-1.2.so.0.0.10 /usr/lib/libgthread-1.2.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib12_clean:
	rm -rf $(STATEDIR)/glib12.*
	rm -rf $(IMAGEDIR)/glib12_*
	rm -rf $(GLIB12_DIR)

# vim: syntax=make

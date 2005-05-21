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
ifdef PTXCONF_GLIB1210
PACKAGES += glib1210
endif

#
# Paths and names
#
GLIB1210_VERSION	= 1.2.10
GLIB1210		= glib-$(GLIB1210_VERSION)
GLIB1210_SUFFIX		= tar.gz
GLIB1210_URL		= ftp://ftp.gtk.org/pub/gtk/v1.2/$(GLIB1210).$(GLIB1210_SUFFIX)
GLIB1210_SOURCE		= $(SRCDIR)/$(GLIB1210).$(GLIB1210_SUFFIX)
GLIB1210_DIR		= $(BUILDDIR)/$(GLIB1210)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib1210_get: $(STATEDIR)/glib1210.get

glib1210_get_deps	=  $(GLIB1210_SOURCE)

$(STATEDIR)/glib1210.get: $(glib1210_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GLIB1210_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIB1210_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib1210_extract: $(STATEDIR)/glib1210.extract

glib1210_extract_deps	=  $(STATEDIR)/glib1210.get

$(STATEDIR)/glib1210.extract: $(glib1210_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB1210_DIR))
	@$(call extract, $(GLIB1210_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib1210_prepare: $(STATEDIR)/glib1210.prepare

#
# dependencies
#
glib1210_prepare_deps =  $(STATEDIR)/glib1210.extract
glib1210_prepare_deps += $(STATEDIR)/virtual-xchain.install
ifdef PTXCONF_XFREE430
glib1210_prepare_deps += $(STATEDIR)/xfree430.install
else
ifdef PTXCONF_XSERVER
glib1210_prepare_deps += $(STATEDIR)/xserver.install
endif
endif

GLIB1210_PATH	=  PATH=$(CROSS_PATH)
GLIB1210_ENV 	=  $(CROSS_ENV)
#GLIB1210_ENV	+= PKG_CONFIG_PATH=../$(GLIB1210):../$(ATK124):../$(PANGO12):../$(GTK22)

#GLIB1210_ENV	+= glib_cv_use_pid_surrogate=no
#GLIB1210_ENV	+= ac_cv_func_posix_getpwuid_r=yes 
#ifeq (y, $G(PTXCONF_GLIBC_DL))
#GLIB1210_ENV	+= glib_cv_uscore=yes
#else
#GLIB1210_ENV	+= glib_cv_uscore=no
#endif
#GLIB1210_ENV	+= glib_cv_stack_grows=no

#
# autoconf
#
GLIB1210_AUTOCONF	=  $(CROSS_AUTOCONF)
GLIB1210_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

GLIB1210_AUTOCONF	+= --with-threads=posix

$(STATEDIR)/glib1210.prepare: $(glib1210_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIB1210_BUILDDIR))
	cd $(GLIB1210_DIR) && \
		$(GLIB1210_PATH) $(GLIB1210_ENV) \
		./configure $(GLIB1210_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib1210_compile: $(STATEDIR)/glib1210.compile

glib1210_compile_deps =  $(STATEDIR)/glib1210.prepare

$(STATEDIR)/glib1210.compile: $(glib1210_compile_deps)
	@$(call targetinfo, $@)
	$(GLIB1210_PATH) $(GLIB1210_ENV) make -C $(GLIB1210_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib1210_install: $(STATEDIR)/glib1210.install

$(STATEDIR)/glib1210.install: $(STATEDIR)/glib1210.compile
	@$(call targetinfo, $@)
	$(GLIB1210_PATH) $(GLIB1210_ENV) make -C $(GLIB1210_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib1210_targetinstall: $(STATEDIR)/glib1210.targetinstall

glib1210_targetinstall_deps	=  $(STATEDIR)/glib1210.compile

$(STATEDIR)/glib1210.targetinstall: $(glib1210_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,glib1210)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GLIB1210_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# glib
	@$(call install_copy, 0, 0, 0644, $(GLIB1210_DIR)/.libs/libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so.0.0.10)
	@$(call install_link, libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so.0)
	@$(call install_link, libglib-1.2.so.0.0.10, /usr/lib/libglib-1.2.so)

	# gmodule
	@$(call install_copy, 0, 0, 0644, $(GLIB1210_DIR)/gmodule/.libs/libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so.0.0.10)
	@$(call install_link, libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so.0)
	@$(call install_link, libgmodule-1.2.so.0.0.10, /usr/lib/libgmodule-1.2.so)

	# gthread
	@$(call install_copy, 0, 0, 0644, $(GLIB1210_DIR)/gthread/.libs/libgthread-1.2.so.0.0.10, /usr/lib/libgthread-1.2.so.0.0.10)
	@$(call install_link, libgthread-1.2.so.0.0.10 /usr/lib/libgthread-1.2.so.0)
	@$(call install_link, libgthread-1.2.so.0.0.10 /usr/lib/libgthread-1.2.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib1210_clean:
	rm -rf $(STATEDIR)/glib1210.*
	rm -rf $(IMAGEDIR)/glib1210_*
	rm -rf $(GLIB1210_DIR)

# vim: syntax=make

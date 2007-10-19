# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XPM) += xorg-lib-Xpm

#
# Paths and names
#
XORG_LIB_XPM_VERSION	:= 3.5.7
XORG_LIB_XPM		:= libXpm-$(XORG_LIB_XPM_VERSION)
XORG_LIB_XPM_SUFFIX	:= tar.bz2
XORG_LIB_XPM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX)
XORG_LIB_XPM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX)
XORG_LIB_XPM_DIR	:= $(BUILDDIR)/$(XORG_LIB_XPM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xpm_get: $(STATEDIR)/xorg-lib-Xpm.get

$(STATEDIR)/xorg-lib-Xpm.get: $(xorg-lib-Xpm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XPM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XPM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xpm_extract: $(STATEDIR)/xorg-lib-Xpm.extract

$(STATEDIR)/xorg-lib-Xpm.extract: $(xorg-lib-Xpm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPM_DIR))
	@$(call extract, XORG_LIB_XPM)
	@$(call patchin, XORG_LIB_XPM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xpm_prepare: $(STATEDIR)/xorg-lib-Xpm.prepare

XORG_LIB_XPM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XPM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-Xpm.prepare: $(xorg-lib-Xpm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPM_DIR)/config.cache)
	cd $(XORG_LIB_XPM_DIR) && \
		$(XORG_LIB_XPM_PATH) $(XORG_LIB_XPM_ENV) \
		./configure $(XORG_LIB_XPM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xpm_compile: $(STATEDIR)/xorg-lib-Xpm.compile

$(STATEDIR)/xorg-lib-Xpm.compile: $(xorg-lib-Xpm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XPM_DIR) && $(XORG_LIB_XPM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xpm_install: $(STATEDIR)/xorg-lib-Xpm.install

$(STATEDIR)/xorg-lib-Xpm.install: $(xorg-lib-Xpm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XPM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xpm_targetinstall: $(STATEDIR)/xorg-lib-Xpm.targetinstall

$(STATEDIR)/xorg-lib-Xpm.targetinstall: $(xorg-lib-Xpm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xpm)
	@$(call install_fixup, xorg-lib-Xpm,PACKAGE,xorg-lib-xpm)
	@$(call install_fixup, xorg-lib-Xpm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xpm,VERSION,$(XORG_LIB_XPM_VERSION))
	@$(call install_fixup, xorg-lib-Xpm,SECTION,base)
	@$(call install_fixup, xorg-lib-Xpm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xpm,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xpm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xpm, 0, 0, 0644, \
		$(XORG_LIB_XPM_DIR)/src/.libs/libXpm.so.4.11.0, \
		$(XORG_LIBDIR)/libXpm.so.4.11.0)

	@$(call install_link, xorg-lib-Xpm, \
		libXpm.so.4.11.0, \
		$(XORG_LIBDIR)/libXpm.so.4)

	@$(call install_link, xorg-lib-Xpm, \
		libXpm.so.4.11.0, \
		$(XORG_LIBDIR)/libXpm.so)

	@$(call install_finish, xorg-lib-Xpm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xpm_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xpm.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xpm_*
	rm -rf $(XORG_LIB_XPM_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XXF86DGA) += xorg-lib-xxf86dga

#
# Paths and names
#
XORG_LIB_XXF86DGA_VERSION	:= 1.1.1
XORG_LIB_XXF86DGA		:= libXxf86dga-$(XORG_LIB_XXF86DGA_VERSION)
XORG_LIB_XXF86DGA_SUFFIX	:= tar.bz2
XORG_LIB_XXF86DGA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XXF86DGA).$(XORG_LIB_XXF86DGA_SUFFIX)
XORG_LIB_XXF86DGA_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XXF86DGA).$(XORG_LIB_XXF86DGA_SUFFIX)
XORG_LIB_XXF86DGA_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86DGA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_get: $(STATEDIR)/xorg-lib-xxf86dga.get

$(STATEDIR)/xorg-lib-xxf86dga.get: $(xorg-lib-xxf86dga_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XXF86DGA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XXF86DGA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_extract: $(STATEDIR)/xorg-lib-xxf86dga.extract

$(STATEDIR)/xorg-lib-xxf86dga.extract: $(xorg-lib-xxf86dga_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XXF86DGA_DIR))
	@$(call extract, XORG_LIB_XXF86DGA)
	@$(call patchin, XORG_LIB_XXF86DGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_prepare: $(STATEDIR)/xorg-lib-xxf86dga.prepare

XORG_LIB_XXF86DGA_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XXF86DGA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XXF86DGA_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xxf86dga.prepare: $(xorg-lib-xxf86dga_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XXF86DGA_DIR)/config.cache)
	cd $(XORG_LIB_XXF86DGA_DIR) && \
		$(XORG_LIB_XXF86DGA_PATH) $(XORG_LIB_XXF86DGA_ENV) \
		./configure $(XORG_LIB_XXF86DGA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_compile: $(STATEDIR)/xorg-lib-xxf86dga.compile

$(STATEDIR)/xorg-lib-xxf86dga.compile: $(xorg-lib-xxf86dga_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XXF86DGA_DIR) && $(XORG_LIB_XXF86DGA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_install: $(STATEDIR)/xorg-lib-xxf86dga.install

$(STATEDIR)/xorg-lib-xxf86dga.install: $(xorg-lib-xxf86dga_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XXF86DGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_targetinstall: $(STATEDIR)/xorg-lib-xxf86dga.targetinstall

$(STATEDIR)/xorg-lib-xxf86dga.targetinstall: $(xorg-lib-xxf86dga_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xxf86dga)
	@$(call install_fixup, xorg-lib-xxf86dga,PACKAGE,xorg-lib-xxf86dga)
	@$(call install_fixup, xorg-lib-xxf86dga,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xxf86dga,VERSION,$(XORG_LIB_XXF86DGA_VERSION))
	@$(call install_fixup, xorg-lib-xxf86dga,SECTION,base)
	@$(call install_fixup, xorg-lib-xxf86dga,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xxf86dga,DEPENDS,)
	@$(call install_fixup, xorg-lib-xxf86dga,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xxf86dga, 0, 0, 0644, \
		$(XORG_LIB_XXF86DGA_DIR)/src/.libs/libXxf86dga.so.1.0.0, \
		$(XORG_LIBDIR)/libXxf86dga.so.1.0.0)

	@$(call install_link, xorg-lib-xxf86dga, \
		libXxf86dga.so.1.0.0, \
		$(XORG_LIBDIR)/libXxf86dga.so.1)

	@$(call install_link, xorg-lib-xxf86dga, \
		libXxf86dga.so.1.0.0, \
		$(XORG_LIBDIR)/libXxf86dga.so)


	@$(call install_finish, xorg-lib-xxf86dga)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xxf86dga_clean:
	rm -rf $(STATEDIR)/xorg-lib-xxf86dga.*
	rm -rf $(PKGDIR)/xorg-lib-xxf86dga_*
	rm -rf $(XORG_LIB_XXF86DGA_DIR)

# vim: syntax=make

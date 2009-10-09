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
PACKAGES-$(PTXCONF_XORG_LIB_XRES) += xorg-lib-xres

#
# Paths and names
#
XORG_LIB_XRES_VERSION	:= 1.0.4
XORG_LIB_XRES		:= libXres-$(XORG_LIB_XRES_VERSION)
XORG_LIB_XRES_SUFFIX	:= tar.bz2
XORG_LIB_XRES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xres_get: $(STATEDIR)/xorg-lib-xres.get

$(STATEDIR)/xorg-lib-xres.get: $(xorg-lib-xres_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XRES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xres_extract: $(STATEDIR)/xorg-lib-xres.extract

$(STATEDIR)/xorg-lib-xres.extract: $(xorg-lib-xres_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRES_DIR))
	@$(call extract, XORG_LIB_XRES)
	@$(call patchin, XORG_LIB_XRES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xres_prepare: $(STATEDIR)/xorg-lib-xres.prepare

XORG_LIB_XRES_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XRES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRES_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XRES_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xres.prepare: $(xorg-lib-xres_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRES_DIR)/config.cache)
	cd $(XORG_LIB_XRES_DIR) && \
		$(XORG_LIB_XRES_PATH) $(XORG_LIB_XRES_ENV) \
		./configure $(XORG_LIB_XRES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xres_compile: $(STATEDIR)/xorg-lib-xres.compile

$(STATEDIR)/xorg-lib-xres.compile: $(xorg-lib-xres_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRES_DIR) && $(XORG_LIB_XRES_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xres_install: $(STATEDIR)/xorg-lib-xres.install

$(STATEDIR)/xorg-lib-xres.install: $(xorg-lib-xres_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xres_targetinstall: $(STATEDIR)/xorg-lib-xres.targetinstall

$(STATEDIR)/xorg-lib-xres.targetinstall: $(xorg-lib-xres_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PACKAGE,xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xres,VERSION,$(XORG_LIB_XRES_VERSION))
	@$(call install_fixup, xorg-lib-xres,SECTION,base)
	@$(call install_fixup, xorg-lib-xres,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xres,DEPENDS,)
	@$(call install_fixup, xorg-lib-xres,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xres, 0, 0, 0644, \
		$(XORG_LIB_XRES_DIR)/src/.libs/libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so.1.0.0)

	@$(call install_link, xorg-lib-xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so.1)

	@$(call install_link, xorg-lib-xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so)

	@$(call install_finish, xorg-lib-xres)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xres_clean:
	rm -rf $(STATEDIR)/xorg-lib-xres.*
	rm -rf $(PKGDIR)/xorg-lib-xres_*
	rm -rf $(XORG_LIB_XRES_DIR)

# vim: syntax=make

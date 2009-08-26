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
PACKAGES-$(PTXCONF_XORG_LIB_XI) += xorg-lib-xi

#
# Paths and names
#
XORG_LIB_XI_VERSION	:= 1.3
XORG_LIB_XI		:= libXi-$(XORG_LIB_XI_VERSION)
XORG_LIB_XI_SUFFIX	:= tar.bz2
XORG_LIB_XI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_DIR		:= $(BUILDDIR)/$(XORG_LIB_XI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xi_get: $(STATEDIR)/xorg-lib-xi.get

$(STATEDIR)/xorg-lib-xi.get: $(xorg-lib-xi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xi_extract: $(STATEDIR)/xorg-lib-xi.extract

$(STATEDIR)/xorg-lib-xi.extract: $(xorg-lib-xi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XI_DIR))
	@$(call extract, XORG_LIB_XI)
	@$(call patchin, XORG_LIB_XI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xi_prepare: $(STATEDIR)/xorg-lib-xi.prepare

XORG_LIB_XI_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XI_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XI_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xi.prepare: $(xorg-lib-xi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XI_DIR)/config.cache)
	cd $(XORG_LIB_XI_DIR) && \
		$(XORG_LIB_XI_PATH) $(XORG_LIB_XI_ENV) \
		./configure $(XORG_LIB_XI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xi_compile: $(STATEDIR)/xorg-lib-xi.compile

$(STATEDIR)/xorg-lib-xi.compile: $(xorg-lib-xi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XI_DIR) && $(XORG_LIB_XI_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xi_install: $(STATEDIR)/xorg-lib-xi.install

$(STATEDIR)/xorg-lib-xi.install: $(xorg-lib-xi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xi_targetinstall: $(STATEDIR)/xorg-lib-xi.targetinstall

$(STATEDIR)/xorg-lib-xi.targetinstall: $(xorg-lib-xi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xi)
	@$(call install_fixup, xorg-lib-xi,PACKAGE,xorg-lib-xi)
	@$(call install_fixup, xorg-lib-xi,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xi,VERSION,$(XORG_LIB_XI_VERSION))
	@$(call install_fixup, xorg-lib-xi,SECTION,base)
	@$(call install_fixup, xorg-lib-xi,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xi,DEPENDS,)
	@$(call install_fixup, xorg-lib-xi,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xi, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXi.so.6.1.0)

	@$(call install_link, xorg-lib-xi, \
		libXi.so.6.1.0, \
		$(XORG_LIBDIR)/libXi.so.6)

	@$(call install_link, xorg-lib-xi, \
		libXi.so.6.1.0, \
		$(XORG_LIBDIR)/libXi.so)

	@$(call install_finish, xorg-lib-xi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xi_clean:
	rm -rf $(STATEDIR)/xorg-lib-xi.*
	rm -rf $(PKGDIR)/xorg-lib-xi_*
	rm -rf $(XORG_LIB_XI_DIR)

# vim: syntax=make

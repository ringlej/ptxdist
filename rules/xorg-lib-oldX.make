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
PACKAGES-$(PTXCONF_XORG_LIB_OLDX) += xorg-lib-oldx

#
# Paths and names
#
XORG_LIB_OLDX_VERSION	:= 1.0.1
XORG_LIB_OLDX		:= liboldX-$(XORG_LIB_OLDX_VERSION)
XORG_LIB_OLDX_SUFFIX	:= tar.bz2
XORG_LIB_OLDX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_DIR	:= $(BUILDDIR)/$(XORG_LIB_OLDX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-oldx_get: $(STATEDIR)/xorg-lib-oldx.get

$(STATEDIR)/xorg-lib-oldx.get: $(xorg-lib-oldx_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_OLDX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_OLDX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-oldx_extract: $(STATEDIR)/xorg-lib-oldx.extract

$(STATEDIR)/xorg-lib-oldx.extract: $(xorg-lib-oldx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_OLDX_DIR))
	@$(call extract, XORG_LIB_OLDX)
	@$(call patchin, XORG_LIB_OLDX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-oldx_prepare: $(STATEDIR)/xorg-lib-oldx.prepare

XORG_LIB_OLDX_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_OLDX_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_OLDX_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-oldx.prepare: $(xorg-lib-oldx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_OLDX_DIR)/config.cache)
	cd $(XORG_LIB_OLDX_DIR) && \
		$(XORG_LIB_OLDX_PATH) $(XORG_LIB_OLDX_ENV) \
		./configure $(XORG_LIB_OLDX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-oldx_compile: $(STATEDIR)/xorg-lib-oldx.compile

$(STATEDIR)/xorg-lib-oldx.compile: $(xorg-lib-oldx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_OLDX_DIR) && $(XORG_LIB_OLDX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-oldx_install: $(STATEDIR)/xorg-lib-oldx.install

$(STATEDIR)/xorg-lib-oldx.install: $(xorg-lib-oldx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_OLDX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-oldx_targetinstall: $(STATEDIR)/xorg-lib-oldx.targetinstall

$(STATEDIR)/xorg-lib-oldx.targetinstall: $(xorg-lib-oldx_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-oldx)
	@$(call install_fixup, xorg-lib-oldx,PACKAGE,xorg-lib-oldx)
	@$(call install_fixup, xorg-lib-oldx,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-oldx,VERSION,$(XORG_LIB_OLDX_VERSION))
	@$(call install_fixup, xorg-lib-oldx,SECTION,base)
	@$(call install_fixup, xorg-lib-oldx,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-oldx,DEPENDS,)
	@$(call install_fixup, xorg-lib-oldx,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-oldx, 0, 0, 0644, \
		$(XORG_LIB_OLDX_DIR)/src/.libs/liboldX.so.6.0.0, \
		$(XORG_LIBDIR)/liboldX.so.6.0.0)

	@$(call install_link, xorg-lib-oldx, \
		liboldX.so.6.0.0, \
		$(XORG_LIBDIR)/liboldX.so.6)

	@$(call install_link, xorg-lib-oldx, \
		liboldX.so.6.0.0, \
		$(XORG_LIBDIR)/liboldX.so)

	@$(call install_finish, xorg-lib-oldx)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-oldx_clean:
	rm -rf $(STATEDIR)/xorg-lib-oldx.*
	rm -rf $(PKGDIR)/xorg-lib-oldx_*
	rm -rf $(XORG_LIB_OLDX_DIR)

# vim: syntax=make

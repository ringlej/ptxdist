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
PACKAGES-$(PTXCONF_XORG_LIB_XI) += xorg-lib-Xi

#
# Paths and names
#
XORG_LIB_XI_VERSION	:= 1.1.3
XORG_LIB_XI		:= libXi-$(XORG_LIB_XI_VERSION)
XORG_LIB_XI_SUFFIX	:= tar.bz2
XORG_LIB_XI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_DIR		:= $(BUILDDIR)/$(XORG_LIB_XI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xi_get: $(STATEDIR)/xorg-lib-Xi.get

$(STATEDIR)/xorg-lib-Xi.get: $(xorg-lib-Xi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xi_extract: $(STATEDIR)/xorg-lib-Xi.extract

$(STATEDIR)/xorg-lib-Xi.extract: $(xorg-lib-Xi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XI_DIR))
	@$(call extract, XORG_LIB_XI)
	@$(call patchin, XORG_LIB_XI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xi_prepare: $(STATEDIR)/xorg-lib-Xi.prepare

XORG_LIB_XI_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XI_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XI_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xi.prepare: $(xorg-lib-Xi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XI_DIR)/config.cache)
	cd $(XORG_LIB_XI_DIR) && \
		$(XORG_LIB_XI_PATH) $(XORG_LIB_XI_ENV) \
		./configure $(XORG_LIB_XI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xi_compile: $(STATEDIR)/xorg-lib-Xi.compile

$(STATEDIR)/xorg-lib-Xi.compile: $(xorg-lib-Xi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XI_DIR) && $(XORG_LIB_XI_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xi_install: $(STATEDIR)/xorg-lib-Xi.install

$(STATEDIR)/xorg-lib-Xi.install: $(xorg-lib-Xi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xi_targetinstall: $(STATEDIR)/xorg-lib-Xi.targetinstall

$(STATEDIR)/xorg-lib-Xi.targetinstall: $(xorg-lib-Xi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xi)
	@$(call install_fixup, xorg-lib-Xi,PACKAGE,xorg-lib-xi)
	@$(call install_fixup, xorg-lib-Xi,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xi,VERSION,$(XORG_LIB_XI_VERSION))
	@$(call install_fixup, xorg-lib-Xi,SECTION,base)
	@$(call install_fixup, xorg-lib-Xi,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xi,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xi,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xi, 0, 0, 0644, \
		$(XORG_LIB_XI_DIR)/src/.libs/libXi.so.6.0.0, \
		$(XORG_LIBDIR)/libXi.so.6.0.0)

	@$(call install_link, xorg-lib-Xi, \
		libXi.so.6.0.0, \
		$(XORG_LIBDIR)/libXi.so.6)

	@$(call install_link, xorg-lib-Xi, \
		libXi.so.6.0.0, \
		$(XORG_LIBDIR)/libXi.so)

	@$(call install_finish, xorg-lib-Xi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xi_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xi.*
	rm -rf $(PKGDIR)/xorg-lib-Xi_*
	rm -rf $(XORG_LIB_XI_DIR)

# vim: syntax=make

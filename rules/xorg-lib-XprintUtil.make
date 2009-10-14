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
PACKAGES-$(PTXCONF_XORG_LIB_XPRINTUTIL) += xorg-lib-xprintutil

#
# Paths and names
#
XORG_LIB_XPRINTUTIL_VERSION	:= 1.0.1
XORG_LIB_XPRINTUTIL		:= libXprintUtil-$(XORG_LIB_XPRINTUTIL_VERSION)
XORG_LIB_XPRINTUTIL_SUFFIX	:= tar.bz2
XORG_LIB_XPRINTUTIL_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XPRINTUTIL).$(XORG_LIB_XPRINTUTIL_SUFFIX)
XORG_LIB_XPRINTUTIL_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPRINTUTIL).$(XORG_LIB_XPRINTUTIL_SUFFIX)
XORG_LIB_XPRINTUTIL_DIR		:= $(BUILDDIR)/$(XORG_LIB_XPRINTUTIL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_get: $(STATEDIR)/xorg-lib-xprintutil.get

$(STATEDIR)/xorg-lib-xprintutil.get: $(xorg-lib-xprintutil_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XPRINTUTIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XPRINTUTIL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_extract: $(STATEDIR)/xorg-lib-xprintutil.extract

$(STATEDIR)/xorg-lib-xprintutil.extract: $(xorg-lib-xprintutil_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPRINTUTIL_DIR))
	@$(call extract, XORG_LIB_XPRINTUTIL)
	@$(call patchin, XORG_LIB_XPRINTUTIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_prepare: $(STATEDIR)/xorg-lib-xprintutil.prepare

XORG_LIB_XPRINTUTIL_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XPRINTUTIL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPRINTUTIL_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xprintutil.prepare: $(xorg-lib-xprintutil_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPRINTUTIL_DIR)/config.cache)
	cd $(XORG_LIB_XPRINTUTIL_DIR) && \
		$(XORG_LIB_XPRINTUTIL_PATH) $(XORG_LIB_XPRINTUTIL_ENV) \
		./configure $(XORG_LIB_XPRINTUTIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_compile: $(STATEDIR)/xorg-lib-xprintutil.compile

$(STATEDIR)/xorg-lib-xprintutil.compile: $(xorg-lib-xprintutil_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XPRINTUTIL_DIR) && $(XORG_LIB_XPRINTUTIL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_install: $(STATEDIR)/xorg-lib-xprintutil.install

$(STATEDIR)/xorg-lib-xprintutil.install: $(xorg-lib-xprintutil_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XPRINTUTIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_targetinstall: $(STATEDIR)/xorg-lib-xprintutil.targetinstall

$(STATEDIR)/xorg-lib-xprintutil.targetinstall: $(xorg-lib-xprintutil_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xprintutil)
	@$(call install_fixup, xorg-lib-xprintutil,PACKAGE,xorg-lib-xprintutil)
	@$(call install_fixup, xorg-lib-xprintutil,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xprintutil,VERSION,$(XORG_LIB_XPRINTUTIL_VERSION))
	@$(call install_fixup, xorg-lib-xprintutil,SECTION,base)
	@$(call install_fixup, xorg-lib-xprintutil,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xprintutil,DEPENDS,)
	@$(call install_fixup, xorg-lib-xprintutil,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xprintutil, 0, 0, 0644, \
		$(XORG_LIB_XPRINTUTIL_DIR)/src/.libs/libXprintUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintUtil.so.1.0.0)

	@$(call install_link, xorg-lib-xprintutil, \
		libXprintUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintUtil.so.1)

	@$(call install_link, xorg-lib-xprintutil, \
		libXprintUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintUtil.so)

	@$(call install_finish, xorg-lib-xprintutil)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xprintutil_clean:
	rm -rf $(STATEDIR)/xorg-lib-xprintutil.*
	rm -rf $(PKGDIR)/xorg-lib-xprintutil_*
	rm -rf $(XORG_LIB_XPRINTUTIL_DIR)

# vim: syntax=make

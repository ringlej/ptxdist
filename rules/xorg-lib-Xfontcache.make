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
PACKAGES-$(PTXCONF_XORG_LIB_XFONTCACHE) += xorg-lib-xfontcache

#
# Paths and names
#
XORG_LIB_XFONTCACHE_VERSION	:= 1.0.5
XORG_LIB_XFONTCACHE		:= libXfontcache-$(XORG_LIB_XFONTCACHE_VERSION)
XORG_LIB_XFONTCACHE_SUFFIX	:= tar.bz2
XORG_LIB_XFONTCACHE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XFONTCACHE).$(XORG_LIB_XFONTCACHE_SUFFIX)
XORG_LIB_XFONTCACHE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONTCACHE).$(XORG_LIB_XFONTCACHE_SUFFIX)
XORG_LIB_XFONTCACHE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XFONTCACHE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_get: $(STATEDIR)/xorg-lib-xfontcache.get

$(STATEDIR)/xorg-lib-xfontcache.get: $(xorg-lib-xfontcache_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XFONTCACHE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XFONTCACHE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_extract: $(STATEDIR)/xorg-lib-xfontcache.extract

$(STATEDIR)/xorg-lib-xfontcache.extract: $(xorg-lib-xfontcache_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONTCACHE_DIR))
	@$(call extract, XORG_LIB_XFONTCACHE)
	@$(call patchin, XORG_LIB_XFONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_prepare: $(STATEDIR)/xorg-lib-xfontcache.prepare

XORG_LIB_XFONTCACHE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFONTCACHE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFONTCACHE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xfontcache.prepare: $(xorg-lib-xfontcache_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONTCACHE_DIR)/config.cache)
	cd $(XORG_LIB_XFONTCACHE_DIR) && \
		$(XORG_LIB_XFONTCACHE_PATH) $(XORG_LIB_XFONTCACHE_ENV) \
		./configure $(XORG_LIB_XFONTCACHE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_compile: $(STATEDIR)/xorg-lib-xfontcache.compile

$(STATEDIR)/xorg-lib-xfontcache.compile: $(xorg-lib-xfontcache_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XFONTCACHE_DIR) && $(XORG_LIB_XFONTCACHE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_install: $(STATEDIR)/xorg-lib-xfontcache.install

$(STATEDIR)/xorg-lib-xfontcache.install: $(xorg-lib-xfontcache_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XFONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_targetinstall: $(STATEDIR)/xorg-lib-xfontcache.targetinstall

$(STATEDIR)/xorg-lib-xfontcache.targetinstall: $(xorg-lib-xfontcache_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xfontcache)
	@$(call install_fixup, xorg-lib-xfontcache,PACKAGE,xorg-lib-xfontcache)
	@$(call install_fixup, xorg-lib-xfontcache,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfontcache,VERSION,$(XORG_LIB_XFONTCACHE_VERSION))
	@$(call install_fixup, xorg-lib-xfontcache,SECTION,base)
	@$(call install_fixup, xorg-lib-xfontcache,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfontcache,DEPENDS,)
	@$(call install_fixup, xorg-lib-xfontcache,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xfontcache, 0, 0, 0644, \
		$(XORG_LIB_XFONTCACHE_DIR)/src/.libs/libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so.1.0.0)

	@$(call install_link, xorg-lib-xfontcache, \
		libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so.1)

	@$(call install_link, xorg-lib-xfontcache, \
		libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so)

	@$(call install_finish, xorg-lib-xfontcache)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xfontcache_clean:
	rm -rf $(STATEDIR)/xorg-lib-xfontcache.*
	rm -rf $(PKGDIR)/xorg-lib-xfontcache_*
	rm -rf $(XORG_LIB_XFONTCACHE_DIR)

# vim: syntax=make

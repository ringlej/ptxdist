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
PACKAGES-$(PTXCONF_XORG_LIB_XFONTCACHE) += xorg-lib-Xfontcache

#
# Paths and names
#
XORG_LIB_XFONTCACHE_VERSION	:= 1.0.2
XORG_LIB_XFONTCACHE		:= libXfontcache-X11R7.1-$(XORG_LIB_XFONTCACHE_VERSION)
XORG_LIB_XFONTCACHE_SUFFIX	:= tar.bz2
XORG_LIB_XFONTCACHE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_XFONTCACHE).$(XORG_LIB_XFONTCACHE_SUFFIX)
XORG_LIB_XFONTCACHE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONTCACHE).$(XORG_LIB_XFONTCACHE_SUFFIX)
XORG_LIB_XFONTCACHE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XFONTCACHE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_get: $(STATEDIR)/xorg-lib-Xfontcache.get

$(STATEDIR)/xorg-lib-Xfontcache.get: $(xorg-lib-Xfontcache_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XFONTCACHE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XFONTCACHE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_extract: $(STATEDIR)/xorg-lib-Xfontcache.extract

$(STATEDIR)/xorg-lib-Xfontcache.extract: $(xorg-lib-Xfontcache_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONTCACHE_DIR))
	@$(call extract, XORG_LIB_XFONTCACHE)
	@$(call patchin, XORG_LIB_XFONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_prepare: $(STATEDIR)/xorg-lib-Xfontcache.prepare

XORG_LIB_XFONTCACHE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFONTCACHE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFONTCACHE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xfontcache.prepare: $(xorg-lib-Xfontcache_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONTCACHE_DIR)/config.cache)
	cd $(XORG_LIB_XFONTCACHE_DIR) && \
		$(XORG_LIB_XFONTCACHE_PATH) $(XORG_LIB_XFONTCACHE_ENV) \
		./configure $(XORG_LIB_XFONTCACHE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_compile: $(STATEDIR)/xorg-lib-Xfontcache.compile

$(STATEDIR)/xorg-lib-Xfontcache.compile: $(xorg-lib-Xfontcache_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XFONTCACHE_DIR) && $(XORG_LIB_XFONTCACHE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_install: $(STATEDIR)/xorg-lib-Xfontcache.install

$(STATEDIR)/xorg-lib-Xfontcache.install: $(xorg-lib-Xfontcache_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XFONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_targetinstall: $(STATEDIR)/xorg-lib-Xfontcache.targetinstall

$(STATEDIR)/xorg-lib-Xfontcache.targetinstall: $(xorg-lib-Xfontcache_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xfontcache)
	@$(call install_fixup, xorg-lib-Xfontcache,PACKAGE,xorg-lib-xfontcache)
	@$(call install_fixup, xorg-lib-Xfontcache,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xfontcache,VERSION,$(XORG_LIB_XFONTCACHE_VERSION))
	@$(call install_fixup, xorg-lib-Xfontcache,SECTION,base)
	@$(call install_fixup, xorg-lib-Xfontcache,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xfontcache,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xfontcache,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xfontcache, 0, 0, 0644, \
		$(XORG_LIB_XFONTCACHE_DIR)/src/.libs/libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so.1.0.0)

	@$(call install_link, xorg-lib-Xfontcache, \
		libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so.1)

	@$(call install_link, xorg-lib-Xfontcache, \
		libXfontcache.so.1.0.0, \
		$(XORG_LIBDIR)/libXfontcache.so)

	@$(call install_finish, xorg-lib-Xfontcache)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xfontcache_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xfontcache.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xfontcache_*
	rm -rf $(XORG_LIB_XFONTCACHE_DIR)

# vim: syntax=make

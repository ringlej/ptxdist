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
PACKAGES-$(PTXCONF_XORG_LIB_XRENDER) += xorg-lib-xrender

#
# Paths and names
#
XORG_LIB_XRENDER_VERSION	:= 0.9.5
XORG_LIB_XRENDER		:= libXrender-$(XORG_LIB_XRENDER_VERSION)
XORG_LIB_XRENDER_SUFFIX		:= tar.bz2
XORG_LIB_XRENDER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XRENDER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xrender_get: $(STATEDIR)/xorg-lib-xrender.get

$(STATEDIR)/xorg-lib-xrender.get: $(xorg-lib-xrender_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRENDER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XRENDER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xrender_extract: $(STATEDIR)/xorg-lib-xrender.extract

$(STATEDIR)/xorg-lib-xrender.extract: $(xorg-lib-xrender_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRENDER_DIR))
	@$(call extract, XORG_LIB_XRENDER)
	@$(call patchin, XORG_LIB_XRENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xrender_prepare: $(STATEDIR)/xorg-lib-xrender.prepare

XORG_LIB_XRENDER_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XRENDER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRENDER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xrender.prepare: $(xorg-lib-xrender_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRENDER_DIR)/config.cache)
	cd $(XORG_LIB_XRENDER_DIR) && \
		$(XORG_LIB_XRENDER_PATH) $(XORG_LIB_XRENDER_ENV) \
		./configure $(XORG_LIB_XRENDER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xrender_compile: $(STATEDIR)/xorg-lib-xrender.compile

$(STATEDIR)/xorg-lib-xrender.compile: $(xorg-lib-xrender_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRENDER_DIR) && $(XORG_LIB_XRENDER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xrender_install: $(STATEDIR)/xorg-lib-xrender.install

$(STATEDIR)/xorg-lib-xrender.install: $(xorg-lib-xrender_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xrender_targetinstall: $(STATEDIR)/xorg-lib-xrender.targetinstall

$(STATEDIR)/xorg-lib-xrender.targetinstall: $(xorg-lib-xrender_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-xrender,PACKAGE,xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-xrender,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xrender,VERSION,$(XORG_LIB_XRENDER_VERSION))
	@$(call install_fixup, xorg-lib-xrender,SECTION,base)
	@$(call install_fixup, xorg-lib-xrender,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xrender,DEPENDS,)
	@$(call install_fixup, xorg-lib-xrender,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xrender, 0, 0, 0644, \
		$(XORG_LIB_XRENDER_DIR)/src/.libs/libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so.1.3.0)

	@$(call install_link, xorg-lib-xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so.1)

	@$(call install_link, xorg-lib-xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so)

	@$(call install_finish, xorg-lib-xrender)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xrender_clean:
	rm -rf $(STATEDIR)/xorg-lib-xrender.*
	rm -rf $(PKGDIR)/xorg-lib-xrender_*
	rm -rf $(XORG_LIB_XRENDER_DIR)

# vim: syntax=make

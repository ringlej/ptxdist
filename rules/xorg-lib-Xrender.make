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
PACKAGES-$(PTXCONF_XORG_LIB_XRENDER) += xorg-lib-Xrender

#
# Paths and names
#
XORG_LIB_XRENDER_VERSION	:= 0.9.4
XORG_LIB_XRENDER		:= libXrender-$(XORG_LIB_XRENDER_VERSION)
XORG_LIB_XRENDER_SUFFIX		:= tar.bz2
XORG_LIB_XRENDER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XRENDER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xrender_get: $(STATEDIR)/xorg-lib-Xrender.get

$(STATEDIR)/xorg-lib-Xrender.get: $(xorg-lib-Xrender_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRENDER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XRENDER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xrender_extract: $(STATEDIR)/xorg-lib-Xrender.extract

$(STATEDIR)/xorg-lib-Xrender.extract: $(xorg-lib-Xrender_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRENDER_DIR))
	@$(call extract, XORG_LIB_XRENDER)
	@$(call patchin, XORG_LIB_XRENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xrender_prepare: $(STATEDIR)/xorg-lib-Xrender.prepare

XORG_LIB_XRENDER_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XRENDER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRENDER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xrender.prepare: $(xorg-lib-Xrender_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRENDER_DIR)/config.cache)
	cd $(XORG_LIB_XRENDER_DIR) && \
		$(XORG_LIB_XRENDER_PATH) $(XORG_LIB_XRENDER_ENV) \
		./configure $(XORG_LIB_XRENDER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xrender_compile: $(STATEDIR)/xorg-lib-Xrender.compile

$(STATEDIR)/xorg-lib-Xrender.compile: $(xorg-lib-Xrender_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRENDER_DIR) && $(XORG_LIB_XRENDER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xrender_install: $(STATEDIR)/xorg-lib-Xrender.install

$(STATEDIR)/xorg-lib-Xrender.install: $(xorg-lib-Xrender_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xrender_targetinstall: $(STATEDIR)/xorg-lib-Xrender.targetinstall

$(STATEDIR)/xorg-lib-Xrender.targetinstall: $(xorg-lib-Xrender_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xrender)
	@$(call install_fixup, xorg-lib-Xrender,PACKAGE,xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-Xrender,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xrender,VERSION,$(XORG_LIB_XRENDER_VERSION))
	@$(call install_fixup, xorg-lib-Xrender,SECTION,base)
	@$(call install_fixup, xorg-lib-Xrender,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xrender,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xrender,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xrender, 0, 0, 0644, \
		$(XORG_LIB_XRENDER_DIR)/src/.libs/libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so.1.3.0)

	@$(call install_link, xorg-lib-Xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so.1)

	@$(call install_link, xorg-lib-Xrender, \
		libXrender.so.1.3.0, \
		$(XORG_LIBDIR)/libXrender.so)

	@$(call install_finish, xorg-lib-Xrender)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xrender_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xrender.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xrender_*
	rm -rf $(XORG_LIB_XRENDER_DIR)

# vim: syntax=make

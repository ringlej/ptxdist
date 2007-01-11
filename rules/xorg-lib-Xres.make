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
PACKAGES-$(PTXCONF_XORG_LIB_XRES) += xorg-lib-Xres

#
# Paths and names
#
XORG_LIB_XRES_VERSION	:= 1.0.1
XORG_LIB_XRES		:= libXres-X11R7.1-$(XORG_LIB_XRES_VERSION)
XORG_LIB_XRES_SUFFIX	:= tar.bz2
XORG_LIB_XRES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xres_get: $(STATEDIR)/xorg-lib-Xres.get

$(STATEDIR)/xorg-lib-Xres.get: $(xorg-lib-Xres_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XRES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xres_extract: $(STATEDIR)/xorg-lib-Xres.extract

$(STATEDIR)/xorg-lib-Xres.extract: $(xorg-lib-Xres_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRES_DIR))
	@$(call extract, XORG_LIB_XRES)
	@$(call patchin, XORG_LIB_XRES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xres_prepare: $(STATEDIR)/xorg-lib-Xres.prepare

XORG_LIB_XRES_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XRES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRES_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XRES_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xres.prepare: $(xorg-lib-Xres_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRES_DIR)/config.cache)
	cd $(XORG_LIB_XRES_DIR) && \
		$(XORG_LIB_XRES_PATH) $(XORG_LIB_XRES_ENV) \
		./configure $(XORG_LIB_XRES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xres_compile: $(STATEDIR)/xorg-lib-Xres.compile

$(STATEDIR)/xorg-lib-Xres.compile: $(xorg-lib-Xres_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRES_DIR) && $(XORG_LIB_XRES_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xres_install: $(STATEDIR)/xorg-lib-Xres.install

$(STATEDIR)/xorg-lib-Xres.install: $(xorg-lib-Xres_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xres_targetinstall: $(STATEDIR)/xorg-lib-Xres.targetinstall

$(STATEDIR)/xorg-lib-Xres.targetinstall: $(xorg-lib-Xres_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xres)
	@$(call install_fixup, xorg-lib-Xres,PACKAGE,xorg-lib-xres)
	@$(call install_fixup, xorg-lib-Xres,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xres,VERSION,$(XORG_LIB_XRES_VERSION))
	@$(call install_fixup, xorg-lib-Xres,SECTION,base)
	@$(call install_fixup, xorg-lib-Xres,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xres,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xres,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xres, 0, 0, 0644, \
		$(XORG_LIB_XRES_DIR)/src/.libs/libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so.1.0.0)

	@$(call install_link, xorg-lib-Xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so.1)

	@$(call install_link, xorg-lib-Xres, \
		libXRes.so.1.0.0, \
		$(XORG_LIBDIR)/libXRes.so)

	@$(call install_finish, xorg-lib-Xres)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xres_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xres.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xres_*
	rm -rf $(XORG_LIB_XRES_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_XCOMPOSITE) += xorg-lib-Xcomposite

#
# Paths and names
#
XORG_LIB_XCOMPOSITE_VERSION	:= 0.4.0
XORG_LIB_XCOMPOSITE		:= libXcomposite-$(XORG_LIB_XCOMPOSITE_VERSION)
XORG_LIB_XCOMPOSITE_SUFFIX	:= tar.bz2
XORG_LIB_XCOMPOSITE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCOMPOSITE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_get: $(STATEDIR)/xorg-lib-Xcomposite.get

$(STATEDIR)/xorg-lib-Xcomposite.get: $(xorg-lib-Xcomposite_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XCOMPOSITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XCOMPOSITE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_extract: $(STATEDIR)/xorg-lib-Xcomposite.extract

$(STATEDIR)/xorg-lib-Xcomposite.extract: $(xorg-lib-Xcomposite_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR))
	@$(call extract, XORG_LIB_XCOMPOSITE)
	@$(call patchin, XORG_LIB_XCOMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_prepare: $(STATEDIR)/xorg-lib-Xcomposite.prepare

XORG_LIB_XCOMPOSITE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCOMPOSITE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCOMPOSITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xcomposite.prepare: $(xorg-lib-Xcomposite_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR)/config.cache)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && \
		$(XORG_LIB_XCOMPOSITE_PATH) $(XORG_LIB_XCOMPOSITE_ENV) \
		./configure $(XORG_LIB_XCOMPOSITE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_compile: $(STATEDIR)/xorg-lib-Xcomposite.compile

$(STATEDIR)/xorg-lib-Xcomposite.compile: $(xorg-lib-Xcomposite_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && $(XORG_LIB_XCOMPOSITE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_install: $(STATEDIR)/xorg-lib-Xcomposite.install

$(STATEDIR)/xorg-lib-Xcomposite.install: $(xorg-lib-Xcomposite_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XCOMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_targetinstall: $(STATEDIR)/xorg-lib-Xcomposite.targetinstall

$(STATEDIR)/xorg-lib-Xcomposite.targetinstall: $(xorg-lib-Xcomposite_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xcomposite)
	@$(call install_fixup, xorg-lib-Xcomposite,PACKAGE,xorg-lib-xcomposite)
	@$(call install_fixup, xorg-lib-Xcomposite,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xcomposite,VERSION,$(XORG_LIB_XCOMPOSITE_VERSION))
	@$(call install_fixup, xorg-lib-Xcomposite,SECTION,base)
	@$(call install_fixup, xorg-lib-Xcomposite,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xcomposite,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xcomposite,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xcomposite, 0, 0, 0644, \
		$(XORG_LIB_XCOMPOSITE_DIR)/src/.libs/libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so.1.0.0)

	@$(call install_link, xorg-lib-Xcomposite, \
		libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so.1)

	@$(call install_link, xorg-lib-Xcomposite, \
		libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so)

	@$(call install_finish, xorg-lib-Xcomposite)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xcomposite.*
	rm -rf $(PKGDIR)/xorg-lib-Xcomposite_*
	rm -rf $(XORG_LIB_XCOMPOSITE_DIR)

# vim: syntax=make

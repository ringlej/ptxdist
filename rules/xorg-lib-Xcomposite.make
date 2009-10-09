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
PACKAGES-$(PTXCONF_XORG_LIB_XCOMPOSITE) += xorg-lib-xcomposite

#
# Paths and names
#
XORG_LIB_XCOMPOSITE_VERSION	:= 0.4.1
XORG_LIB_XCOMPOSITE		:= libXcomposite-$(XORG_LIB_XCOMPOSITE_VERSION)
XORG_LIB_XCOMPOSITE_SUFFIX	:= tar.bz2
XORG_LIB_XCOMPOSITE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCOMPOSITE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_get: $(STATEDIR)/xorg-lib-xcomposite.get

$(STATEDIR)/xorg-lib-xcomposite.get: $(xorg-lib-xcomposite_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XCOMPOSITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XCOMPOSITE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_extract: $(STATEDIR)/xorg-lib-xcomposite.extract

$(STATEDIR)/xorg-lib-xcomposite.extract: $(xorg-lib-xcomposite_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR))
	@$(call extract, XORG_LIB_XCOMPOSITE)
	@$(call patchin, XORG_LIB_XCOMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_prepare: $(STATEDIR)/xorg-lib-xcomposite.prepare

XORG_LIB_XCOMPOSITE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCOMPOSITE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCOMPOSITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xcomposite.prepare: $(xorg-lib-xcomposite_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR)/config.cache)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && \
		$(XORG_LIB_XCOMPOSITE_PATH) $(XORG_LIB_XCOMPOSITE_ENV) \
		./configure $(XORG_LIB_XCOMPOSITE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_compile: $(STATEDIR)/xorg-lib-xcomposite.compile

$(STATEDIR)/xorg-lib-xcomposite.compile: $(xorg-lib-xcomposite_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && $(XORG_LIB_XCOMPOSITE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_install: $(STATEDIR)/xorg-lib-xcomposite.install

$(STATEDIR)/xorg-lib-xcomposite.install: $(xorg-lib-xcomposite_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XCOMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_targetinstall: $(STATEDIR)/xorg-lib-xcomposite.targetinstall

$(STATEDIR)/xorg-lib-xcomposite.targetinstall: $(xorg-lib-xcomposite_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xcomposite)
	@$(call install_fixup, xorg-lib-xcomposite,PACKAGE,xorg-lib-xcomposite)
	@$(call install_fixup, xorg-lib-xcomposite,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xcomposite,VERSION,$(XORG_LIB_XCOMPOSITE_VERSION))
	@$(call install_fixup, xorg-lib-xcomposite,SECTION,base)
	@$(call install_fixup, xorg-lib-xcomposite,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xcomposite,DEPENDS,)
	@$(call install_fixup, xorg-lib-xcomposite,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xcomposite, 0, 0, 0644, \
		$(XORG_LIB_XCOMPOSITE_DIR)/src/.libs/libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so.1.0.0)

	@$(call install_link, xorg-lib-xcomposite, \
		libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so.1)

	@$(call install_link, xorg-lib-xcomposite, \
		libXcomposite.so.1.0.0, \
		$(XORG_LIBDIR)/libXcomposite.so)

	@$(call install_finish, xorg-lib-xcomposite)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xcomposite_clean:
	rm -rf $(STATEDIR)/xorg-lib-xcomposite.*
	rm -rf $(PKGDIR)/xorg-lib-xcomposite_*
	rm -rf $(XORG_LIB_XCOMPOSITE_DIR)

# vim: syntax=make

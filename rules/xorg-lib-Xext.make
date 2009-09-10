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
PACKAGES-$(PTXCONF_XORG_LIB_XEXT) += xorg-lib-xext

#
# Paths and names
#
XORG_LIB_XEXT_VERSION	:= 1.1.1
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.bz2
XORG_LIB_XEXT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xext_get: $(STATEDIR)/xorg-lib-xext.get

$(STATEDIR)/xorg-lib-xext.get: $(xorg-lib-xext_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xext_extract: $(STATEDIR)/xorg-lib-xext.extract

$(STATEDIR)/xorg-lib-xext.extract: $(xorg-lib-xext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEXT_DIR))
	@$(call extract, XORG_LIB_XEXT)
	@$(call patchin, XORG_LIB_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xext_prepare: $(STATEDIR)/xorg-lib-xext.prepare

XORG_LIB_XEXT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XEXT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XEXT_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xext.prepare: $(xorg-lib-xext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEXT_DIR)/config.cache)
	cd $(XORG_LIB_XEXT_DIR) && \
		$(XORG_LIB_XEXT_PATH) $(XORG_LIB_XEXT_ENV) \
		./configure $(XORG_LIB_XEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xext_compile: $(STATEDIR)/xorg-lib-xext.compile

$(STATEDIR)/xorg-lib-xext.compile: $(xorg-lib-xext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XEXT_DIR) && $(XORG_LIB_XEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xext_install: $(STATEDIR)/xorg-lib-xext.install

$(STATEDIR)/xorg-lib-xext.install: $(xorg-lib-xext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xext_targetinstall: $(STATEDIR)/xorg-lib-xext.targetinstall

$(STATEDIR)/xorg-lib-xext.targetinstall: $(xorg-lib-xext_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PACKAGE,xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xext,VERSION,$(XORG_LIB_XEXT_VERSION))
	@$(call install_fixup, xorg-lib-xext,SECTION,base)
	@$(call install_fixup, xorg-lib-xext,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xext,DEPENDS,)
	@$(call install_fixup, xorg-lib-xext,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xext, 0, 0, 0644, \
		$(XORG_LIB_XEXT_DIR)/src/.libs/libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so.6.4.0)

	@$(call install_link, xorg-lib-xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so.6)

	@$(call install_link, xorg-lib-xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so)

	@$(call install_finish, xorg-lib-xext)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xext_clean:
	rm -rf $(STATEDIR)/xorg-lib-xext.*
	rm -rf $(PKGDIR)/xorg-lib-xext_*
	rm -rf $(XORG_LIB_XEXT_DIR)

# vim: syntax=make

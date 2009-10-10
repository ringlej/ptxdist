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
PACKAGES-$(PTXCONF_XORG_LIB_XFT) += xorg-lib-xft

#
# Paths and names
#
XORG_LIB_XFT_VERSION	:= 2.1.14
XORG_LIB_XFT		:= libXft-$(XORG_LIB_XFT_VERSION)
XORG_LIB_XFT_SUFFIX	:= tar.bz2
XORG_LIB_XFT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX)
XORG_LIB_XFT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFT).$(XORG_LIB_XFT_SUFFIX)
XORG_LIB_XFT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xft_get: $(STATEDIR)/xorg-lib-xft.get

$(STATEDIR)/xorg-lib-xft.get: $(xorg-lib-xft_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XFT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XFT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xft_extract: $(STATEDIR)/xorg-lib-xft.extract

$(STATEDIR)/xorg-lib-xft.extract: $(xorg-lib-xft_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFT_DIR))
	@$(call extract, XORG_LIB_XFT)
	@$(call patchin, XORG_LIB_XFT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xft_prepare: $(STATEDIR)/xorg-lib-xft.prepare

XORG_LIB_XFT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xft.prepare: $(xorg-lib-xft_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFT_DIR)/config.cache)
	cd $(XORG_LIB_XFT_DIR) && \
		$(XORG_LIB_XFT_PATH) $(XORG_LIB_XFT_ENV) \
		./configure $(XORG_LIB_XFT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xft_compile: $(STATEDIR)/xorg-lib-xft.compile

$(STATEDIR)/xorg-lib-xft.compile: $(xorg-lib-xft_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XFT_DIR) && $(XORG_LIB_XFT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xft_install: $(STATEDIR)/xorg-lib-xft.install

$(STATEDIR)/xorg-lib-xft.install: $(xorg-lib-xft_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XFT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xft_targetinstall: $(STATEDIR)/xorg-lib-xft.targetinstall

$(STATEDIR)/xorg-lib-xft.targetinstall: $(xorg-lib-xft_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xft)
	@$(call install_fixup, xorg-lib-xft,PACKAGE,xorg-lib-xft)
	@$(call install_fixup, xorg-lib-xft,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xft,VERSION,$(XORG_LIB_XFT_VERSION))
	@$(call install_fixup, xorg-lib-xft,SECTION,base)
	@$(call install_fixup, xorg-lib-xft,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xft,DEPENDS,)
	@$(call install_fixup, xorg-lib-xft,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xft, 0, 0, 0644, \
		$(XORG_LIB_XFT_DIR)/src/.libs/libXft.so.2.1.13, \
		$(XORG_LIBDIR)/libXft.so.2.1.13)

	@$(call install_link, xorg-lib-xft, \
		libXft.so.2.1.13, \
		$(XORG_LIBDIR)/libXft.so.2)

	@$(call install_link, xorg-lib-xft, \
		libXft.so.2.1.13, \
		$(XORG_LIBDIR)/libXft.so)

	@$(call install_finish, xorg-lib-xft)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xft_clean:
	rm -rf $(STATEDIR)/xorg-lib-xft.*
	rm -rf $(PKGDIR)/xorg-lib-xft_*
	rm -rf $(XORG_LIB_XFT_DIR)

# vim: syntax=make

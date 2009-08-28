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
PACKAGES-$(PTXCONF_XORG_LIB_FONTENC) += xorg-lib-fontenc

#
# Paths and names
#
XORG_LIB_FONTENC_VERSION	:= 1.0.5
XORG_LIB_FONTENC		:= libfontenc-$(XORG_LIB_FONTENC_VERSION)
XORG_LIB_FONTENC_SUFFIX		:= tar.bz2
XORG_LIB_FONTENC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX)
XORG_LIB_FONTENC_SOURCE		:= $(SRCDIR)/$(XORG_LIB_FONTENC).$(XORG_LIB_FONTENC_SUFFIX)
XORG_LIB_FONTENC_DIR		:= $(BUILDDIR)/$(XORG_LIB_FONTENC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-fontenc_get: $(STATEDIR)/xorg-lib-fontenc.get

$(STATEDIR)/xorg-lib-fontenc.get: $(xorg-lib-fontenc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_FONTENC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_FONTENC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-fontenc_extract: $(STATEDIR)/xorg-lib-fontenc.extract

$(STATEDIR)/xorg-lib-fontenc.extract: $(xorg-lib-fontenc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FONTENC_DIR))
	@$(call extract, XORG_LIB_FONTENC)
	@$(call patchin, XORG_LIB_FONTENC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-fontenc_prepare: $(STATEDIR)/xorg-lib-fontenc.prepare

XORG_LIB_FONTENC_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_FONTENC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_FONTENC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-fontenc.prepare: $(xorg-lib-fontenc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FONTENC_DIR)/config.cache)
	cd $(XORG_LIB_FONTENC_DIR) && \
		$(XORG_LIB_FONTENC_PATH) $(XORG_LIB_FONTENC_ENV) \
		./configure $(XORG_LIB_FONTENC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-fontenc_compile: $(STATEDIR)/xorg-lib-fontenc.compile

$(STATEDIR)/xorg-lib-fontenc.compile: $(xorg-lib-fontenc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_FONTENC_DIR) && $(XORG_LIB_FONTENC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-fontenc_install: $(STATEDIR)/xorg-lib-fontenc.install

$(STATEDIR)/xorg-lib-fontenc.install: $(xorg-lib-fontenc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_FONTENC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-fontenc_targetinstall: $(STATEDIR)/xorg-lib-fontenc.targetinstall

$(STATEDIR)/xorg-lib-fontenc.targetinstall: $(xorg-lib-fontenc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-fontenc)
	@$(call install_fixup, xorg-lib-fontenc,PACKAGE,xorg-lib-fontenc)
	@$(call install_fixup, xorg-lib-fontenc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fontenc,VERSION,$(XORG_LIB_FONTENC_VERSION))
	@$(call install_fixup, xorg-lib-fontenc,SECTION,base)
	@$(call install_fixup, xorg-lib-fontenc,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fontenc,DEPENDS,)
	@$(call install_fixup, xorg-lib-fontenc,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-fontenc, 0, 0, 0644, \
		$(XORG_LIB_FONTENC_DIR)/src/.libs/libfontenc.so.1.0.0, \
		$(XORG_LIBDIR)/libfontenc.so.1.0.0)

	@$(call install_link, xorg-lib-fontenc, \
		libfontenc.so.1.0.0, \
		$(XORG_LIBDIR)/libfontenc.so.1)

	@$(call install_link, xorg-lib-fontenc, \
		libfontenc.so.1.0.0, \
		$(XORG_LIBDIR)/libfontenc.so)

	@$(call install_finish, xorg-lib-fontenc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-fontenc_clean:
	rm -rf $(STATEDIR)/xorg-lib-fontenc.*
	rm -rf $(PKGDIR)/xorg-lib-fontenc_*
	rm -rf $(XORG_LIB_FONTENC_DIR)

# vim: syntax=make

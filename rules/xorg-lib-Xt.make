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
PACKAGES-$(PTXCONF_XORG_LIB_XT) += xorg-lib-xt

#
# Paths and names
#
XORG_LIB_XT_VERSION	:= 1.0.7
XORG_LIB_XT		:= libXt-$(XORG_LIB_XT_VERSION)
XORG_LIB_XT_SUFFIX	:= tar.bz2
XORG_LIB_XT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX)
XORG_LIB_XT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX)
XORG_LIB_XT_DIR		:= $(BUILDDIR)/$(XORG_LIB_XT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xt_get: $(STATEDIR)/xorg-lib-xt.get

$(STATEDIR)/xorg-lib-xt.get: $(xorg-lib-xt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xt_extract: $(STATEDIR)/xorg-lib-xt.extract

$(STATEDIR)/xorg-lib-xt.extract: $(xorg-lib-xt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XT_DIR))
	@$(call extract, XORG_LIB_XT)
	@$(call patchin, XORG_LIB_XT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xt_prepare: $(STATEDIR)/xorg-lib-xt.prepare

XORG_LIB_XT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-install-makestrs \
	--disable-dependency-tracking

ifdef PTXCONF_XORG_LIB_X11_XKB
XORG_LIB_XT_AUTOCONF += --enable-xkb
else
XORG_LIB_XT_AUTOCONF += --disable-xkb
endif

$(STATEDIR)/xorg-lib-xt.prepare: $(xorg-lib-xt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XT_DIR)/config.cache)
	cd $(XORG_LIB_XT_DIR) && \
		$(XORG_LIB_XT_PATH) $(XORG_LIB_XT_ENV) \
		./configure $(XORG_LIB_XT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xt_compile: $(STATEDIR)/xorg-lib-xt.compile

$(STATEDIR)/xorg-lib-xt.compile: $(xorg-lib-xt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XT_DIR) && $(XORG_LIB_XT_PATH) $(MAKE) $(PARALLELMFLAGS) $(CROSS_ENV_CC_FOR_BUILD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xt_install: $(STATEDIR)/xorg-lib-xt.install

$(STATEDIR)/xorg-lib-xt.install: $(xorg-lib-xt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xt_targetinstall: $(STATEDIR)/xorg-lib-xt.targetinstall

$(STATEDIR)/xorg-lib-xt.targetinstall: $(xorg-lib-xt_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xt)
	@$(call install_fixup, xorg-lib-xt,PACKAGE,xorg-lib-xt)
	@$(call install_fixup, xorg-lib-xt,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xt,VERSION,$(XORG_LIB_XT_VERSION))
	@$(call install_fixup, xorg-lib-xt,SECTION,base)
	@$(call install_fixup, xorg-lib-xt,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xt,DEPENDS,)
	@$(call install_fixup, xorg-lib-xt,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xt, 0, 0, 0644, \
		$(XORG_LIB_XT_DIR)/src/.libs/libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so.6.0.0)

	@$(call install_link, xorg-lib-xt, \
		libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so.6)

	@$(call install_link, xorg-lib-xt, \
		libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so)

	@$(call install_finish, xorg-lib-xt)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xt_clean:
	rm -rf $(STATEDIR)/xorg-lib-xt.*
	rm -rf $(PKGDIR)/xorg-lib-xt_*
	rm -rf $(XORG_LIB_XT_DIR)

# vim: syntax=make

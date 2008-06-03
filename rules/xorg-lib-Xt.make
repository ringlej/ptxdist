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
PACKAGES-$(PTXCONF_XORG_LIB_XT) += xorg-lib-Xt

#
# Paths and names
#
XORG_LIB_XT_VERSION	:= 1.0.4
XORG_LIB_XT		:= libXt-$(XORG_LIB_XT_VERSION)
XORG_LIB_XT_SUFFIX	:= tar.bz2
XORG_LIB_XT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX)
XORG_LIB_XT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XT).$(XORG_LIB_XT_SUFFIX)
XORG_LIB_XT_DIR		:= $(BUILDDIR)/$(XORG_LIB_XT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xt_get: $(STATEDIR)/xorg-lib-Xt.get

$(STATEDIR)/xorg-lib-Xt.get: $(xorg-lib-Xt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xt_extract: $(STATEDIR)/xorg-lib-Xt.extract

$(STATEDIR)/xorg-lib-Xt.extract: $(xorg-lib-Xt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XT_DIR))
	@$(call extract, XORG_LIB_XT)
	@$(call patchin, XORG_LIB_XT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xt_prepare: $(STATEDIR)/xorg-lib-Xt.prepare

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

$(STATEDIR)/xorg-lib-Xt.prepare: $(xorg-lib-Xt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XT_DIR)/config.cache)
	cd $(XORG_LIB_XT_DIR) && \
		$(XORG_LIB_XT_PATH) $(XORG_LIB_XT_ENV) \
		./configure $(XORG_LIB_XT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xt_compile: $(STATEDIR)/xorg-lib-Xt.compile

$(STATEDIR)/xorg-lib-Xt.compile: $(xorg-lib-Xt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XT_DIR) && $(XORG_LIB_XT_PATH) $(MAKE) $(PARALLELMFLAGS) $(CROSS_ENV_CC_FOR_BUILD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xt_install: $(STATEDIR)/xorg-lib-Xt.install

$(STATEDIR)/xorg-lib-Xt.install: $(xorg-lib-Xt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xt_targetinstall: $(STATEDIR)/xorg-lib-Xt.targetinstall

$(STATEDIR)/xorg-lib-Xt.targetinstall: $(xorg-lib-Xt_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xt)
	@$(call install_fixup, xorg-lib-Xt,PACKAGE,xorg-lib-xt)
	@$(call install_fixup, xorg-lib-Xt,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xt,VERSION,$(XORG_LIB_XT_VERSION))
	@$(call install_fixup, xorg-lib-Xt,SECTION,base)
	@$(call install_fixup, xorg-lib-Xt,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xt,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xt,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xt, 0, 0, 0644, \
		$(XORG_LIB_XT_DIR)/src/.libs/libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so.6.0.0)

	@$(call install_link, xorg-lib-Xt, \
		libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so.6)

	@$(call install_link, xorg-lib-Xt, \
		libXt.so.6.0.0, \
		$(XORG_LIBDIR)/libXt.so)

	@$(call install_finish, xorg-lib-Xt)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xt_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xt.*
	rm -rf $(PKGDIR)/xorg-lib-Xt_*
	rm -rf $(XORG_LIB_XT_DIR)

# vim: syntax=make

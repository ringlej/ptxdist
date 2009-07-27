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
PACKAGES-$(PTXCONF_XORG_LIB_APPLEWM) += xorg-lib-applewm

#
# Paths and names
#
XORG_LIB_APPLEWM_VERSION	:= 1.3.0
XORG_LIB_APPLEWM		:= libAppleWM-$(XORG_LIB_APPLEWM_VERSION)
XORG_LIB_APPLEWM_SUFFIX		:= tar.bz2
XORG_LIB_APPLEWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_APPLEWM).$(XORG_LIB_APPLEWM_SUFFIX)
XORG_LIB_APPLEWM_SOURCE		:= $(SRCDIR)/$(XORG_LIB_APPLEWM).$(XORG_LIB_APPLEWM_SUFFIX)
XORG_LIB_APPLEWM_DIR		:= $(BUILDDIR)/$(XORG_LIB_APPLEWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-applewm_get: $(STATEDIR)/xorg-lib-applewm.get

$(STATEDIR)/xorg-lib-applewm.get: $(xorg-lib-applewm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_APPLEWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_APPLEWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-applewm_extract: $(STATEDIR)/xorg-lib-applewm.extract

$(STATEDIR)/xorg-lib-applewm.extract: $(xorg-lib-applewm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_APPLEWM_DIR))
	@$(call extract, XORG_LIB_APPLEWM)
	@$(call patchin, XORG_LIB_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-applewm_prepare: $(STATEDIR)/xorg-lib-applewm.prepare

XORG_LIB_APPLEWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_APPLEWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_APPLEWM_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_APPLEWM_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-applewm.prepare: $(xorg-lib-applewm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_APPLEWM_DIR)/config.cache)
	cd $(XORG_LIB_APPLEWM_DIR) && \
		$(XORG_LIB_APPLEWM_PATH) $(XORG_LIB_APPLEWM_ENV) \
		./configure $(XORG_LIB_APPLEWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-applewm_compile: $(STATEDIR)/xorg-lib-applewm.compile

$(STATEDIR)/xorg-lib-applewm.compile: $(xorg-lib-applewm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_APPLEWM_DIR) && $(XORG_LIB_APPLEWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-applewm_install: $(STATEDIR)/xorg-lib-applewm.install

$(STATEDIR)/xorg-lib-applewm.install: $(xorg-lib-applewm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-applewm_targetinstall: $(STATEDIR)/xorg-lib-applewm.targetinstall

$(STATEDIR)/xorg-lib-applewm.targetinstall: $(xorg-lib-applewm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  xorg-lib-applewm)
	@$(call install_fixup, xorg-lib-applewm,PACKAGE,xorg-lib-apple-wm)
	@$(call install_fixup, xorg-lib-applewm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-applewm,VERSION,$(XORG_LIB_APPLEWM_VERSION))
	@$(call install_fixup, xorg-lib-applewm,SECTION,base)
	@$(call install_fixup, xorg-lib-applewm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-applewm,DEPENDS,)
	@$(call install_fixup, xorg-lib-applewm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-applewm, 0, 0, 0644, \
		$(XORG_LIB_APPLEWM_DIR)/src/.libs/libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so.7.0.0)

	@$(call install_link, xorg-lib-applewm, \
		libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so.7)

	@$(call install_link, xorg-lib-applewm, \
		libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so)

	@$(call install_finish, xorg-lib-applewm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-applewm_clean:
	rm -rf $(STATEDIR)/xorg-lib-applewm.*
	rm -rf $(PKGDIR)/xorg-lib-applewm_*
	rm -rf $(XORG_LIB_APPLEWM_DIR)

# vim: syntax=make

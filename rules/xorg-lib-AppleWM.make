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
PACKAGES-$(PTXCONF_XORG_LIB_APPLEWM) += xorg-lib-AppleWM

#
# Paths and names
#
XORG_LIB_APPLEWM_VERSION	:= 1.0.0
XORG_LIB_APPLEWM		:= libAppleWM-$(XORG_LIB_APPLEWM_VERSION)
XORG_LIB_APPLEWM_SUFFIX		:= tar.bz2
XORG_LIB_APPLEWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_APPLEWM).$(XORG_LIB_APPLEWM_SUFFIX)
XORG_LIB_APPLEWM_SOURCE		:= $(SRCDIR)/$(XORG_LIB_APPLEWM).$(XORG_LIB_APPLEWM_SUFFIX)
XORG_LIB_APPLEWM_DIR		:= $(BUILDDIR)/$(XORG_LIB_APPLEWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_get: $(STATEDIR)/xorg-lib-AppleWM.get

$(STATEDIR)/xorg-lib-AppleWM.get: $(xorg-lib-AppleWM_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_APPLEWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_APPLEWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_extract: $(STATEDIR)/xorg-lib-AppleWM.extract

$(STATEDIR)/xorg-lib-AppleWM.extract: $(xorg-lib-AppleWM_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_APPLEWM_DIR))
	@$(call extract, XORG_LIB_APPLEWM)
	@$(call patchin, XORG_LIB_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_prepare: $(STATEDIR)/xorg-lib-AppleWM.prepare

XORG_LIB_APPLEWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_APPLEWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_APPLEWM_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_APPLEWM_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-AppleWM.prepare: $(xorg-lib-AppleWM_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_APPLEWM_DIR)/config.cache)
	cd $(XORG_LIB_APPLEWM_DIR) && \
		$(XORG_LIB_APPLEWM_PATH) $(XORG_LIB_APPLEWM_ENV) \
		./configure $(XORG_LIB_APPLEWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_compile: $(STATEDIR)/xorg-lib-AppleWM.compile

$(STATEDIR)/xorg-lib-AppleWM.compile: $(xorg-lib-AppleWM_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_APPLEWM_DIR) && $(XORG_LIB_APPLEWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_install: $(STATEDIR)/xorg-lib-AppleWM.install

$(STATEDIR)/xorg-lib-AppleWM.install: $(xorg-lib-AppleWM_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_targetinstall: $(STATEDIR)/xorg-lib-AppleWM.targetinstall

$(STATEDIR)/xorg-lib-AppleWM.targetinstall: $(xorg-lib-AppleWM_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-AppleWM)
	@$(call install_fixup, xorg-lib-AppleWM,PACKAGE,xorg-lib-apple-wm)
	@$(call install_fixup, xorg-lib-AppleWM,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-AppleWM,VERSION,$(XORG_LIB_APPLEWM_VERSION))
	@$(call install_fixup, xorg-lib-AppleWM,SECTION,base)
	@$(call install_fixup, xorg-lib-AppleWM,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-AppleWM,DEPENDS,)
	@$(call install_fixup, xorg-lib-AppleWM,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-AppleWM, 0, 0, 0644, \
		$(XORG_LIB_APPLEWM_DIR)/src/.libs/libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so.7.0.0)

	@$(call install_link, xorg-lib-AppleWM, \
		libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so.7)

	@$(call install_link, xorg-lib-AppleWM, \
		libAppleWM.so.7.0.0, \
		$(XORG_LIBDIR)/libAppleWM.so)

	@$(call install_finish, xorg-lib-AppleWM)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-AppleWM_clean:
	rm -rf $(STATEDIR)/xorg-lib-AppleWM.*
	rm -rf $(PKGDIR)/xorg-lib-AppleWM_*
	rm -rf $(XORG_LIB_APPLEWM_DIR)

# vim: syntax=make

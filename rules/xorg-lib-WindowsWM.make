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
PACKAGES-$(PTXCONF_XORG_LIB_WINDOWSWM) += xorg-lib-windowswm

#
# Paths and names
#
XORG_LIB_WINDOWSWM_VERSION	:= 1.0.1
XORG_LIB_WINDOWSWM		:= libWindowsWM-$(XORG_LIB_WINDOWSWM_VERSION)
XORG_LIB_WINDOWSWM_SUFFIX	:= tar.bz2
XORG_LIB_WINDOWSWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_DIR		:= $(BUILDDIR)/$(XORG_LIB_WINDOWSWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-windowswm_get: $(STATEDIR)/xorg-lib-windowswm.get

$(STATEDIR)/xorg-lib-windowswm.get: $(xorg-lib-windowswm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_WINDOWSWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_WINDOWSWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-windowswm_extract: $(STATEDIR)/xorg-lib-windowswm.extract

$(STATEDIR)/xorg-lib-windowswm.extract: $(xorg-lib-windowswm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_WINDOWSWM_DIR))
	@$(call extract, XORG_LIB_WINDOWSWM)
	@$(call patchin, XORG_LIB_WINDOWSWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-windowswm_prepare: $(STATEDIR)/xorg-lib-windowswm.prepare

XORG_LIB_WINDOWSWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_WINDOWSWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_WINDOWSWM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-windowswm.prepare: $(xorg-lib-windowswm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_WINDOWSWM_DIR)/config.cache)
	cd $(XORG_LIB_WINDOWSWM_DIR) && \
		$(XORG_LIB_WINDOWSWM_PATH) $(XORG_LIB_WINDOWSWM_ENV) \
		./configure $(XORG_LIB_WINDOWSWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-windowswm_compile: $(STATEDIR)/xorg-lib-windowswm.compile

$(STATEDIR)/xorg-lib-windowswm.compile: $(xorg-lib-windowswm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_WINDOWSWM_DIR) && $(XORG_LIB_WINDOWSWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-windowswm_install: $(STATEDIR)/xorg-lib-windowswm.install

$(STATEDIR)/xorg-lib-windowswm.install: $(xorg-lib-windowswm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_WINDOWSWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-windowswm_targetinstall: $(STATEDIR)/xorg-lib-windowswm.targetinstall

$(STATEDIR)/xorg-lib-windowswm.targetinstall: $(xorg-lib-windowswm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-windowswm)
	@$(call install_fixup, xorg-lib-windowswm,PACKAGE,xorg-lib-windowswm)
	@$(call install_fixup, xorg-lib-windowswm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-windowswm,VERSION,$(XORG_LIB_WINDOWSWM_VERSION))
	@$(call install_fixup, xorg-lib-windowswm,SECTION,base)
	@$(call install_fixup, xorg-lib-windowswm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-windowswm,DEPENDS,)
	@$(call install_fixup, xorg-lib-windowswm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-windowswm, 0, 0, 0644, \
		$(XORG_LIB_WINDOWSWM_DIR)/src/.libs/libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so.7.0.0)

	@$(call install_link, xorg-lib-windowswm, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so.7)

	@$(call install_link, xorg-lib-windowswm, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so)

	@$(call install_finish, xorg-lib-windowswm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-windowswm_clean:
	rm -rf $(STATEDIR)/xorg-lib-windowswm.*
	rm -rf $(PKGDIR)/xorg-lib-windowswm_*
	rm -rf $(XORG_LIB_WINDOWSWM_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_XORG_LIB_WINDOWSWM) += xorg-lib-WindowsWM

#
# Paths and names
#
XORG_LIB_WINDOWSWM_VERSION	:= 1.0.0
XORG_LIB_WINDOWSWM		:= libWindowsWM-$(XORG_LIB_WINDOWSWM_VERSION)
XORG_LIB_WINDOWSWM_SUFFIX	:= tar.bz2
XORG_LIB_WINDOWSWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib//$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_WINDOWSWM).$(XORG_LIB_WINDOWSWM_SUFFIX)
XORG_LIB_WINDOWSWM_DIR		:= $(BUILDDIR)/$(XORG_LIB_WINDOWSWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_get: $(STATEDIR)/xorg-lib-WindowsWM.get

$(STATEDIR)/xorg-lib-WindowsWM.get: $(xorg-lib-WindowsWM_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_WINDOWSWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_WINDOWSWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_extract: $(STATEDIR)/xorg-lib-WindowsWM.extract

$(STATEDIR)/xorg-lib-WindowsWM.extract: $(xorg-lib-WindowsWM_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_WINDOWSWM_DIR))
	@$(call extract, XORG_LIB_WINDOWSWM)
	@$(call patchin, XORG_LIB_WINDOWSWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_prepare: $(STATEDIR)/xorg-lib-WindowsWM.prepare

XORG_LIB_WINDOWSWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_WINDOWSWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_WINDOWSWM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-WindowsWM.prepare: $(xorg-lib-WindowsWM_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_WINDOWSWM_DIR)/config.cache)
	cd $(XORG_LIB_WINDOWSWM_DIR) && \
		$(XORG_LIB_WINDOWSWM_PATH) $(XORG_LIB_WINDOWSWM_ENV) \
		./configure $(XORG_LIB_WINDOWSWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_compile: $(STATEDIR)/xorg-lib-WindowsWM.compile

$(STATEDIR)/xorg-lib-WindowsWM.compile: $(xorg-lib-WindowsWM_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_WINDOWSWM_DIR) && $(XORG_LIB_WINDOWSWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_install: $(STATEDIR)/xorg-lib-WindowsWM.install

$(STATEDIR)/xorg-lib-WindowsWM.install: $(xorg-lib-WindowsWM_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_WINDOWSWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_targetinstall: $(STATEDIR)/xorg-lib-WindowsWM.targetinstall

$(STATEDIR)/xorg-lib-WindowsWM.targetinstall: $(xorg-lib-WindowsWM_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-WindowsWM)
	@$(call install_fixup, xorg-lib-WindowsWM,PACKAGE,xorg-lib-windowswm)
	@$(call install_fixup, xorg-lib-WindowsWM,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-WindowsWM,VERSION,$(XORG_LIB_WINDOWSWM_VERSION))
	@$(call install_fixup, xorg-lib-WindowsWM,SECTION,base)
	@$(call install_fixup, xorg-lib-WindowsWM,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-WindowsWM,DEPENDS,)
	@$(call install_fixup, xorg-lib-WindowsWM,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-WindowsWM, 0, 0, 0644, \
		$(XORG_LIB_WINDOWSWM_DIR)/src/.libs/libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so.7.0.0)

	@$(call install_link, xorg-lib-WindowsWM, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so.7)

	@$(call install_link, xorg-lib-WindowsWM, \
		libWindowsWM.so.7.0.0, \
		$(XORG_LIBDIR)/libWindowsWM.so)

	@$(call install_finish, xorg-lib-WindowsWM)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-WindowsWM_clean:
	rm -rf $(STATEDIR)/xorg-lib-WindowsWM.*
	rm -rf $(IMAGEDIR)/xorg-lib-WindowsWM_*
	rm -rf $(XORG_LIB_WINDOWSWM_DIR)

# vim: syntax=make

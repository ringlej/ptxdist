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
PACKAGES-$(PTXCONF_XORG_LIB_XKBUI) += xorg-lib-xkbui

#
# Paths and names
#
XORG_LIB_XKBUI_VERSION	:= 1.0.2
XORG_LIB_XKBUI		:= libxkbui-$(XORG_LIB_XKBUI_VERSION)
XORG_LIB_XKBUI_SUFFIX	:= tar.bz2
XORG_LIB_XKBUI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XKBUI).$(XORG_LIB_XKBUI_SUFFIX)
XORG_LIB_XKBUI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XKBUI).$(XORG_LIB_XKBUI_SUFFIX)
XORG_LIB_XKBUI_DIR	:= $(BUILDDIR)/$(XORG_LIB_XKBUI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xkbui_get: $(STATEDIR)/xorg-lib-xkbui.get

$(STATEDIR)/xorg-lib-xkbui.get: $(xorg-lib-xkbui_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XKBUI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XKBUI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xkbui_extract: $(STATEDIR)/xorg-lib-xkbui.extract

$(STATEDIR)/xorg-lib-xkbui.extract: $(xorg-lib-xkbui_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XKBUI_DIR))
	@$(call extract, XORG_LIB_XKBUI)
	@$(call patchin, XORG_LIB_XKBUI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xkbui_prepare: $(STATEDIR)/xorg-lib-xkbui.prepare

XORG_LIB_XKBUI_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XKBUI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XKBUI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xkbui.prepare: $(xorg-lib-xkbui_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XKBUI_DIR)/config.cache)
	cd $(XORG_LIB_XKBUI_DIR) && \
		$(XORG_LIB_XKBUI_PATH) $(XORG_LIB_XKBUI_ENV) \
		./configure $(XORG_LIB_XKBUI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xkbui_compile: $(STATEDIR)/xorg-lib-xkbui.compile

$(STATEDIR)/xorg-lib-xkbui.compile: $(xorg-lib-xkbui_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XKBUI_DIR) && $(XORG_LIB_XKBUI_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xkbui_install: $(STATEDIR)/xorg-lib-xkbui.install

$(STATEDIR)/xorg-lib-xkbui.install: $(xorg-lib-xkbui_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XKBUI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xkbui_targetinstall: $(STATEDIR)/xorg-lib-xkbui.targetinstall

$(STATEDIR)/xorg-lib-xkbui.targetinstall: $(xorg-lib-xkbui_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xkbui)
	@$(call install_fixup, xorg-lib-xkbui,PACKAGE,xorg-lib-xkbui)
	@$(call install_fixup, xorg-lib-xkbui,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xkbui,VERSION,$(XORG_LIB_XKBUI_VERSION))
	@$(call install_fixup, xorg-lib-xkbui,SECTION,base)
	@$(call install_fixup, xorg-lib-xkbui,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xkbui,DEPENDS,)
	@$(call install_fixup, xorg-lib-xkbui,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xkbui, 0, 0, 0644, \
		$(XORG_LIB_XKBUI_DIR)/src/.libs/libxkbui.so.1.0.0, \
		$(XORG_LIBDIR)/libxkbui.so.1.0.0)

	@$(call install_link, xorg-lib-xkbui, \
		libxkbui.so.1.0.0, \
		$(XORG_LIBDIR)/libxkbui.so.1)

	@$(call install_link, xorg-lib-xkbui, \
		libxkbui.so.1.0.0, \
		$(XORG_LIBDIR)/libxkbui.so)

	@$(call install_finish, xorg-lib-xkbui)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xkbui_clean:
	rm -rf $(STATEDIR)/xorg-lib-xkbui.*
	rm -rf $(IMAGEDIR)/xorg-lib-xkbui_*
	rm -rf $(XORG_LIB_XKBUI_DIR)

# vim: syntax=make
